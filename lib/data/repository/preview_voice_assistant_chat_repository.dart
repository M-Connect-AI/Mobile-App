import '../../domain/model/chat_stream_event.dart';
import '../../domain/repository/voice_assistant_chat_repository.dart';
import '../../generated/l10n.dart';

/// Local preview: makes no network request and stores no transcript.
class PreviewVoiceAssistantChatRepository
    implements VoiceAssistantChatRepository {
  const PreviewVoiceAssistantChatRepository();

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
  }) async* {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final reply = S.current.voiceAssistantPreviewReply;
    yield ChatStreamToken(reply);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    yield ChatStreamDone(threadId: '', reply: reply);
  }
}
