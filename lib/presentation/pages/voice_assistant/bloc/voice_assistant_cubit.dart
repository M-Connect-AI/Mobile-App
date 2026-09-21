import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_stream_event.dart';
import '../../../../domain/repository/chat_repository.dart';
import '../../../../domain/repository/speech_to_text_repository.dart';
import '../../../../domain/repository/voice_assistant_chat_repository.dart';

enum VoiceAssistantStatus {
  initializing,
  permissionRequired,
  listening,
  paused,
  processing,
  success,
  error,
}

enum VoiceAssistantError {
  permission,
  unavailable,
  noSpeech,
  recognition,
  network,
  chatbot,
}

class VoiceAssistantState extends Equatable {
  const VoiceAssistantState({
    this.status = VoiceAssistantStatus.initializing,
    this.committedTranscript = '',
    this.partialTranscript = '',
    this.answer = '',
    this.threadId,
    this.inputLevel = 0,
    this.permissionNeeded = false,
    this.permissionAttempted = false,
    this.error,
    this.errorDetail,
    this.sessionExpired = false,
  });

  final VoiceAssistantStatus status;
  final String committedTranscript;
  final String partialTranscript;
  final String answer;
  final String? threadId;
  final double inputLevel;
  final bool permissionNeeded;
  final bool permissionAttempted;
  final VoiceAssistantError? error;
  final String? errorDetail;
  final bool sessionExpired;

  String get displayTranscript => VoiceAssistantCubit.joinTranscript(
    committedTranscript,
    partialTranscript,
  );

  bool get canSend =>
      displayTranscript.trim().isNotEmpty &&
      status != VoiceAssistantStatus.initializing &&
      status != VoiceAssistantStatus.processing &&
      status != VoiceAssistantStatus.success;

  VoiceAssistantState copyWith({
    VoiceAssistantStatus? status,
    String? committedTranscript,
    String? partialTranscript,
    String? answer,
    String? threadId,
    double? inputLevel,
    bool? permissionNeeded,
    bool? permissionAttempted,
    VoiceAssistantError? error,
    String? errorDetail,
    bool? sessionExpired,
    bool clearError = false,
  }) => VoiceAssistantState(
    status: status ?? this.status,
    committedTranscript: committedTranscript ?? this.committedTranscript,
    partialTranscript: partialTranscript ?? this.partialTranscript,
    answer: answer ?? this.answer,
    threadId: threadId ?? this.threadId,
    inputLevel: inputLevel ?? this.inputLevel,
    permissionNeeded: permissionNeeded ?? this.permissionNeeded,
    permissionAttempted: permissionAttempted ?? this.permissionAttempted,
    error: clearError ? null : error ?? this.error,
    errorDetail: clearError ? null : errorDetail ?? this.errorDetail,
    sessionExpired: sessionExpired ?? this.sessionExpired,
  );

  @override
  List<Object?> get props => [
    status,
    committedTranscript,
    partialTranscript,
    answer,
    threadId,
    inputLevel,
    permissionNeeded,
    permissionAttempted,
    error,
    errorDetail,
    sessionExpired,
  ];
}

class VoiceAssistantCubit extends Cubit<VoiceAssistantState> {
  VoiceAssistantCubit(this._speech, this._chat)
    : super(const VoiceAssistantState()) {
    _transcripts = _speech.transcripts.listen((result) {
      if (isClosed || state.status != VoiceAssistantStatus.listening) return;
      emit(state.copyWith(partialTranscript: result.text));
    });
    _statuses = _speech.statuses.listen((status) {
      if (status == SpeechSessionStatus.done &&
          state.status == VoiceAssistantStatus.listening) {
        unawaited(pauseListening(timedOut: true));
      }
    });
    _errors = _speech.errors.listen((_) {
      if (state.status == VoiceAssistantStatus.listening) {
        unawaited(_failRecognition());
      }
    });
    if (_speech case SpeechInputLevel levels) {
      _levels = levels.inputLevels.listen((level) {
        if (!isClosed && state.status == VoiceAssistantStatus.listening) {
          emit(state.copyWith(inputLevel: level));
        }
      });
    }
  }

