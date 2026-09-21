import '../../domain/repository/text_to_speech_repository.dart';

/// Placeholder until a platform TTS engine is wired into the app.
class UnavailableTextToSpeechRepository implements TextToSpeechRepository {
  const UnavailableTextToSpeechRepository();

  @override
  bool get isAvailable => false;

  @override
  Future<void> speak(String text) async {}

  @override
  Future<void> stop() async {}
}
