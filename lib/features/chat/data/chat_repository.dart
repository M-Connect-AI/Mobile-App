import '../models/chat_message.dart';

abstract interface class ChatRepository {
  Future<ChatMessage> sendTextMessage(String message);
  Future<ChatMessage> sendVoiceMessage(String audioPath);
}
