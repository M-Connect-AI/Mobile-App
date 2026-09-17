import 'package:equatable/equatable.dart';

import 'chat_result.dart';
import 'chat_rich_content.dart';

enum ChatConfirmationTool {
  createLeave,
  createTrip,
  cancelLeave,
  updateLeave,
  approveLeaves,
  rejectLeaves,
  approveTrips,
  rejectTrips,
  createJiraTask,
  createOutlookEvent,
  replyOutlookMail,
  unknown,
}

class ChatConfirmAction extends Equatable {
  const ChatConfirmAction({
    required this.tool,
    required this.args,
    required this.summary,
  });

  final ChatConfirmationTool tool;
  final Map<String, dynamic> args;
  final String summary;

  bool get canExecute => tool != ChatConfirmationTool.unknown;

  @override
  List<Object?> get props => [tool, args, summary];
}

sealed class ChatStreamEvent extends Equatable {
  const ChatStreamEvent();
}

class ChatStreamStatus extends ChatStreamEvent {
  const ChatStreamStatus(this.label);
  final String label;
  @override
  List<Object> get props => [label];
}

class ChatStreamToken extends ChatStreamEvent {
  const ChatStreamToken(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

class ChatStreamConfirmation extends ChatStreamEvent {
  const ChatStreamConfirmation(this.action);
  final ChatConfirmAction action;
  @override
  List<Object> get props => [action];
}

class ChatStreamResult extends ChatStreamEvent {
  const ChatStreamResult(this.result);
  final ChatResultEnvelope result;
  @override
  List<Object?> get props => [result];
}

class ChatStreamDone extends ChatStreamEvent {
  const ChatStreamDone({
    required this.threadId,
    this.reply = '',
    this.confirmation,
    this.uiAction,
    this.blocks = const [],
    this.highlights = const [],
    this.suggestions = const [],
    this.previewResult,
    this.didMutate = false,
    this.citations = const [],
  });
  final String threadId;
  final String reply;
  final ChatConfirmAction? confirmation;
  final ChatUiAction? uiAction;
  final List<ChatRichBlock> blocks;
  final List<ChatHighlight> highlights;
  final List<ChatSuggestion> suggestions;
  final ChatResultEnvelope? previewResult;
  final bool didMutate;
  final List<String> citations;
  @override
  List<Object?> get props => [
    threadId,
    reply,
    confirmation,
    uiAction,
    blocks,
    highlights,
    suggestions,
    previewResult,
    didMutate,
    citations,
  ];
}

class ChatStreamFailure extends ChatStreamEvent {
  const ChatStreamFailure(this.message, {this.interrupted = false});
  final String message;
  final bool interrupted;
  @override
  List<Object> get props => [message, interrupted];
}
