import '../models/chat_message.dart';

abstract interface class ChatRepository {
  Stream<ChatMessage> sendTextMessage(String message);
  Stream<ChatMessage> sendVoiceMessage(String transcript);
  void close();
}

class ChatRepositoryException implements Exception {
  const ChatRepositoryException(this.message);
  final String message;
}
