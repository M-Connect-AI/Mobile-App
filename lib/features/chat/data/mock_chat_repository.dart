import '../models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  final Set<String> _failedOnce = {};

  @override
  Future<ChatMessage> sendTextMessage(String message) async {
    await Future<void>.delayed(const Duration(milliseconds: 1700));
    final normalized = message.trim().toLowerCase();
    if ((normalized.contains('#fail') || normalized.contains('#lỗi')) &&
        _failedOnce.add(normalized)) {
      throw const ChatRepositoryException('Không thể gửi tin nhắn');
    }
    final isTransfer =
        normalized.contains('chuyển') ||
        normalized.contains('transfer') ||
        normalized.contains('gửi tiền');
    return _assistantMessage(
      isTransfer
          ? 'Tôi cần thêm thông tin để thực hiện giao dịch.\n\nBạn muốn chuyển từ tài khoản nào?'
          : 'Tôi đã hiểu yêu cầu của bạn. Đây là phản hồi mô phỏng từ AI. Bạn có thể bổ sung thông tin để tôi hỗ trợ chính xác hơn.',
    );
  }

  @override
  Future<ChatMessage> sendVoiceMessage(String audioPath) async {
    await Future<void>.delayed(const Duration(milliseconds: 1900));
    return _assistantMessage(
      'Tôi nghe được: “Chuyển 500k cho Nguyễn Văn A”.\n\nBạn muốn chuyển từ tài khoản nào?',
    );
  }

  ChatMessage _assistantMessage(String content) => ChatMessage(
    id: 'assistant-${DateTime.now().microsecondsSinceEpoch}',
    type: MessageType.text,
    sender: MessageSender.assistant,
    content: content,
    createdAt: DateTime.now(),
    status: MessageStatus.success,
  );
}

class ChatRepositoryException implements Exception {
  const ChatRepositoryException(this.message);
  final String message;
}
