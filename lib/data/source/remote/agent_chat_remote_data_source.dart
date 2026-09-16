import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../model/chat/chat_api_models.dart';
import 'agent_api_url.dart';

enum AgentRemoteErrorType { unauthorized, notFound, network, server, malformed }

class AgentRemoteException implements Exception {
  const AgentRemoteException({required this.type, required this.message, this.statusCode});

  final AgentRemoteErrorType type;
  final String message;
  final int? statusCode;
}

sealed class AgentSseEvent {
  const AgentSseEvent();
}

class AgentTokenEvent extends AgentSseEvent {
  const AgentTokenEvent(this.text);
  final String text;
}

class AgentStatusEvent extends AgentSseEvent {
  const AgentStatusEvent(this.label);
  final String label;
}

class AgentConfirmationEvent extends AgentSseEvent {
  const AgentConfirmationEvent(this.confirmation);
  final ChatConfirmationDto confirmation;
}

class AgentResultEvent extends AgentSseEvent {
  const AgentResultEvent(this.executed);
  final Object? executed;
}

class AgentDoneEvent extends AgentSseEvent {
  const AgentDoneEvent({required this.threadId, required this.citations});
  final String threadId;
  final List<String> citations;
}

class AgentErrorEvent extends AgentSseEvent {
  const AgentErrorEvent(this.message);
  final String message;
}

class AgentInterruptedEvent extends AgentSseEvent {
  const AgentInterruptedEvent();
}

class AgentChatRemoteDataSource {
  AgentChatRemoteDataSource({required String baseUrl, Dio? dio, this.timeout = const Duration(seconds: 60)})
    : _baseUrl = normalizeAgentApiBaseUrl(baseUrl),
      _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;
  final Duration timeout;

