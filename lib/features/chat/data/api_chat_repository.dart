import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import 'chat_repository.dart';

class ApiChatRepository implements ChatRepository {
  ApiChatRepository({
    required String baseUrl,
    required String apiKey,
    required this.model,
    this.maxTokens = 1536,
    this.temperature = 0.2,
    this.topP = 0.95,
    this.disableThinking = false,
    String Function()? systemPromptBuilder,
    Dio? dio,
    this.timeout = const Duration(seconds: 30),
  }) : _baseUrl = baseUrl.replaceFirst(RegExp(r'/$'), ''),
       _apiKey = apiKey.trim(),
       _systemPromptBuilder =
           systemPromptBuilder ??
           (() =>
               'You are an AI assistant tasked with providing information to users.'),
       _dio = dio ?? Dio();

  final String _baseUrl;
  final String _apiKey;
  final Dio _dio;
  final String model;
  final int maxTokens;
  final double temperature;
  final double topP;
  final bool disableThinking;
  final String Function() _systemPromptBuilder;
  final Duration timeout;
  final List<Map<String, String>> _history = [];

  @override
  Stream<ChatMessage> sendTextMessage(String message) {
    return _send(message);
  }

  @override
  Stream<ChatMessage> sendVoiceMessage(String transcript) {
    return _send(transcript);
  }