  final SpeechToTextRepository _speech;
  final VoiceAssistantChatRepository _chat;
  late final StreamSubscription<SpeechTranscript> _transcripts;
  late final StreamSubscription<SpeechSessionStatus> _statuses;
  late final StreamSubscription<String> _errors;
  StreamSubscription<double>? _levels;
  StreamSubscription<ChatStreamEvent>? _chatEvents;
  Future<String>? _stopInFlight;
  Future<void>? _resetInFlight;
  Timer? _silenceTimer;
  int _generation = 0;

  static String joinTranscript(String committed, String partial) {
    final previous = committed.trim();
    final current = partial.trim();
    if (previous.isEmpty) return current;
    if (current.isEmpty) return previous;
    if (previous == current || previous.endsWith(' $current')) return previous;
    final previousWords = previous.split(RegExp(r'\s+'));
    final currentWords = current.split(RegExp(r'\s+'));
    final maxOverlap = previousWords.length < currentWords.length
        ? previousWords.length
        : currentWords.length;
    for (var count = maxOverlap; count > 0; count--) {
      final suffix = previousWords.sublist(previousWords.length - count);
      final prefix = currentWords.take(count).toList();
      if (suffix.join(' ').toLowerCase() == prefix.join(' ').toLowerCase()) {
        final remainder = currentWords.skip(count).join(' ');
        return remainder.isEmpty ? previous : '$previous $remainder';
      }
    }
    return '$previous $current';
  }

  Future<void> prepare() async {
    if (isClosed) return;
    emit(state.copyWith(status: VoiceAssistantStatus.initializing));
    try {
      if (await _speech.hasPermission()) {
        await startListening();
      } else if (!isClosed) {
        emit(
          state.copyWith(
            status: VoiceAssistantStatus.permissionRequired,
            permissionNeeded: true,
          ),
        );
      }
    } on Object {
      if (!isClosed) _fail(VoiceAssistantError.unavailable);
    }
  }

  Future<void> requestPermission() async {
    if (isClosed) return;
    emit(state.copyWith(permissionAttempted: true));
    await startListening();
  }

  Future<void> startListening() async {
    if (isClosed ||
        state.status == VoiceAssistantStatus.listening ||
        state.status == VoiceAssistantStatus.initializing &&
            _stopInFlight != null ||
        state.status == VoiceAssistantStatus.processing) {
      return;
    }
    final generation = ++_generation;
    _silenceTimer?.cancel();
    emit(
      state.copyWith(
        status: VoiceAssistantStatus.initializing,
        committedTranscript: joinTranscript(
          state.committedTranscript,
          state.partialTranscript,
        ),
        partialTranscript: '',
        inputLevel: 0,
        permissionNeeded: state.permissionNeeded,
        clearError: true,
      ),
    );
    try {
      await _stopInFlight;
      await _chatEvents?.cancel();
      _chatEvents = null;
      final available = await _speech.initialize();
      if (generation != _generation || isClosed) return;
      if (!available) {
        final permitted = await _speech.hasPermission();
        if (generation != _generation || isClosed) return;
        _fail(
          permitted
              ? VoiceAssistantError.unavailable
              : VoiceAssistantError.permission,
        );
        return;
      }
      if (!await _speech.hasPermission()) {
        if (generation == _generation && !isClosed) {
          _fail(VoiceAssistantError.permission);
        }
        return;
      }
      await _speech.startListening();
      if (generation != _generation || isClosed) {
        await _speech.cancelListening();
        return;
      }
      emit(
        state.copyWith(
          status: VoiceAssistantStatus.listening,
          permissionNeeded: false,
        ),
      );
      _silenceTimer = Timer(const Duration(seconds: 12), () {
        if (!isClosed &&
            state.status == VoiceAssistantStatus.listening &&
            state.partialTranscript.trim().isEmpty) {
          unawaited(pauseListening(timedOut: true));
        }
      });
    } on Object {
      if (!isClosed && generation == _generation) {
        var hasPermission = true;
        try {
          hasPermission = await _speech.hasPermission();
        } on Object {
          // Keep the speech error when the permission query also fails.
        }
        if (!isClosed && generation == _generation) {
          _fail(
            hasPermission
                ? VoiceAssistantError.unavailable
                : VoiceAssistantError.permission,
          );
        }
      }
    }
  }

