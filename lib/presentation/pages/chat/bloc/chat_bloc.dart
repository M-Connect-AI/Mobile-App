import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_message.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/chat_stream_event.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../../domain/repository/speech_to_text_repository.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';
import '../../../../generated/l10n.dart';
import 'chat_event.dart';
import 'chat_state.dart';

export 'chat_event.dart';
export 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    this._chatRepository,
    this._speechRepository, {
    DataRefreshCoordinator? refreshCoordinator,
  }) : _refreshCoordinator = refreshCoordinator,
       super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<MessageChanged>(_onMessageChanged);
    on<SendTextMessage>(_onSendText);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<CancelRecording>(_onCancelRecording);
    on<SendVoiceMessage>(_onSendVoice);
    on<RetryMessage>(_onRetry);
    on<ConfirmationResponded>(_onConfirmationResponded);
    on<ConfirmationEditRequested>(_onConfirmationEditRequested);
    on<ConfirmationRetryRequested>(_onConfirmationRetryRequested);
    on<RecordingTicked>(_onRecordingTicked);
    on<SpeechRecognitionUpdated>(_onSpeechRecognitionUpdated);
    on<SpeechRecognitionFailed>(_onSpeechRecognitionFailed);
    on<SpeechRecognitionCompleted>(_onSpeechRecognitionCompleted);

    _transcriptSubscription = _speechRepository.transcripts.listen((result) {
      _latestTranscript = result.text;
      if (!isClosed) add(SpeechRecognitionUpdated(result.text));
    });
    _statusSubscription = _speechRepository.statuses.listen((status) {
      if (status == SpeechSessionStatus.done && !isClosed) {
        add(const SpeechRecognitionCompleted());
      }
    });
    _errorSubscription = _speechRepository.errors.listen((message) {
      if (!isClosed) add(SpeechRecognitionFailed(message));
    });
  }

  final ChatRepository _chatRepository;
  final SpeechToTextRepository _speechRepository;
  final DataRefreshCoordinator? _refreshCoordinator;
  late final StreamSubscription<SpeechTranscript> _transcriptSubscription;
  late final StreamSubscription<SpeechSessionStatus> _statusSubscription;
  late final StreamSubscription<String> _errorSubscription;
  Timer? _recordingTimer;
  String _latestTranscript = '';
  bool _isStopping = false;

  Future<void> _onStarted(ChatStarted event, Emitter<ChatState> emit) async {
    if (event.threadId == null) {
      emit(
        ChatState(
          messages: [_welcomeMessage()],
          inputText: event.initialMessage ?? '',
        ),
      );
      if (event.autoSendInitialMessage &&
          (event.initialMessage?.trim().isNotEmpty ?? false)) {
        add(const SendTextMessage());
      }
      if (event.startRecording) {
        add(const StartRecording());
      }
      return;
    }
    emit(
      ChatState(
        activeThreadId: event.threadId,
        inputText: event.initialMessage ?? '',
        isLoading: true,
        isRestoring: true,
      ),
    );
    try {
      final detail = await _chatRepository.getThread(event.threadId!);
      emit(
        state.copyWith(
          messages: detail.messages.isEmpty
              ? [_welcomeMessage()]
              : detail.messages,
          activeThreadId: detail.threadId,
          isLoading: false,
          isRestoring: false,
          clearError: true,
        ),
      );
    } on ChatRepositoryException catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          isRestoring: false,
          error: error.message,
          sessionExpired: error.sessionExpired,
        ),
      );
    }
  }

  ChatMessage _welcomeMessage() => ChatMessage(
    id: 'welcome',
    type: MessageType.text,
    sender: MessageSender.assistant,
    content: S.current.welcomeMessage,
    createdAt: DateTime.now(),
    status: MessageStatus.success,
  );

  void _onMessageChanged(MessageChanged event, Emitter<ChatState> emit) {
    emit(state.copyWith(inputText: event.message, clearError: true));
  }

  Future<void> _onSendText(
    SendTextMessage event,
    Emitter<ChatState> emit,
  ) async {
    final text = state.inputText.trim();
    if (text.isEmpty || state.isLoading || state.isRecording) return;
    final message = ChatMessage(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      type: MessageType.text,
      sender: MessageSender.user,
      content: text,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, message],
        inputText: '',
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearBackendStatusLabel: true,
        clearError: true,
      ),
    );
    await _sendAndReceive(message, emit);
  }

  Future<void> _onStartRecording(
    StartRecording event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoading || state.recordingState != RecordingState.idle) return;
    emit(
      state.copyWith(
        recordingState: RecordingState.requestingPermission,
        recognizedText: '',
        clearError: true,
      ),
    );
    try {
      final available = await _speechRepository.initialize();
      if (!available) {
        emit(
          state.copyWith(
            recordingState: RecordingState.idle,
            error: S.current.speechUnavailable,
          ),
        );
        return;
      }
      _latestTranscript = '';
      await _speechRepository.startListening();
      _recordingTimer?.cancel();
      _recordingTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => add(const RecordingTicked()),
      );
      emit(
        state.copyWith(
          recordingState: RecordingState.recording,
          recordingDuration: Duration.zero,
          recognizedText: '',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          error: S.current.speechStartFailed,
        ),
      );
    }
  }

  void _onRecordingTicked(RecordingTicked event, Emitter<ChatState> emit) {
    if (state.isRecording) {
      emit(
        state.copyWith(
          recordingDuration:
              state.recordingDuration + const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _onStopRecording(
    StopRecording event,
    Emitter<ChatState> emit,
  ) async {
    if (!state.isRecording || _isStopping) return;
    _isStopping = true;
    _recordingTimer?.cancel();
    try {
      final duration = state.recordingDuration;
      final repositoryTranscript = await _speechRepository.stopListening();
      final transcript = repositoryTranscript.isNotEmpty
          ? repositoryTranscript
          : _latestTranscript.trim();
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          recordingDuration: Duration.zero,
          recognizedText: '',
        ),
      );
      if (transcript.isEmpty) {
        emit(state.copyWith(error: S.current.speechNoContent));
        return;
      }
      add(SendVoiceMessage(transcript, duration));
    } catch (_) {
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          recordingDuration: Duration.zero,
          recognizedText: '',
          error: S.current.speechCompleteFailed,
        ),
      );
    } finally {
      _isStopping = false;
    }
  }

  Future<void> _onCancelRecording(
    CancelRecording event,
    Emitter<ChatState> emit,
  ) async {
    if (!state.isRecording) return;
    _recordingTimer?.cancel();
    _isStopping = true;
    try {
      await _speechRepository.cancelListening();
    } catch (_) {
      // The UI can still safely return to idle if platform cleanup fails.
    } finally {
      _isStopping = false;
    }
    _latestTranscript = '';
    emit(
      state.copyWith(
        recordingState: RecordingState.idle,
        recordingDuration: Duration.zero,
        recognizedText: '',
        clearError: true,
      ),
    );
  }

  Future<void> _onSendVoice(
    SendVoiceMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoading) return;
    final message = ChatMessage(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      type: MessageType.audio,
      sender: MessageSender.user,
      content: event.transcript,
      duration: event.duration,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, message],
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearBackendStatusLabel: true,
        clearError: true,
      ),
    );
    await _sendAndReceive(message, emit);
  }

  Future<void> _onRetry(RetryMessage event, Emitter<ChatState> emit) async {
    if (state.isLoading) return;
    final index = state.messages.indexWhere(
      (message) => message.id == event.messageId,
    );
    if (index == -1) return;
    final message = state.messages[index];
    final updated = [...state.messages]
      ..[index] = message.copyWith(status: MessageStatus.sending);
    emit(
      state.copyWith(
        messages: updated,
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearBackendStatusLabel: true,
        clearError: true,
      ),
    );
    await _sendAndReceive(
      message,
      emit,
      confirm: message.confirmedTool != null,
      confirmedTool: message.confirmedTool,
    );
  }

  Future<void> _onConfirmationResponded(
    ConfirmationResponded event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoading) return;
    final confirmationIndex = state.messages.indexWhere(
      (message) =>
          message.id == event.messageId && message.confirmation != null,
    );
    if (confirmationIndex < 0) return;
    final confirmation = state.messages[confirmationIndex].confirmation!;
    if (event.confirmed && !confirmation.canExecute) return;

    final messages = [...state.messages]
      ..[confirmationIndex] = state.messages[confirmationIndex].copyWith(
        confirmationStatus: event.confirmed
            ? ConfirmationStatus.submitting
            : ConfirmationStatus.cancelled,
        clearConfirmationError: true,
      );
    final actionMessage = ChatMessage(
      id: 'confirmation-${DateTime.now().microsecondsSinceEpoch}',
      type: MessageType.text,
      sender: MessageSender.user,
      content: event.confirmed
          ? S.current.confirmAction
          : S.current.cancelAction,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
      confirmedTool: event.confirmed ? confirmation.tool : null,
    );
    emit(
      state.copyWith(
        messages: messages,
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearBackendStatusLabel: true,
        clearError: true,
      ),
    );
    await _sendAndReceive(
      actionMessage,
      emit,
      confirm: event.confirmed,
      confirmedTool: event.confirmed ? confirmation.tool : null,
      confirmationMessageId: event.confirmed ? event.messageId : null,
    );
  }

  void _onConfirmationEditRequested(
    ConfirmationEditRequested event,
    Emitter<ChatState> emit,
  ) {
    final message = state.messages
        .where(
          (item) => item.id == event.messageId && item.confirmation != null,
        )
        .firstOrNull;
    if (message == null || state.isLoading) return;
    emit(
      state.copyWith(
        inputText: S.current.editConfirmationPrompt,
        clearError: true,
      ),
    );
  }

  Future<void> _onConfirmationRetryRequested(
    ConfirmationRetryRequested event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoading) return;
    final message = state.messages
        .where(
          (item) => item.id == event.messageId && item.confirmation != null,
        )
        .firstOrNull;
    final confirmation = message?.confirmation;
    if (confirmation == null || !confirmation.canExecute) return;
    _updateConfirmation(
      emit,
      event.messageId,
      status: ConfirmationStatus.submitting,
      clearError: true,
    );
    emit(
      state.copyWith(
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearBackendStatusLabel: true,
        clearError: true,
      ),
    );
    final actionMessage = ChatMessage(
      id: 'confirmation-${DateTime.now().microsecondsSinceEpoch}',
      type: MessageType.text,
      sender: MessageSender.user,
      content: S.current.confirmAction,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
      confirmedTool: confirmation.tool,
    );
    await _sendAndReceive(
      actionMessage,
      emit,
      confirm: true,
      confirmedTool: confirmation.tool,
      confirmationMessageId: event.messageId,
    );
  }

  Future<void> _sendAndReceive(
    ChatMessage userMessage,
    Emitter<ChatState> emit, {
    bool confirm = false,
    ChatConfirmationTool? confirmedTool,
    String? confirmationMessageId,
  }) async {
    String? assistantMessageId;
    var receivedToken = false;
    var terminalEventSeen = false;
    try {
      final responseStream = _chatRepository.sendMessage(
        message: userMessage.content!,
        threadId: state.activeThreadId,
        confirm: confirm,
        confirmedTool: confirmedTool,
      );
      await for (final event in responseStream) {
        assistantMessageId ??=
            'assistant-${DateTime.now().microsecondsSinceEpoch}';
        if (event is ChatStreamStatus) {
          final label = event.label.trim();
          if (label.isNotEmpty) {
            emit(
              state.copyWith(
                backendStatusLabel: label,
                aiProcessingState: AiProcessingState.understanding,
              ),
            );
          }
        } else if (event is ChatStreamToken) {
          receivedToken = true;
          _upsertAssistant(
            emit,
            userMessage,
            assistantMessageId,
            content: _assistantContent(assistantMessageId) + event.text,
          );
        } else if (event is ChatStreamConfirmation) {
          _upsertAssistant(
            emit,
            userMessage,
            assistantMessageId,
            confirmation: event.action,
          );
        } else if (event is ChatStreamResult) {
          if (confirmationMessageId != null && event.result.isMutation) {
            _updateConfirmation(
              emit,
              confirmationMessageId,
              status: ConfirmationStatus.success,
              result: event.result,
              clearError: true,
            );
          } else {
            _upsertAssistant(
              emit,
              userMessage,
              assistantMessageId,
              executedResult: event.result,
            );
          }
          if (event.result.isMutation) {
            _refreshCoordinator?.notify(event.result.refreshScopes);
          }
        } else if (event is ChatStreamDone) {
          terminalEventSeen = true;
          final hasAssistantMessage = state.messages.any(
            (message) => message.id == assistantMessageId,
          );
          if (confirmationMessageId == null || hasAssistantMessage) {
            _upsertAssistant(
              emit,
              userMessage,
              assistantMessageId,
              status: MessageStatus.success,
              citations: event.citations,
              isLoading: false,
            );
          }
          emit(
            state.copyWith(
              activeThreadId: event.threadId,
              isLoading: false,
              aiProcessingState: AiProcessingState.idle,
              clearBackendStatusLabel: true,
            ),
          );
          _refreshCoordinator?.notify(const {DataRefreshScope.chatHistory});
        } else if (event is ChatStreamFailure) {
          terminalEventSeen = true;
          if (confirmationMessageId != null) {
            _updateConfirmation(
              emit,
              confirmationMessageId,
              status: ConfirmationStatus.failure,
              error: event.message,
            );
          } else {
            _upsertAssistant(
              emit,
              userMessage,
              assistantMessageId,
              content: event.message,
              status: MessageStatus.failed,
              isLoading: false,
            );
          }
          emit(
            state.copyWith(
              error: event.message,
              isLoading: false,
              aiProcessingState: AiProcessingState.idle,
              clearBackendStatusLabel: true,
            ),
          );
        }
      }
      if (!terminalEventSeen) {
        throw ChatRepositoryException(S.current.connectionInterrupted);
      }
    } on ChatRepositoryException catch (error) {
      if (confirmationMessageId != null) {
        _updateConfirmation(
          emit,
          confirmationMessageId,
          status: ConfirmationStatus.failure,
          error: error.message,
        );
      }
      final failed = state.messages
          .where((item) => item.id != assistantMessageId)
          .map(
            (item) => item.id == userMessage.id && !receivedToken
                ? item.copyWith(status: MessageStatus.failed)
                : item.id == userMessage.id
                ? item.copyWith(status: MessageStatus.sent)
                : item,
          )
          .toList();
      emit(
        state.copyWith(
          messages: failed,
          isLoading: false,
          aiProcessingState: AiProcessingState.idle,
          clearBackendStatusLabel: true,
          error: error.message,
          sessionExpired: error.sessionExpired,
        ),
      );
    }
  }

  void _updateConfirmation(
    Emitter<ChatState> emit,
    String messageId, {
    required ConfirmationStatus status,
    ChatResultEnvelope? result,
    String? error,
    bool clearError = false,
  }) {
    final messages = state.messages
        .map(
          (message) => message.id == messageId
              ? message.copyWith(
                  confirmationStatus: status,
                  confirmationError: error,
                  executedResult: result,
                  clearConfirmationError: clearError,
                )
              : message,
        )
        .toList();
    emit(state.copyWith(messages: messages));
  }

  String _assistantContent(String id) =>
      state.messages
          .where((message) => message.id == id)
          .map((message) => message.content ?? '')
          .firstOrNull ??
      '';

  void _upsertAssistant(
    Emitter<ChatState> emit,
    ChatMessage userMessage,
    String assistantId, {
    String? content,
    MessageStatus status = MessageStatus.processing,
    ChatConfirmAction? confirmation,
    List<String>? citations,
    ChatResultEnvelope? executedResult,
    bool isLoading = true,
  }) {
    final current = state.messages
        .where((message) => message.id == assistantId)
        .firstOrNull;
    final assistant = current == null
        ? ChatMessage(
            id: assistantId,
            type: MessageType.text,
            sender: MessageSender.assistant,
            content: content ?? '',
            createdAt: DateTime.now(),
            status: status,
            confirmation: confirmation,
            citations: citations ?? const [],
            executedResult: executedResult,
          )
        : current.copyWith(
            content: content,
            status: status,
            confirmation: confirmation,
            citations: citations,
            executedResult: executedResult,
          );
    final updated = state.messages
        .map(
          (message) => message.id == userMessage.id
              ? message.copyWith(status: MessageStatus.sent)
              : message.id == assistantId
              ? assistant
              : message,
        )
        .toList();
    if (!updated.any((message) => message.id == assistantId)) {
      updated.add(assistant);
    }
    if (kDebugMode) {
      debugPrint(
        '[MConnect ChatBloc] agent update: status=${assistant.status.name}, '
        'chars=${assistant.content?.length ?? 0}',
      );
    }
    emit(
      state.copyWith(
        messages: updated,
        isLoading: isLoading,
        aiProcessingState: isLoading
            ? AiProcessingState.generatingResponse
            : AiProcessingState.idle,
        clearError: true,
      ),
    );
  }

  void _onSpeechRecognitionUpdated(
    SpeechRecognitionUpdated event,
    Emitter<ChatState> emit,
  ) {
    if (state.isRecording) {
      emit(state.copyWith(recognizedText: event.transcript));
    }
  }

  void _onSpeechRecognitionFailed(
    SpeechRecognitionFailed event,
    Emitter<ChatState> emit,
  ) async {
    _recordingTimer?.cancel();
    _isStopping = false;
    emit(
      state.copyWith(
        recordingState: RecordingState.idle,
        recordingDuration: Duration.zero,
        recognizedText: '',
        error: event.message,
      ),
    );
  }

  void _onSpeechRecognitionCompleted(
    SpeechRecognitionCompleted event,
    Emitter<ChatState> emit,
  ) {
    if (state.isRecording && !_isStopping) {
      add(const StopRecording());
    }
  }

  @override
  Future<void> close() async {
    _recordingTimer?.cancel();
    await _transcriptSubscription.cancel();
    await _statusSubscription.cancel();
    await _errorSubscription.cancel();
    return super.close();
  }
}
