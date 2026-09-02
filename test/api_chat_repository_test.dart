import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/features/chat/data/api_chat_repository.dart';
import 'package:chatbot_project/features/chat/data/chat_repository.dart';
import 'package:chatbot_project/features/chat/models/chat_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sends speech transcript to VNG AI Platform chat completions', () async {
    final dio = _mockDio((request) {
      expect(request.method, 'POST');
      expect(
        request.uri.toString(),
        'https://maas.example.com/v1/chat/completions',
      );
      expect(request.headers['Authorization'], 'Bearer test-api-key');
      final body = request.data as Map<String, dynamic>;
      expect(body['model'], 'test-model');
      expect(body['max_tokens'], 1536);
      expect(body['temperature'], 0.2);
      expect(body['top_p'], 0.95);
      expect(body['stream'], isTrue);
      expect(body['response_format'], {'type': 'json_object'});
      final messages = body['messages'] as List<dynamic>;
      expect(messages.first['role'], 'system');
      expect(messages.first['content'], 'business-trip-system-prompt');
      expect(messages.last, {
        'role': 'user',
        'content': 'Chuyển 500k cho Nguyễn Văn A',
      });
      return ResponseBody.fromString(
        _sse(['Bạn muốn chuyển ', 'từ tài khoản nào?']),
        200,
        headers: {
          Headers.contentTypeHeader: ['text/event-stream; charset=utf-8'],
        },
      );
    });
    final repository = ApiChatRepository(
      baseUrl: 'https://maas.example.com/v1/',
      apiKey: 'test-api-key',
      model: 'test-model',
      systemPromptBuilder: () => 'business-trip-system-prompt',
      dio: dio,
    );

    final response = await repository
        .sendVoiceMessage('Chuyển 500k cho Nguyễn Văn A')
        .single;

    expect(response.content, 'Bạn muốn chuyển từ tài khoản nào?');
    repository.close();
  });

  test('exposes API error message for retry flow', () async {
    final dio = _mockDio(
      (_) => ResponseBody.fromString(
        jsonEncode({
          'error': {'message': 'Không thể gửi tin nhắn'},
        }),
        503,
        headers: {
          Headers.contentTypeHeader: ['application/json'],
        },
      ),
    );
    final repository = ApiChatRepository(
      baseUrl: 'https://maas.example.com/v1',
      apiKey: 'test-api-key',
      model: 'test-model',
      systemPromptBuilder: () => 'business-trip-system-prompt',
      dio: dio,
    );

    await expectLater(
      repository.sendTextMessage('Xin chào'),
      emitsError(
        isA<ChatRepositoryException>().having(
          (error) => error.message,
          'message',
          'Không thể gửi tin nhắn',
        ),
      ),
    );
    repository.close();
  });

  test('returns only confirmation_question from streamed JSON', () async {
    const structuredContent = '''
{
  "intent": "CREATE_BUSINESS_TRIP",
  "normalized_text": "Tôi cần tạo đơn từ ngày 14 tháng 5 tới mùng 7 tháng 6.",
  "fields": {
    "destination": {"value": null},
    "start_date": {"value": "2024-05-14"},
    "end_date": {"value": "2024-06-07"},
    "duration_days": {"value": null},
    "purpose": {"value": null},
    "employee": {"value": null},
    "customer": {"value": null},
    "transportation": {"value": null}
  },
  "needs_confirmation": true,
  "confirmation_question": "Vui lòng bổ sung điểm đến và xác nhận ngày kết thúc."
}
''';
    final dio = _mockDio(
      (_) => ResponseBody.fromString(
        _sse([
          '```json\n',
          structuredContent.substring(0, structuredContent.length ~/ 2),
          structuredContent.substring(structuredContent.length ~/ 2),
          '\n```',
        ]),
        200,
        headers: {
          Headers.contentTypeHeader: ['text/event-stream; charset=utf-8'],
        },
      ),
    );
    final repository = ApiChatRepository(
      baseUrl: 'https://maas.example.com/v1',
      apiKey: 'test-api-key',
      model: 'test-model',
      dio: dio,
    );

    final responses = await repository
        .sendTextMessage('Tạo đơn công tác')
        .toList();

    expect(responses.length, greaterThan(1));
    expect(responses.first.status, MessageStatus.processing);
    expect(
      responses.last.content,
      'Vui lòng bổ sung điểm đến và xác nhận ngày kết thúc.',
    );
    expect(responses.last.status, MessageStatus.success);
    repository.close();
  });

  test(
    'builds a fallback question when confirmation_question is missing',
    () async {
      final dio = _mockDio(
        (_) => ResponseBody.fromString(
          _sse([
            jsonEncode({
              'intent': 'CREATE_BUSINESS_TRIP',
              'missing_fields': ['destination', 'employee'],
              'ambiguous_fields': [
                {'field': 'end_date', 'candidates': []},
              ],
              'needs_confirmation': true,
            }),
          ]),
          200,
          headers: {
            Headers.contentTypeHeader: ['text/event-stream; charset=utf-8'],
          },
        ),
      );
      final repository = ApiChatRepository(
        baseUrl: 'https://maas.example.com/v1',
        apiKey: 'test-api-key',
        model: 'test-model',
        dio: dio,
      );

      final response = await repository.sendTextMessage('Tạo đơn').last;

      expect(
        response.content,
        'Vui lòng cung cấp thêm điểm đến và nhân viên thực hiện. '
        'Vui lòng xác nhận lại ngày kết thúc.',
      );
      repository.close();
    },
  );
}

Dio _mockDio(FutureOr<ResponseBody> Function(RequestOptions) handler) {
  return Dio()..httpClientAdapter = _MockAdapter(handler);
}

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this.handler);

  final FutureOr<ResponseBody> Function(RequestOptions) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

String _sse(List<String> chunks) {
  final events = chunks.map(
    (chunk) =>
        'data: ${jsonEncode({
          'choices': [
            {
              'delta': {'content': chunk},
            },
          ],
        })}\n\n',
  );
  return '${events.join()}data: [DONE]\n\n';
}
