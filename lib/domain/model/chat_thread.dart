import 'package:equatable/equatable.dart';

import 'chat_message.dart';
import 'chat_stream_event.dart';

class ChatThread extends Equatable {
  const ChatThread({
    required this.threadId,
    required this.title,
    required this.preview,
    required this.updatedAt,
  });

  final String threadId;
  final String title;
  final String preview;
  final DateTime updatedAt;

  @override
  List<Object> get props => [threadId, title, preview, updatedAt];
}

class ChatThreadDetail extends Equatable {
  const ChatThreadDetail({
    required this.threadId,
    required this.messages,
    this.pendingAction,
  });

  final String threadId;
  final List<ChatMessage> messages;
  final ChatConfirmAction? pendingAction;

  @override
  List<Object?> get props => [threadId, messages, pendingAction];
}
