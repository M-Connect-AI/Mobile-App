import '../models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  final Set<String> _failedOnce = {};

  @override
  Stream<ChatMessage> sendTextMessage(String message) async* {
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
    yield _assistantMessage(
      isTransfer
          ? 'Tôi cần thêm thông tin để thực hiện giao dịch.\n\nBạn muốn chuyển từ tài khoản nào?'
          : 'Tôi đã hiểu yêu cầu của bạn. Đây là phản hồi mô phỏng từ AI. Bạn có thể bổ sung thông tin để tôi hỗ trợ chính xác hơn.',
    );
  }

  @override
  Stream<ChatMessage> sendVoiceMessage(String transcript) async* {
    await Future<void>.delayed(const Duration(milliseconds: 1900));
    final normalized = transcript.trim().toLowerCase();
    final isTransfer =
        normalized.contains('chuyển') ||
        normalized.contains('transfer') ||
        normalized.contains('gửi tiền');
    yield _assistantMessage(
      isTransfer
          ? 'Tôi cần thêm thông tin để thực hiện giao dịch.\n\nBạn muốn chuyển từ tài khoản nào?'
          : 'Tôi đã nhận được yêu cầu bằng giọng nói của bạn. Bạn muốn tôi hỗ trợ thêm điều gì?',
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

  @override
  void close() {}
}