  Future<List<ChatThreadSummaryDto>> getThreads(String accessToken) async {
    final data = await _get('/chat/threads', accessToken);
    if (data is! List) throw _malformed();
    try {
      return data
          .map((item) => ChatThreadSummaryDto.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on Object {
      throw _malformed();
    }
  }

  Future<ChatThreadDetailDto> getThread(String accessToken, String threadId) async {
    final encodedId = Uri.encodeComponent(threadId);
    final data = await _get('/chat/threads/$encodedId', accessToken);
    if (data is! Map) throw _malformed();
    try {
      return ChatThreadDetailDto.fromJson(Map<String, dynamic>.from(data));
    } on Object {
      throw _malformed();
    }
  }

  Stream<AgentSseEvent> streamTurn(String accessToken, ChatTurnRequestDto request) async* {
    try {
      final response = await _dio.post<ResponseBody>(
        '$_baseUrl/chat/stream',
        data: request.toJson(),
        options: Options(
          headers: {
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          responseType: ResponseType.stream,
          sendTimeout: timeout,
          receiveTimeout: timeout,
          validateStatus: (_) => true,
        ),
      );
      final body = response.data;
      if (body == null) throw _malformed();
      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        final bytes = await body.stream.fold<List<int>>(<int>[], (buffer, chunk) => buffer..addAll(chunk));
        throw _httpError(statusCode, _decodeJson(bytes));
      }

      var terminalEventSeen = false;
      await for (final event in _decodeSse(body.stream.cast<List<int>>())) {
        final decoded = _mapSseEvent(event.name, event.data);
        if (decoded == null) continue;
        if (decoded is AgentDoneEvent || decoded is AgentErrorEvent) {
          terminalEventSeen = true;
        }
        yield decoded;
      }
      if (!terminalEventSeen) yield const AgentInterruptedEvent();
    } on AgentRemoteException {
      rethrow;
    } on TimeoutException {
      throw const AgentRemoteException(
        type: AgentRemoteErrorType.network,
        message: 'Máy chủ phản hồi quá lâu. Vui lòng thử lại.',
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const AgentRemoteException(
          type: AgentRemoteErrorType.network,
          message: 'Không thể kết nối tới máy chủ chatbot.',
        );
      }
      throw const AgentRemoteException(
        type: AgentRemoteErrorType.server,
        message: 'Không thể xử lý phản hồi từ máy chủ chatbot.',
      );
    } on Object {
      throw _malformed();
    }
  }

  Future<Object?> _get(String path, String accessToken) async {
    try {
      final response = await _dio.get<Object?>(
        '$_baseUrl$path',
        options: Options(
          headers: {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'},
          sendTimeout: timeout,
          receiveTimeout: timeout,
          validateStatus: (_) => true,
        ),
      );
      final statusCode = response.statusCode ?? 0;
      if (statusCode >= 200 && statusCode < 300) return response.data;
      throw _httpError(statusCode, response.data);
    } on AgentRemoteException {
      rethrow;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const AgentRemoteException(
          type: AgentRemoteErrorType.network,
          message: 'Không thể kết nối tới máy chủ chatbot.',
        );
      }
      throw const AgentRemoteException(type: AgentRemoteErrorType.server, message: 'Máy chủ không thể xử lý yêu cầu.');
    }
  }

  Stream<({String name, String data})> _decodeSse(Stream<List<int>> bytes) async* {
    String? eventName;
    final dataLines = <String>[];
    await for (final line in bytes.transform(utf8.decoder).transform(const LineSplitter()).timeout(timeout)) {
      if (line.isEmpty) {
        if (eventName != null && dataLines.isNotEmpty) {
          yield (name: eventName, data: dataLines.join('\n'));
        }
        eventName = null;
        dataLines.clear();
      } else if (line.startsWith('event:')) {
        eventName = line.substring(6).trim();
      } else if (line.startsWith('data:')) {
        dataLines.add(line.substring(5).trimLeft());
      }
    }
    if (eventName != null && dataLines.isNotEmpty) {
      yield (name: eventName, data: dataLines.join('\n'));
    }
  }

  AgentSseEvent? _mapSseEvent(String name, String rawData) {
    final data = _decodeJson(utf8.encode(rawData));
    if (data is! Map) throw _malformed();
    final json = Map<String, dynamic>.from(data);
    return switch (name) {
      'status' when json['label'] is String => AgentStatusEvent(json['label'] as String),
      'token' when json['text'] is String => AgentTokenEvent(json['text'] as String),
      'confirm' => AgentConfirmationEvent(ChatConfirmationDto.fromJson(json)),
      'result' => AgentResultEvent(json['executed']),
      'done' when json['threadId'] is String => AgentDoneEvent(
        threadId: json['threadId'] as String,
        citations: (json['citations'] as List? ?? const []).whereType<String>().toList(growable: false),
      ),
      'error' => AgentErrorEvent(
        json['message'] is String ? json['message'] as String : 'Agent không thể xử lý yêu cầu.',
      ),
      _ => null,
    };
  }

  Object? _decodeJson(List<int> bytes) {
    try {
      return jsonDecode(utf8.decode(bytes));
    } on Object {
      throw _malformed();
    }
  }

  AgentRemoteException _httpError(int statusCode, Object? data) => AgentRemoteException(
    type: switch (statusCode) {
      401 => AgentRemoteErrorType.unauthorized,
      404 => AgentRemoteErrorType.notFound,
      _ => AgentRemoteErrorType.server,
    },
    message: _errorMessage(data),
    statusCode: statusCode,
  );

  String _errorMessage(Object? data) {
    if (data is Map) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) return message.trim();
      if (message is List) {
        final values = message.whereType<String>().where((item) => item.isNotEmpty);
        if (values.isNotEmpty) return values.join('\n');
      }
    }
    return 'Máy chủ không thể xử lý yêu cầu.';
  }

  AgentRemoteException _malformed() => const AgentRemoteException(
    type: AgentRemoteErrorType.malformed,
    message: 'Phản hồi chatbot không đúng định dạng.',
  );

  void close() => _dio.close(force: true);
}
