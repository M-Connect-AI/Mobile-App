import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/data/model/chat/chat_api_models.dart';
import 'package:chatbot_project/data/source/remote/agent_chat_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'decodes fragmented named SSE events and sends backend request shape',
    () async {
      RequestOptions? captured;
      final sse = [
        'event: status\ndata: {"label":"Đang chuẩn bị đề xuất đơn…"}\n\n',
        'event: token\r\ndata: {"text":\r\ndata: "Xin chào"}\r\n\r\n',
        'event: confirm\ndata: {"tool":"create_leave","args":{"type":"ANNUAL"},"summary":"Gửi đơn"}\n\n',
        'event: result\ndata: {"executed":{"_id":"leave-id"}}\n\n',
        'event: done\ndata: {"threadId":"thread-1","citations":["Quy định nghỉ phép"]}\n\n',
      ].join();
      final dio = Dio()
        ..httpClientAdapter = _MockAdapter((request) {
          captured = request;
          return _streamResponse(200, _fragment(sse, 7));
        });
      final source = AgentChatRemoteDataSource(
        baseUrl: 'http://agent.test',
        dio: dio,
      );

      final events = await source
          .streamTurn(
            'jwt',
            const ChatTurnRequestDto(
              message: 'Tạo đơn',
              threadId: 'thread-1',
              confirm: true,
            ),
          )
          .toList();

      expect(
        captured?.uri.toString(),
        'http://agent.test/api/agent/chat/stream',
      );
      expect(captured?.headers['Authorization'], 'Bearer jwt');
      expect(captured?.data, {
        'message': 'Tạo đơn',
        'threadId': 'thread-1',
        'confirm': true,
      });
      expect(events[0], isA<AgentStatusEvent>());
      expect(
        (events[0] as AgentStatusEvent).label,
        'Đang chuẩn bị đề xuất đơn…',
      );
      expect(events[1], isA<AgentTokenEvent>());
      expect((events[1] as AgentTokenEvent).text, 'Xin chào');
      expect(events[2], isA<AgentConfirmationEvent>());
      expect(events[3], isA<AgentResultEvent>());
      expect(events[4], isA<AgentDoneEvent>());
      expect((events[4] as AgentDoneEvent).citations, ['Quy định nghỉ phép']);
    },
  );

  test(
    'omits nullable request fields and emits interrupted without terminal event',
    () async {
      RequestOptions? captured;
      final source = AgentChatRemoteDataSource(
        baseUrl: 'http://localhost:3001',
        dio: Dio()
          ..httpClientAdapter = _MockAdapter((request) {
            captured = request;
            return _streamResponse(200, [
              utf8.encode('event: token\ndata: {"text":"dở dang"}\n\n'),
            ]);
          }),
      );

      final events = await source
          .streamTurn('jwt', const ChatTurnRequestDto(message: 'hello'))
          .toList();

      expect(captured?.data, {'message': 'hello'});
      expect(events.last, isA<AgentInterruptedEvent>());
    },
  );

  test('maps backend error SSE as a terminal event', () async {
    final source = AgentChatRemoteDataSource(
      baseUrl: 'http://localhost:3001',
      dio: Dio()
        ..httpClientAdapter = _MockAdapter(
          (_) => _streamResponse(200, [
            utf8.encode(
              'event: error\ndata: {"message":"Không đủ ngày phép"}\n\n',
            ),
          ]),
        ),
    );

    final events = await source
        .streamTurn('jwt', const ChatTurnRequestDto(message: 'Tạo đơn'))
        .toList();

    expect(events, hasLength(1));
    expect(
      events.single,
      isA<AgentErrorEvent>().having(
        (event) => event.message,
        'message',
        'Không đủ ngày phép',
      ),
    );
  });

  test('decodes thread list and empty list', () async {
    final source = AgentChatRemoteDataSource(
      baseUrl: 'http://localhost:3001',
      dio: Dio()
        ..httpClientAdapter = _MockAdapter(
          (_) => _jsonResponse(200, <Object>[]),
        ),
    );

    expect(await source.getThreads('jwt'), isEmpty);
  });

  test('maps pre-stream 401 JSON error', () async {
    final source = AgentChatRemoteDataSource(
      baseUrl: 'http://localhost:3001',
      dio: Dio()
        ..httpClientAdapter = _MockAdapter(
          (_) => _jsonResponse(401, {'message': 'Unauthorized'}),
        ),
    );

    await expectLater(
      source
          .streamTurn('expired', const ChatTurnRequestDto(message: 'hello'))
          .toList(),
      throwsA(
        isA<AgentRemoteException>().having(
          (error) => error.type,
          'type',
          AgentRemoteErrorType.unauthorized,
        ),
      ),
    );
  });
}

List<List<int>> _fragment(String value, int size) {
  final bytes = utf8.encode(value);
  return [
    for (var offset = 0; offset < bytes.length; offset += size)
      bytes.sublist(offset, (offset + size).clamp(0, bytes.length)),
  ];
}

ResponseBody _streamResponse(int statusCode, List<List<int>> chunks) =>
    ResponseBody(
      Stream<Uint8List>.fromIterable(chunks.map(Uint8List.fromList)),
      statusCode,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream; charset=utf-8'],
      },
    );

ResponseBody _jsonResponse(int statusCode, Object body) =>
    ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this.handler);

  final FutureOr<ResponseBody> Function(RequestOptions) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => handler(options);

  @override
  void close({bool force = false}) {}
}
