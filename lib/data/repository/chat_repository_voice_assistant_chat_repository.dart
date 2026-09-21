import '../../domain/model/chat_stream_event.dart';
import '../../domain/repository/chat_repository.dart';
import '../../domain/repository/voice_assistant_chat_repository.dart';

/// Sends a voice transcript through the same chatbot repository as ChatPage.
class ChatRepositoryVoiceAssistantChatRepository
    implements VoiceAssistantChatRepository {
  const ChatRepositoryVoiceAssistantChatRepository(this._chatRepository);

  final ChatRepository _chatRepository;

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
  }) => _chatRepository.sendMessage(message: message, threadId: threadId);
}
