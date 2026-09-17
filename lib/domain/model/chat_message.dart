import 'package:equatable/equatable.dart';

import 'chat_stream_event.dart';
import 'chat_result.dart';
import 'chat_rich_content.dart';

enum MessageSender { user, assistant, system }

enum MessageType { text, audio }

enum MessageStatus { sending, sent, processing, success, failed }

enum ConfirmationStatus { pending, submitting, success, failure, cancelled }

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
    this.confirmationStatus = ConfirmationStatus.pending,
    this.confirmationError,
    this.confirmedTool,
    this.citations = const [],
    this.executedResult,
    this.uiAction,
    this.blocks = const [],
    this.highlights = const [],
    this.suggestions = const [],
    this.didMutate = false,
  });

  final String id;
  final MessageType type;
  final MessageSender sender;
  final String? content;
  final String? audioPath;
  final Duration? duration;
  final ChatConfirmAction? confirmation;
  final ConfirmationStatus confirmationStatus;
  final String? confirmationError;
  final ChatConfirmationTool? confirmedTool;
  final List<String> citations;
  final ChatResultEnvelope? executedResult;
  final ChatUiAction? uiAction;
  final List<ChatRichBlock> blocks;
  final List<ChatHighlight> highlights;
  final List<ChatSuggestion> suggestions;
  final bool didMutate;
  final DateTime createdAt;
  final MessageStatus status;

  ChatMessage copyWith({
    String? content,
    String? audioPath,
    Duration? duration,
    MessageStatus? status,
    ChatConfirmAction? confirmation,
    ConfirmationStatus? confirmationStatus,
    String? confirmationError,
    ChatConfirmationTool? confirmedTool,
    List<String>? citations,
    ChatResultEnvelope? executedResult,
    ChatUiAction? uiAction,
    List<ChatRichBlock>? blocks,
    List<ChatHighlight>? highlights,
    List<ChatSuggestion>? suggestions,
    bool? didMutate,
    bool clearConfirmation = false,
    bool clearConfirmationError = false,
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
      confirmationStatus: confirmationStatus ?? this.confirmationStatus,
      confirmationError: clearConfirmationError
          ? null
          : confirmationError ?? this.confirmationError,
      confirmedTool: confirmedTool ?? this.confirmedTool,
      citations: citations ?? this.citations,
      executedResult: executedResult ?? this.executedResult,
      uiAction: uiAction ?? this.uiAction,
      blocks: blocks ?? this.blocks,
      highlights: highlights ?? this.highlights,
      suggestions: suggestions ?? this.suggestions,
      didMutate: didMutate ?? this.didMutate,
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
    confirmationStatus,
    confirmationError,
    confirmedTool,
    citations,
    executedResult,
    uiAction,
    blocks,
    highlights,
    suggestions,
    didMutate,
  ];
}
