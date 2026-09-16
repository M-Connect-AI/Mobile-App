import 'package:equatable/equatable.dart';

import 'chat_stream_event.dart';
import 'chat_result.dart';

enum MessageSender { user, assistant, system }

enum MessageType { text, audio }

enum MessageStatus { sending, sent, processing, success, failed }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.type,
    required this.sender,
    required this.createdAt,
    required this.status,
    this.content,
    this.audioPath,
    this.duration,
    this.confirmation,
    this.confirmedTool,
    this.citations = const [],
    this.executedResult,
  });

  final String id;
  final MessageType type;
  final MessageSender sender;
  final String? content;
  final String? audioPath;
  final Duration? duration;
  final ChatConfirmAction? confirmation;
  final ChatConfirmationTool? confirmedTool;
  final List<String> citations;
  final ChatResultEnvelope? executedResult;
  final DateTime createdAt;
  final MessageStatus status;

  ChatMessage copyWith({
    String? content,
    String? audioPath,
    Duration? duration,
    MessageStatus? status,
    ChatConfirmAction? confirmation,
    ChatConfirmationTool? confirmedTool,
    List<String>? citations,
    ChatResultEnvelope? executedResult,
    bool clearConfirmation = false,
  }) {
    return ChatMessage(
      id: id,
      type: type,
      sender: sender,
      content: content ?? this.content,
      audioPath: audioPath ?? this.audioPath,
      duration: duration ?? this.duration,
      createdAt: createdAt,
      status: status ?? this.status,
      confirmation: clearConfirmation
          ? null
          : confirmation ?? this.confirmation,
      confirmedTool: confirmedTool ?? this.confirmedTool,
      citations: citations ?? this.citations,
      executedResult: executedResult ?? this.executedResult,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    sender,
    content,
    audioPath,
    duration,
    createdAt,
    status,
    confirmation,
    confirmedTool,
    citations,
    executedResult,
  ];
}
