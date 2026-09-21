import 'dart:async';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../domain/repository/speech_to_text_repository.dart';

class DeviceSpeechToTextRepository
    implements SpeechToTextRepository, SpeechInputLevel {
  DeviceSpeechToTextRepository({stt.SpeechToText? speechToText})
    : _speech = speechToText ?? stt.SpeechToText();

  final stt.SpeechToText _speech;
  final _transcriptController = StreamController<SpeechTranscript>.broadcast();
  final _statusController = StreamController<SpeechSessionStatus>.broadcast();
  final _errorController = StreamController<String>.broadcast();
  final _levelController = StreamController<double>.broadcast();

  bool _initialized = false;
  bool _isStopping = false;
  String _latestTranscript = '';

  @override
  Stream<SpeechTranscript> get transcripts => _transcriptController.stream;

  @override
  Stream<SpeechSessionStatus> get statuses => _statusController.stream;

  @override
  Stream<String> get errors => _errorController.stream;

  @override
  Stream<double> get inputLevels => _levelController.stream;

  @override
  Future<bool> hasPermission() => _speech.hasPermission;

  @override
  Future<bool> initialize() async {
    if (_initialized) return true;
    _initialized = await _speech.initialize(
      onStatus: _handleStatus,
      onError: _handleError,
    );
    return _initialized;
  }

  @override
  Future<void> startListening() async {
    if (!await initialize()) {
      throw const SpeechToTextException(
        'Nhận dạng giọng nói không khả dụng trên thiết bị.',
      );
    }
    _latestTranscript = '';
    _isStopping = false;
    final localeId = await _vietnameseLocaleId();
    await _speech.listen(
      onResult: _handleResult,
      onSoundLevelChange: (level) {
        if (!_levelController.isClosed) {
          _levelController.add(((level + 2) / 12).clamp(0.0, 1.0));
        }
      },
      listenOptions: stt.SpeechListenOptions(
        localeId: localeId,
        listenFor: const Duration(minutes: 1),
        pauseFor: const Duration(seconds: 4),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      ),
    );
    _statusController.add(SpeechSessionStatus.listening);
  }

  @override
  Future<String> stopListening() async {
    _isStopping = true;
    try {
      await _speech.stop();
      return _latestTranscript.trim();
    } finally {
      _isStopping = false;
      _statusController.add(SpeechSessionStatus.idle);
    }
  }

  @override
  Future<void> cancelListening() async {
    _isStopping = true;
    try {
      await _speech.cancel();
      _latestTranscript = '';
    } finally {
      _isStopping = false;
      _statusController.add(SpeechSessionStatus.idle);
    }
  }

  void _handleResult(SpeechRecognitionResult result) {
    _latestTranscript = result.recognizedWords;
    _transcriptController.add(
      SpeechTranscript(text: _latestTranscript, isFinal: result.finalResult),
    );
  }

  void _handleStatus(String status) {
    if (_isStopping) return;
    if (status == stt.SpeechToText.doneStatus ||
        status == stt.SpeechToText.notListeningStatus) {
      _statusController.add(SpeechSessionStatus.done);
    }
  }

  void _handleError(SpeechRecognitionError error) {
    if (_isStopping) return;
    _errorController.add(
      error.permanent
          ? 'Quyền nhận dạng giọng nói bị từ chối.'
          : 'Không thể nhận dạng giọng nói. Vui lòng thử lại.',
    );
  }

  Future<String?> _vietnameseLocaleId() async {
    final locales = await _speech.locales();
    for (final locale in locales) {
      if (locale.localeId.toLowerCase().startsWith('vi')) {
        return locale.localeId;
      }
    }
    return null;
  }

  @override
  Future<void> close() async {
    await _speech.cancel();
    await _transcriptController.close();
    await _statusController.close();
    await _errorController.close();
    await _levelController.close();
  }
}

class SpeechToTextException implements Exception {
  const SpeechToTextException(this.message);
  final String message;
}