  Future<String> _stopCapture() {
    final active = _stopInFlight;
    if (active != null) return active;
    final stopping = _speech.stopListening();
    _stopInFlight = stopping;
    stopping.then(
      (_) {
        if (identical(_stopInFlight, stopping)) _stopInFlight = null;
      },
      onError: (Object _) {
        if (identical(_stopInFlight, stopping)) _stopInFlight = null;
      },
    );
    return stopping;
  }

  Future<void> pauseListening({bool timedOut = false}) async {
    if (isClosed || state.status != VoiceAssistantStatus.listening) return;
    final generation = ++_generation;
    _silenceTimer?.cancel();
    emit(state.copyWith(status: VoiceAssistantStatus.paused, inputLevel: 0));
    try {
      final recognized = await _stopCapture();
      if (isClosed || generation != _generation) return;
      final latest = recognized.trim().isNotEmpty
          ? recognized
          : state.partialTranscript;
      final committed = joinTranscript(state.committedTranscript, latest);
      emit(
        state.copyWith(committedTranscript: committed, partialTranscript: ''),
      );
      if (timedOut && committed.isEmpty) _fail(VoiceAssistantError.noSpeech);
    } on Object {
      if (!isClosed && generation == _generation) {
        _fail(VoiceAssistantError.recognition);
      }
    }
  }

  Future<void> toggleListening() =>
      state.status == VoiceAssistantStatus.listening
      ? pauseListening()
      : startListening();

  Future<void> reset() {
    if (isClosed ||
        state.status == VoiceAssistantStatus.processing ||
        state.status == VoiceAssistantStatus.initializing &&
            _resetInFlight != null) {
      return _resetInFlight ?? Future<void>.value();
    }
    final active = _resetInFlight;
    if (active != null) return active;
    final work = _reset();
    _resetInFlight = work;
    work.whenComplete(() {
      if (identical(_resetInFlight, work)) _resetInFlight = null;
    });
    return work;
  }

  Future<void> _reset() async {
    final generation = ++_generation;
    _silenceTimer?.cancel();
    final wasListening = state.status == VoiceAssistantStatus.listening;
    emit(
      state.copyWith(
        status: VoiceAssistantStatus.initializing,
        committedTranscript: '',
        partialTranscript: '',
        answer: '',
        inputLevel: 0,
        clearError: true,
      ),
    );
    try {
      await _stopInFlight;
      if (wasListening) await _speech.cancelListening();
      if (isClosed || generation != _generation) return;
      // Reset must not reuse the transcript returned by the previous recognizer.
      emit(state.copyWith(status: VoiceAssistantStatus.paused));
      await startListening();
    } on Object {
      if (!isClosed && generation == _generation) {
        _fail(VoiceAssistantError.recognition);
      }
    }
  }

