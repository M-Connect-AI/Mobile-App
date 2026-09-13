abstract interface class SpeechToTextRepository {
  Stream<SpeechTranscript> get transcripts;
  Stream<SpeechSessionStatus> get statuses;
  Stream<String> get errors;

  Future<bool> hasPermission();
  Future<bool> initialize();
  Future<void> startListening();
  Future<String> stopListening();
  Future<void> cancelListening();
  Future<void> close();
}

class SpeechTranscript {
  const SpeechTranscript({required this.text, required this.isFinal});

  final String text;
  final bool isFinal;
}

enum SpeechSessionStatus { idle, listening, done }