  Stream<ChatMessage> _send(String message) async* {
    if (_apiKey.isEmpty) {
      throw const ChatRepositoryException(
        'AI Platform API key chưa được cấu hình.',
      );
    }
    final userMessage = {'role': 'user', 'content': message};
    final baseSystemPrompt = _systemPromptBuilder();
    final systemPrompt = disableThinking
        ? '$baseSystemPrompt\n\n/no_think'
        : baseSystemPrompt;
    final requestMessages = [
      {'role': 'system', 'content': systemPrompt},
      ..._history,
      userMessage,
    ];
    final streamWatch = Stopwatch()..start();
    try {
      _streamLog('request started: model=$model');
      final response = await _dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        data: {
          'model': model,
          'messages': requestMessages,
          'max_tokens': maxTokens,
          'temperature': temperature,
          'top_p': topP,
          'stream': true,
          'response_format': {'type': 'json_object'},
        },
        options: Options(
          headers: {
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
          responseType: ResponseType.stream,
          sendTimeout: timeout,
          receiveTimeout: timeout,
          validateStatus: (_) => true,
        ),
      );
      final responseBody = response.data;
      if (responseBody == null) {
        throw const ChatRepositoryException(
          'Phản hồi chatbot không có nội dung.',
        );
      }
      final statusCode = response.statusCode ?? 0;
      _streamLog(
        'response headers: status=$statusCode, '
        'content-type=${response.headers.value(Headers.contentTypeHeader)}, '
        'after=${streamWatch.elapsedMilliseconds}ms',
      );
      if (statusCode < 200 || statusCode >= 300) {
        final bytes = await responseBody.stream.fold<List<int>>(
          <int>[],
          (buffer, chunk) => buffer..addAll(chunk),
        );
        _throwApiError(bytes);
      }

      final contentBuffer = StringBuffer();
      final responseId = 'assistant-${DateTime.now().microsecondsSinceEpoch}';
      final responseCreatedAt = DateTime.now();
      var lastDisplayedContent = '';
      var networkChunkCount = 0;
      var sseEventCount = 0;
      var deltaCount = 0;
      var reasoningDeltaCount = 0;
      var uiEmissionCount = 0;
      final networkStream = responseBody.stream.map((chunk) {
        networkChunkCount++;
        if (_shouldLogCount(networkChunkCount)) {
          _streamLog(
            'network chunk #$networkChunkCount: ${chunk.length} bytes, '
            'after=${streamWatch.elapsedMilliseconds}ms',
          );
        }
        return chunk;
      });
      await for (final line
          in networkStream
              .cast<List<int>>()
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .timeout(timeout)) {
        if (!line.startsWith('data:')) continue;
        final data = line.substring(5).trim();
        if (data.isEmpty) continue;
        if (data == '[DONE]') {
          _streamLog(
            '[DONE] received after=${streamWatch.elapsedMilliseconds}ms',
          );
          break;
        }
        sseEventCount++;
        if (_shouldLogCount(sseEventCount)) {
          _streamLog(
            'SSE event #$sseEventCount: ${data.length} chars, '
            'after=${streamWatch.elapsedMilliseconds}ms',
          );
        }

        dynamic event;
        try {
          event = jsonDecode(data);
        } catch (_) {
          throw const ChatRepositoryException(
            'Dữ liệu streaming không đúng định dạng JSON.',
          );
        }
        if (event is! Map) continue;
        final choices = event['choices'];
        final firstChoice = choices is List && choices.isNotEmpty
            ? choices.first
            : null;
        if (firstChoice is! Map) continue;
        final delta = firstChoice['delta'];
        final reasoningContent = delta is Map
            ? delta['reasoning_content']
            : null;
        if (reasoningContent is String && reasoningContent.isNotEmpty) {
          reasoningDeltaCount++;
          if (_shouldLogCount(reasoningDeltaCount)) {
            _streamLog(
              'reasoning delta #$reasoningDeltaCount: ${reasoningContent.length} chars',
            );
          }
        }
        final responseMessage = firstChoice['message'];
        final content = delta is Map
            ? delta['content']
            : responseMessage is Map
            ? responseMessage['content']
            : null;
        if (content is! String) continue;
        deltaCount++;
        if (_shouldLogCount(deltaCount, interval: 10)) {
          _streamLog(
            'delta #$deltaCount: ${content.length} chars, '
            'preview=${_streamPreview(content)}',
          );
        }
        contentBuffer.write(content);

        final partialQuestion = _partialConfirmationQuestion(
          contentBuffer.toString(),
        );
        if (partialQuestion != null &&
            partialQuestion.isNotEmpty &&
            partialQuestion != lastDisplayedContent) {
          lastDisplayedContent = partialQuestion;
          uiEmissionCount++;
          if (_shouldLogCount(uiEmissionCount, interval: 10)) {
            _streamLog(
              'UI emission #$uiEmissionCount: ${partialQuestion.length} chars, '
              'after=${streamWatch.elapsedMilliseconds}ms',
            );
          }
          yield ChatMessage(
            id: responseId,
            type: MessageType.text,
            sender: MessageSender.assistant,
            content: partialQuestion,
            createdAt: responseCreatedAt,
            status: MessageStatus.processing,
          );
        }
      }

      final content = contentBuffer.toString().trim();
      _streamLog(
        'stream completed: networkChunks=$networkChunkCount, '
        'sseEvents=$sseEventCount, reasoningDeltas=$reasoningDeltaCount, '
        'deltas=$deltaCount, uiEmissions=$uiEmissionCount, '
        'contentChars=${content.length}, '
        'after=${streamWatch.elapsedMilliseconds}ms',
      );
      if (content.isEmpty) {
        throw const ChatRepositoryException(
          'Phản hồi chatbot không có nội dung.',
        );
      }
      _history
        ..add(userMessage)
        ..add({'role': 'assistant', 'content': content});
      _trimHistory();
      yield ChatMessage(
        id: responseId,
        type: MessageType.text,
        sender: MessageSender.assistant,
        content: _userFacingContent(content),
        createdAt: responseCreatedAt,
        status: MessageStatus.success,
      );
    } on ChatRepositoryException {
      rethrow;
    } on TimeoutException {
      throw const ChatRepositoryException(
        'Máy chủ phản hồi quá lâu. Vui lòng thử lại.',
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const ChatRepositoryException(
          'Máy chủ phản hồi quá lâu. Vui lòng thử lại.',
        );
      }
      if (error.type == DioExceptionType.connectionError) {
        throw const ChatRepositoryException(
          'Không thể kết nối tới máy chủ chatbot.',
        );
      }
      throw const ChatRepositoryException(
        'Không thể xử lý phản hồi từ máy chủ chatbot.',
      );
    } catch (_) {
      throw const ChatRepositoryException(
        'Không thể xử lý phản hồi từ máy chủ chatbot.',
      );
    }
  }

