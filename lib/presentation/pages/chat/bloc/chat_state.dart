import 'package:equatable/equatable.dart';

import '../../../../domain/model/chat_message.dart';

enum RecordingState { idle, requestingPermission, recording }

enum AiProcessingState { idle, thinking, understanding, generatingResponse }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.inputText = '',
    this.recordingState = RecordingState.idle,
    this.recordingDuration = Duration.zero,
    this.recognizedText = '',
    this.isLoading = false,
    this.aiProcessingState = AiProcessingState.idle,
    this.backendStatusLabel,
    this.error,
    this.activeThreadId,
    this.isRestoring = false,
    this.sessionExpired = false,
  });

  final List<ChatMessage> messages;
  final String inputText;
  final RecordingState recordingState;
  final Duration recordingDuration;
  final String recognizedText;
  final bool isLoading;
  final AiProcessingState aiProcessingState;
  final String? backendStatusLabel;
  final String? error;
  final String? activeThreadId;
  final bool isRestoring;
  final bool sessionExpired;

  bool get isRecording => recordingState == RecordingState.recording;
  bool get canSendText => inputText.trim().isNotEmpty && !isLoading;

  ChatState copyWith({
    List<ChatMessage>? messages,
    String? inputText,
    RecordingState? recordingState,
    Duration? recordingDuration,
    String? recognizedText,
    bool? isLoading,
    AiProcessingState? aiProcessingState,
    String? backendStatusLabel,
    bool clearBackendStatusLabel = false,
    String? error,
    bool clearError = false,
    String? activeThreadId,
    bool? isRestoring,
    bool? sessionExpired,
  }) => ChatState(
    messages: messages ?? this.messages,
    inputText: inputText ?? this.inputText,
    recordingState: recordingState ?? this.recordingState,
    recordingDuration: recordingDuration ?? this.recordingDuration,
    recognizedText: recognizedText ?? this.recognizedText,
    isLoading: isLoading ?? this.isLoading,
    aiProcessingState: aiProcessingState ?? this.aiProcessingState,
    backendStatusLabel: clearBackendStatusLabel
        ? null
        : backendStatusLabel ?? this.backendStatusLabel,
    error: clearError ? null : error ?? this.error,
    activeThreadId: activeThreadId ?? this.activeThreadId,
    isRestoring: isRestoring ?? this.isRestoring,
    sessionExpired: sessionExpired ?? this.sessionExpired,
  );

  @override
  List<Object?> get props => [
    messages,
    inputText,
    recordingState,
    recordingDuration,
    recognizedText,
    isLoading,
    aiProcessingState,
    backendStatusLabel,
    error,
    activeThreadId,
    isRestoring,
    sessionExpired,
  ];
}
