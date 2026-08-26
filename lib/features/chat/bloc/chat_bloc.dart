import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../data/chat_repository.dart';
import '../data/mock_chat_repository.dart';
import '../models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

export 'chat_event.dart';
export 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._repository, {AudioRecorder? recorder})
    : _recorder = recorder ?? AudioRecorder(),
      super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<MessageChanged>(_onMessageChanged);
    on<SendTextMessage>(_onSendText);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<CancelRecording>(_onCancelRecording);
    on<SendVoiceMessage>(_onSendVoice);
    on<RetryMessage>(_onRetry);
    on<RecordingTicked>(_onRecordingTicked);
  }

  final ChatRepository _repository;
  final AudioRecorder _recorder;
  Timer? _recordingTimer;

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
        clearError: true,
      ),
    );
    try {
      if (!await _recorder.hasPermission()) {
        emit(
          state.copyWith(
            recordingState: RecordingState.idle,
            error: 'Vui lòng cấp quyền microphone để gửi tin nhắn thoại.',
          ),
        );
        return;
      }
      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
      _recordingTimer?.cancel();
      _recordingTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => add(const RecordingTicked()),
      );
      emit(
        state.copyWith(
          recordingState: RecordingState.recording,
          recordingDuration: Duration.zero,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          error: 'Không thể bắt đầu ghi âm. Vui lòng thử lại.',
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
    if (!state.isRecording) return;
    _recordingTimer?.cancel();
    try {
      final duration = state.recordingDuration;
      final path = await _recorder.stop();
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          recordingDuration: Duration.zero,
        ),
      );
      if (path == null || duration < const Duration(seconds: 1)) {
        emit(state.copyWith(error: 'Bản ghi âm quá ngắn. Vui lòng thử lại.'));
        return;
      }
      add(SendVoiceMessage(path, duration));
    } catch (_) {
      emit(
        state.copyWith(
          recordingState: RecordingState.idle,
          recordingDuration: Duration.zero,
          error: 'Không thể hoàn tất bản ghi âm.',
        ),
      );
    }
  }

  Future<void> _onCancelRecording(
    CancelRecording event,
    Emitter<ChatState> emit,
  ) async {
    if (!state.isRecording) return;
    _recordingTimer?.cancel();
    try {
      final path = await _recorder.stop();
      if (path != null) {
        final file = File(path);
        if (await file.exists()) await file.delete();
      }
    } catch (_) {
      // Audio cleanup failure does not need to block the conversation.
    }
    emit(
      state.copyWith(
        recordingState: RecordingState.idle,
        recordingDuration: Duration.zero,
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
      audioPath: event.audioPath,
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
    try {
      final responseFuture = userMessage.type == MessageType.audio
          ? _repository.sendVoiceMessage(userMessage.audioPath!)
          : _repository.sendTextMessage(userMessage.content!);
      await Future<void>.delayed(const Duration(milliseconds: 450));
      emit(state.copyWith(aiProcessingState: AiProcessingState.understanding));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(aiProcessingState: AiProcessingState.callingApi));
      final response = await responseFuture;
      final delivered = state.messages
          .map(
            (item) => item.id == userMessage.id
                ? item.copyWith(status: MessageStatus.sent)
                : item,
          )
          .toList();
      emit(
        state.copyWith(
          messages: [...delivered, response],
          isLoading: false,
          aiProcessingState: AiProcessingState.idle,
          clearError: true,
        ),
      );
    } catch (error) {
      final failed = state.messages
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

  @override
  Future<void> close() async {
    _recordingTimer?.cancel();
    await _recorder.dispose();
    return super.close();
  }
}
