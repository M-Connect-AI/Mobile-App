import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_message.dart';
import '../../../../domain/model/chat_stream_event.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../../domain/repository/speech_to_text_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

export 'chat_event.dart';
export 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._chatRepository, this._speechRepository)
    : super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<MessageChanged>(_onMessageChanged);
    on<SendTextMessage>(_onSendText);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<CancelRecording>(_onCancelRecording);
    on<SendVoiceMessage>(_onSendVoice);
    on<RetryMessage>(_onRetry);
    on<ConfirmationResponded>(_onConfirmationResponded);
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
    content:
        'Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?',
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
            error:
                'Nhận dạng giọng nói không khả dụng. Hãy kiểm tra quyền microphone và speech recognition.',
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
          error: 'Không thể bắt đầu nhận dạng giọng nói. Vui lòng thử lại.',
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
        emit(
          state.copyWith(
            error: 'Không nhận diện được nội dung. Vui lòng nói lại.',
          ),
        );
        return;
      }
      add(SendVoiceMessage(transcript, duration));
    } catch (_) {
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          recordingDuration: Duration.zero,
          recognizedText: '',
          error: 'Không thể hoàn tất nhận dạng giọng nói.',
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
        clearError: true,
      ),
    );
    await _sendAndReceive(message, emit);
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
        clearConfirmation: true,
      );
    final userMessage = ChatMessage(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      type: MessageType.text,
      sender: MessageSender.user,
      content: event.confirmed ? 'Xác nhận' : 'Hủy',
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
    );
    emit(
      state.copyWith(
        messages: [...messages, userMessage],
        isLoading: true,
        aiProcessingState: AiProcessingState.thinking,
        clearError: true,
      ),
    );
    await _sendAndReceive(userMessage, emit, confirm: event.confirmed);
  }

  Future<void> _sendAndReceive(
    ChatMessage userMessage,
    Emitter<ChatState> emit, {
    bool confirm = false,
  }) async {
    String? assistantMessageId;
    var receivedToken = false;
    var terminalEventSeen = false;
    try {
      final responseStream = _chatRepository.sendMessage(
        message: userMessage.content!,
        threadId: state.activeThreadId,
        confirm: confirm,
      );
      await Future<void>.delayed(const Duration(milliseconds: 450));
      emit(
        state.copyWith(aiProcessingState: AiProcessingState.generatingResponse),
      );
      await for (final event in responseStream) {
        assistantMessageId ??=
            'assistant-${DateTime.now().microsecondsSinceEpoch}';
        if (event is ChatStreamToken) {
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
          _upsertAssistant(
            emit,
            userMessage,
            assistantMessageId,
            executedResult: event.executed,
          );
        } else if (event is ChatStreamDone) {
          terminalEventSeen = true;
          _upsertAssistant(
            emit,
            userMessage,
            assistantMessageId,
            status: MessageStatus.success,
            citations: event.citations,
            isLoading: false,
          );
          emit(
            state.copyWith(
              activeThreadId: event.threadId,
              isLoading: false,
              aiProcessingState: AiProcessingState.idle,
            ),
          );
        } else if (event is ChatStreamFailure) {
          terminalEventSeen = true;
          _upsertAssistant(
            emit,
            userMessage,
            assistantMessageId,
            status: MessageStatus.failed,
            isLoading: false,
          );
          emit(
            state.copyWith(
              error: event.message,
              isLoading: false,
              aiProcessingState: AiProcessingState.idle,
            ),
          );
        }
      }
      if (!terminalEventSeen) {
        throw const ChatRepositoryException(
          'Kết nối bị gián đoạn trước khi hoàn tất.',
        );
      }
    } on ChatRepositoryException catch (error) {
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
          error: error.message,
          sessionExpired: error.sessionExpired,
        ),
      );
    }
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
    Object? executedResult,
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
