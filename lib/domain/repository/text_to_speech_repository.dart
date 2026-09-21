abstract interface class TextToSpeechRepository {
  bool get isAvailable;
  Future<void> speak(String text);
  Future<void> stop();
}