  Future<void> send() async {
    if (isClosed || !state.canSend) return;
    final wasListening = state.status == VoiceAssistantStatus.listening;
    final generation = ++_generation;
    _silenceTimer?.cancel();
    emit(
      state.copyWith(status: VoiceAssistantStatus.processing, inputLevel: 0),
    );
    try {
      final recognized = wasListening
          ? await _stopCapture()
          : await _stopInFlight ?? '';
      if (isClosed || generation != _generation) return;
      final latest = recognized.trim().isNotEmpty
          ? recognized
          : state.partialTranscript;
      final text = joinTranscript(state.committedTranscript, latest).trim();
      if (text.isEmpty) {
        emit(state.copyWith(status: VoiceAssistantStatus.paused));
        return;
      }
      emit(
        state.copyWith(
          committedTranscript: text,
          partialTranscript: '',
          answer: '',
          clearError: true,
        ),
      );
      _chatEvents = _chat
          .sendMessage(message: text, threadId: state.threadId)
          .listen(
            (event) {
              if (isClosed || generation != _generation) return;
              switch (event) {
                case ChatStreamToken(:final text):
                  emit(state.copyWith(answer: '${state.answer}$text'));
                case ChatStreamDone(:final reply, :final threadId):
                  emit(
                    state.copyWith(
                      status: VoiceAssistantStatus.success,
                      answer: reply.isEmpty ? state.answer : reply,
                      threadId: threadId.isEmpty ? null : threadId,
                    ),
                  );
                case ChatStreamFailure(:final message):
                  _fail(VoiceAssistantError.chatbot, detail: message);
                default:
                  break;
              }
            },
            onError: (Object error) {
              if (isClosed || generation != _generation) return;
              if (error is ChatRepositoryException) {
                if (error.sessionExpired) {
                  emit(state.copyWith(sessionExpired: true));
                }
                _fail(
                  error.network
                      ? VoiceAssistantError.network
                      : VoiceAssistantError.chatbot,
                  detail: error.message,
                );
              } else {
                _fail(VoiceAssistantError.network);
              }
            },
            onDone: () {
              if (!isClosed &&
                  generation == _generation &&
                  state.status == VoiceAssistantStatus.processing) {
                _fail(VoiceAssistantError.network);
              }
            },
          );
    } on Object {
      if (!isClosed && generation == _generation) {
        _fail(VoiceAssistantError.recognition);
      }
    }
  }

  Future<void> _failRecognition() async {
    _generation++;
    _silenceTimer?.cancel();
    var hasPermission = true;
    try {
      await _speech.cancelListening();
      hasPermission = await _speech.hasPermission();
    } on Object {
      // Preserve the first recognition failure.
    }
    if (!isClosed) {
      _fail(
        hasPermission
            ? VoiceAssistantError.recognition
            : VoiceAssistantError.permission,
      );
    }
  }

  void _fail(VoiceAssistantError error, {String? detail}) {
    _silenceTimer?.cancel();
    emit(
      state.copyWith(
        status: error == VoiceAssistantError.permission
            ? VoiceAssistantStatus.permissionRequired
            : VoiceAssistantStatus.error,
        error: error,
        errorDetail: detail,
        inputLevel: 0,
        permissionNeeded: error == VoiceAssistantError.permission,
      ),
    );
  }

  Future<void> stopForBackground() async {
    final wasListening = state.status == VoiceAssistantStatus.listening;
    _generation++;
    _silenceTimer?.cancel();
    await _chatEvents?.cancel();
    if (wasListening) {
      try {
        final recognized = await _stopCapture();
        if (!isClosed) {
          emit(
            state.copyWith(
              committedTranscript: joinTranscript(
                state.committedTranscript,
                recognized.trim().isNotEmpty
                    ? recognized
                    : state.partialTranscript,
              ),
              partialTranscript: '',
            ),
          );
        }
      } on Object {
        await _speech.cancelListening();
      }
    } else {
      await _stopInFlight;
    }
    if (!isClosed &&
        state.status != VoiceAssistantStatus.success &&
        state.status != VoiceAssistantStatus.permissionRequired &&
        state.status != VoiceAssistantStatus.error &&
        !state.permissionNeeded) {
      emit(state.copyWith(status: VoiceAssistantStatus.paused, inputLevel: 0));
    }
  }

  @override
  Future<void> close() async {
    await stopForBackground();
    await _transcripts.cancel();
    await _statuses.cancel();
    await _errors.cancel();
    await _levels?.cancel();
    return super.close();
  }
}
