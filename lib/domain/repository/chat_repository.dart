import '../model/chat_stream_event.dart';
import '../model/chat_thread.dart';

abstract interface class ChatRepository {
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
    bool confirm = false,
    ChatConfirmationTool? confirmedTool,
  });

  Future<ChatThreadDetail> getThread(String threadId);

  void close();
}

class ChatRepositoryException implements Exception {
  const ChatRepositoryException(
    this.message, {
    this.sessionExpired = false,
    this.network = false,
  });
  final String message;
  final bool sessionExpired;
  final bool network;
}
