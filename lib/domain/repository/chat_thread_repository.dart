import '../model/chat_thread.dart';

abstract interface class ChatThreadRepository {
  Future<List<ChatThread>> getThreads();
}
