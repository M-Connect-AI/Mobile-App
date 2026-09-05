import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class ApiChatClient {
  ApiChatClient({
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

  Stream<String> streamChatCompletion(
    List<Map<String, String>> messages,
  ) async* {
    if (_apiKey.isEmpty) {
      throw const ApiChatClientException(
        'AI Platform API key chưa được cấu hình.',
      );
    }

    final baseSystemPrompt = _systemPromptBuilder();
    final systemPrompt = disableThinking
        ? '$baseSystemPrompt\n\n/no_think'
        : baseSystemPrompt;

    try {
      final response = await _dio.post<ResponseBody>(
        '$_baseUrl/chat/completions',
        data: {
          'model': model,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            ...messages,
          ],
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
        throw const ApiChatClientException(
          'Phản hồi chatbot không có nội dung.',
        );
      }

      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        final bytes = await responseBody.stream.fold<List<int>>(
          <int>[],
          (buffer, chunk) => buffer..addAll(chunk),
        );
        _throwApiError(bytes);
      }

      await for (final line
          in responseBody.stream
              .cast<List<int>>()
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .timeout(timeout)) {
        if (!line.startsWith('data:')) continue;
        final data = line.substring(5).trim();
        if (data.isEmpty) continue;
        if (data == '[DONE]') break;

        dynamic event;
        try {
          event = jsonDecode(data);
        } catch (_) {
          throw const ApiChatClientException(
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
        final responseMessage = firstChoice['message'];
        final content = delta is Map
            ? delta['content']
            : responseMessage is Map
            ? responseMessage['content']
            : null;
        if (content is String) yield content;
      }
    } on ApiChatClientException {
      rethrow;
    } on TimeoutException {
      throw const ApiChatClientException(
        'Máy chủ phản hồi quá lâu. Vui lòng thử lại.',
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const ApiChatClientException(
          'Máy chủ phản hồi quá lâu. Vui lòng thử lại.',
        );
      }
      if (error.type == DioExceptionType.connectionError) {
        throw const ApiChatClientException(
          'Không thể kết nối tới máy chủ chatbot.',
        );
      }
      throw const ApiChatClientException(
        'Không thể xử lý phản hồi từ máy chủ chatbot.',
      );
    } catch (_) {
      throw const ApiChatClientException(
        'Không thể xử lý phản hồi từ máy chủ chatbot.',
      );
    }
  }

  Never _throwApiError(List<int> responseBytes) {
    Map<String, dynamic> body;
    try {
      body = jsonDecode(utf8.decode(responseBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw const ApiChatClientException(
        'Phản hồi từ máy chủ không đúng định dạng JSON.',
      );
    }
    final error = body['error'];
    final nestedMessage = error is Map ? error['message'] : null;
    final detail = nestedMessage ?? body['message'] ?? body['detail'];
    throw ApiChatClientException(
      detail is String ? detail : 'Máy chủ không thể xử lý yêu cầu.',
    );
  }

  void close() => _dio.close(force: true);
}

class ApiChatClientException implements Exception {
  const ApiChatClientException(this.message);

  final String message;
}