  Never _throwApiError(List<int> responseBytes) {
    Map<String, dynamic> body;
    try {
      body = jsonDecode(utf8.decode(responseBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw const ChatRepositoryException(
        'Phản hồi từ máy chủ không đúng định dạng JSON.',
      );
    }
    final error = body['error'];
    final nestedMessage = error is Map ? error['message'] : null;
    final detail = nestedMessage ?? body['message'] ?? body['detail'];
    throw ChatRepositoryException(
      detail is String ? detail : 'Máy chủ không thể xử lý yêu cầu.',
    );
  }

  void _trimHistory() {
    const maxHistoryItems = 20;
    if (_history.length > maxHistoryItems) {
      _history.removeRange(0, _history.length - maxHistoryItems);
    }
  }

  String _userFacingContent(String rawContent) {
    final trimmed = rawContent.trim();
    final jsonContent = trimmed
        .replaceFirst(RegExp(r'^```(?:json)?\s*', caseSensitive: false), '')
        .replaceFirst(RegExp(r'\s*```$'), '');

    dynamic decoded;
    try {
      decoded = jsonDecode(jsonContent);
    } catch (_) {
      return trimmed;
    }
    if (decoded is! Map) return trimmed;

    final result = Map<String, dynamic>.from(decoded);
    final confirmationQuestion = result['confirmation_question'];
    if (confirmationQuestion is String &&
        confirmationQuestion.trim().isNotEmpty) {
      return confirmationQuestion.trim();
    }

    return _fallbackConfirmationQuestion(result);
  }

  String _fallbackConfirmationQuestion(Map<String, dynamic> result) {
    const labels = <String, String>{
      'destination': 'điểm đến',
      'start_date': 'ngày bắt đầu',
      'end_date': 'ngày kết thúc',
      'duration_days': 'số ngày đi',
      'purpose': 'mục đích chuyến công tác',
      'employee': 'nhân viên thực hiện',
      'customer': 'khách hàng',
      'transportation': 'phương tiện di chuyển',
    };

    final missingFields = result['missing_fields'];
    final missingLabels = missingFields is List
        ? missingFields
              .whereType<String>()
              .map((field) => labels[field] ?? field)
              .toList()
        : <String>[];

    final ambiguousFields = result['ambiguous_fields'];
    final ambiguousLabels = ambiguousFields is List
        ? ambiguousFields
              .whereType<Map>()
              .map((item) => item['field'])
              .whereType<String>()
              .map((field) => labels[field] ?? field)
              .toSet()
              .toList()
        : <String>[];

    final questions = <String>[];
    if (missingLabels.isNotEmpty) {
      questions.add(
        'Vui lòng cung cấp thêm ${_joinVietnamese(missingLabels)}.',
      );
    }
    if (ambiguousLabels.isNotEmpty) {
      questions.add(
        'Vui lòng xác nhận lại ${_joinVietnamese(ambiguousLabels)}.',
      );
    }
    if (questions.isNotEmpty) return questions.join(' ');

    return 'Vui lòng xác nhận thông tin chuyến công tác trên có chính xác không?';
  }

  String _joinVietnamese(List<String> values) {
    if (values.length < 2) return values.single;
    return '${values.sublist(0, values.length - 1).join(', ')} và ${values.last}';
  }

  String? _partialConfirmationQuestion(String rawContent) {
    final match = RegExp(
      r'"confirmation_question"\s*:\s*"((?:\\.|[^"\\])*)',
    ).firstMatch(rawContent);
    final encodedValue = match?.group(1);
    if (encodedValue == null || encodedValue.isEmpty) return null;
    try {
      return jsonDecode('"$encodedValue"') as String;
    } catch (_) {
      // Wait for the next chunk when it ends in an incomplete JSON escape.
      return null;
    }
  }

  void _streamLog(String message) {
    if (kDebugMode) debugPrint('[ChatSSE] $message');
  }

  String _streamPreview(String content) {
    const maxLength = 80;
    final preview = content.length <= maxLength
        ? content
        : '${content.substring(0, maxLength)}…';
    return jsonEncode(preview);
  }

  bool _shouldLogCount(int count, {int interval = 50}) {
    return count <= 3 || count % interval == 0;
  }

  @override
  void close() => _dio.close(force: true);
}
