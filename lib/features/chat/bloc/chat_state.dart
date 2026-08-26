import 'package:equatable/equatable.dart';
import '../models/chat_message.dart';

enum RecordingState { idle, requestingPermission, recording }

enum AiProcessingState { idle, thinking, understanding, callingApi }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.inputText = '',
    this.recordingState = RecordingState.idle,
    this.recordingDuration = Duration.zero,
    this.isLoading = false,
    this.aiProcessingState = AiProcessingState.idle,
    this.error,
  });

  final List<ChatMessage> messages;
  final String inputText;
  final RecordingState recordingState;
  final Duration recordingDuration;
  final bool isLoading;
  final AiProcessingState aiProcessingState;
  final String? error;

  bool get isRecording => recordingState == RecordingState.recording;
  bool get canSendText => inputText.trim().isNotEmpty && !isLoading;

  ChatState copyWith({
    List<ChatMessage>? messages,
    String? inputText,
    RecordingState? recordingState,
    Duration? recordingDuration,
    bool? isLoading,
    AiProcessingState? aiProcessingState,
    String? error,
    bool clearError = false,
  }) => ChatState(
    messages: messages ?? this.messages,
    inputText: inputText ?? this.inputText,
    recordingState: recordingState ?? this.recordingState,
    recordingDuration: recordingDuration ?? this.recordingDuration,
    isLoading: isLoading ?? this.isLoading,
    aiProcessingState: aiProcessingState ?? this.aiProcessingState,
    error: clearError ? null : error ?? this.error,
  );

  @override
  List<Object?> get props => [
    messages,
    inputText,
    recordingState,
    recordingDuration,
    isLoading,
    aiProcessingState,
    error,
  ];
}
