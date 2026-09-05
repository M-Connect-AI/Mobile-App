import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_message.dart';
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

  void _onStarted(ChatStarted event, Emitter<ChatState> emit) {
    emit(
      state.copyWith(
        messages: [
          ChatMessage(
            id: 'welcome',
            type: MessageType.text,
            sender: MessageSender.assistant,
            content:
                'Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?',
            createdAt: DateTime.now(),
            status: MessageStatus.success,
          ),
        ],
      ),
    );
  }

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

  Future<void> _sendAndReceive(
    ChatMessage userMessage,
    Emitter<ChatState> emit,
  ) async {
    String? assistantMessageId;
    try {
      final responseStream = userMessage.type == MessageType.audio
          ? _chatRepository.sendVoiceMessage(userMessage.content!)
          : _chatRepository.sendTextMessage(userMessage.content!);
      await Future<void>.delayed(const Duration(milliseconds: 450));
      emit(
        state.copyWith(aiProcessingState: AiProcessingState.generatingResponse),
      );
      var receivedResponse = false;
      await for (final response in responseStream) {
        if (kDebugMode) {
          debugPrint(
            '[ChatBloc] message update: id=${response.id}, '
            'status=${response.status.name}, '
            'chars=${response.content?.length ?? 0}',
          );
        }
        receivedResponse = true;
        assistantMessageId = response.id;
        final updated = state.messages
            .map(
              (item) => item.id == userMessage.id
                  ? item.copyWith(status: MessageStatus.sent)
                  : item.id == response.id
                  ? response
                  : item,
            )
            .toList();
        if (!updated.any((item) => item.id == response.id)) {
          updated.add(response);
        }
        final completed = response.status == MessageStatus.success;
        emit(
          state.copyWith(
            messages: updated,
            isLoading: !completed,
            aiProcessingState: completed
                ? AiProcessingState.idle
                : AiProcessingState.generatingResponse,
            clearError: true,
          ),
        );
      }
      if (!receivedResponse) {
        throw const ChatRepositoryException(
          'Phản hồi chatbot không có nội dung.',
        );
      }
    } catch (error) {
      final failed = state.messages
          .where((item) => item.id != assistantMessageId)
          .map(
            (item) => item.id == userMessage.id
                ? item.copyWith(status: MessageStatus.failed)
                : item,
          )
          .toList();
      emit(
        state.copyWith(
          messages: failed,
          isLoading: false,
          aiProcessingState: AiProcessingState.idle,
          error: error is ChatRepositoryException
              ? error.message
              : 'Đã có lỗi xảy ra. Vui lòng thử lại.',
        ),
      );
    }
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
