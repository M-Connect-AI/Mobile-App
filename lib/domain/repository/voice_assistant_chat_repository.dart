import '../model/chat_stream_event.dart';

/// Reply source for Voice Assistant, backed by the application's chat flow.
abstract interface class VoiceAssistantChatRepository {
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
  });
}
