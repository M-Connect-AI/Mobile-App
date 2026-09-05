import 'dart:convert';

import '../../domain/model/chat_message.dart';
import '../../domain/repository/chat_repository.dart';
import '../source/remote/client/api_chat_client.dart';

class ApiChatRepository implements ChatRepository {
  ApiChatRepository({required ApiChatClient client}) : _client = client;

  final ApiChatClient _client;
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
    final userMessage = {'role': 'user', 'content': message};
    try {
      final contentBuffer = StringBuffer();
      final responseId = 'assistant-${DateTime.now().microsecondsSinceEpoch}';
      final responseCreatedAt = DateTime.now();
      var lastDisplayedContent = '';
      await for (final content in _client.streamChatCompletion([
        ..._history,
        userMessage,
      ])) {
        contentBuffer.write(content);

        final partialQuestion = _partialConfirmationQuestion(
          contentBuffer.toString(),
        );
        if (partialQuestion != null &&
            partialQuestion.isNotEmpty &&
            partialQuestion != lastDisplayedContent) {
          lastDisplayedContent = partialQuestion;
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
    } on ApiChatClientException catch (error) {
      throw ChatRepositoryException(error.message);
    }
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

  @override
  void close() => _client.close();
}
