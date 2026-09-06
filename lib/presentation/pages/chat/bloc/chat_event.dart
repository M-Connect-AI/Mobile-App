import 'package:equatable/equatable.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

final class ChatStarted extends ChatEvent {
  const ChatStarted({
    this.threadId,
    this.initialMessage,
    this.autoSendInitialMessage = false,
  });

  final String? threadId;
  final String? initialMessage;
  final bool autoSendInitialMessage;

  @override
  List<Object?> get props => [threadId, initialMessage, autoSendInitialMessage];
}

final class MessageChanged extends ChatEvent {
  const MessageChanged(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

final class SendTextMessage extends ChatEvent {
  const SendTextMessage();
}

final class StartRecording extends ChatEvent {
  const StartRecording();
}

final class StopRecording extends ChatEvent {
  const StopRecording();
}

final class CancelRecording extends ChatEvent {
  const CancelRecording();
}

final class SendVoiceMessage extends ChatEvent {
  const SendVoiceMessage(this.transcript, this.duration);
  final String transcript;
  final Duration duration;
  @override
  List<Object?> get props => [transcript, duration];
}

final class RetryMessage extends ChatEvent {
  const RetryMessage(this.messageId);
  final String messageId;
  @override
  List<Object?> get props => [messageId];
}

final class ConfirmationResponded extends ChatEvent {
  const ConfirmationResponded({
    required this.messageId,
    required this.confirmed,
  });

  final String messageId;
  final bool confirmed;

  @override
  List<Object?> get props => [messageId, confirmed];
}

final class RecordingTicked extends ChatEvent {
  const RecordingTicked();
}

final class SpeechRecognitionUpdated extends ChatEvent {
  const SpeechRecognitionUpdated(this.transcript);
  final String transcript;

  @override
  List<Object?> get props => [transcript];
}

final class SpeechRecognitionFailed extends ChatEvent {
  const SpeechRecognitionFailed(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class SpeechRecognitionCompleted extends ChatEvent {
  const SpeechRecognitionCompleted();
}
