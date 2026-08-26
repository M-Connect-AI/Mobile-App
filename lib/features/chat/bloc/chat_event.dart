import 'package:equatable/equatable.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

final class ChatStarted extends ChatEvent {
  const ChatStarted();
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
  const SendVoiceMessage(this.audioPath, this.duration);
  final String audioPath;
  final Duration duration;
  @override
  List<Object?> get props => [audioPath, duration];
}

final class RetryMessage extends ChatEvent {
  const RetryMessage(this.messageId);
  final String messageId;
  @override
  List<Object?> get props => [messageId];
}

final class RecordingTicked extends ChatEvent {
  const RecordingTicked();
}
