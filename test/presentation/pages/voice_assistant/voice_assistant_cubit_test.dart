import 'dart:async';

import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/domain/repository/voice_assistant_chat_repository.dart';
import 'package:chatbot_project/presentation/pages/voice_assistant/bloc/voice_assistant_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('starts automatically when microphone permission is granted', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);

    await cubit.prepare();
    expect(cubit.state.status, VoiceAssistantStatus.listening);
    expect(speech.startCount, 1);
    expect(chat.sentMessages, isEmpty);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('listening to paused commits transcript without sending', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();

    speech.addTranscript('Xin chào');
    await Future<void>.delayed(Duration.zero);
    await cubit.pauseListening();

    expect(cubit.state.status, VoiceAssistantStatus.paused);
    expect(cubit.state.committedTranscript, 'Xin chào');
    expect(cubit.state.partialTranscript, isEmpty);
    expect(chat.sentMessages, isEmpty);
    expect(speech.stopCount, 1);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test(
    'paused to listening appends new speech without duplicated boundary',
    () async {
      final speech = _Speech();
      final chat = _Chat();
      final cubit = VoiceAssistantCubit(speech, chat);
      await cubit.prepare();
      speech.addTranscript('Xin chào');
      await Future<void>.delayed(Duration.zero);
      await cubit.pauseListening();

      await cubit.startListening();
      speech.addTranscript('chào bạn');
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.displayTranscript, 'Xin chào bạn');
      await cubit.pauseListening();
      expect(cubit.state.committedTranscript, 'Xin chào bạn');
      await cubit.startListening();
      speech.addTranscript('và cảm ơn');
      await Future<void>.delayed(Duration.zero);
      await cubit.pauseListening();
      expect(cubit.state.committedTranscript, 'Xin chào bạn và cảm ơn');
      expect(chat.sentMessages, isEmpty);

      await cubit.close();
      await speech.dispose();
      await chat.events.close();
    },
  );

  test('pausing before speech keeps the session ready to resume', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();

    await cubit.pauseListening();
    expect(cubit.state.status, VoiceAssistantStatus.paused);
    expect(cubit.state.displayTranscript, isEmpty);
    await cubit.startListening();
    expect(cubit.state.status, VoiceAssistantStatus.listening);
    expect(chat.sentMessages, isEmpty);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test(
    'reset clears both transcript parts and starts a fresh recording',
    () async {
      final speech = _Speech();
      final chat = _Chat();
      final cubit = VoiceAssistantCubit(speech, chat);
      await cubit.prepare();
      speech.addTranscript('Lời cũ');
      await Future<void>.delayed(Duration.zero);
      await cubit.pauseListening();
      await cubit.startListening();
      speech.addTranscript('Đang nói');
      await Future<void>.delayed(Duration.zero);

      final firstReset = cubit.reset();
      final secondReset = cubit.reset();
      await Future.wait([firstReset, secondReset]);

      expect(cubit.state.status, VoiceAssistantStatus.listening);
      expect(cubit.state.displayTranscript, isEmpty);
      expect(speech.startCount, 3);
      expect(chat.sentMessages, isEmpty);

      await cubit.close();
      await speech.dispose();
      await chat.events.close();
    },
  );

  test(
    'send stops recording, commits late result and rejects duplicate sends',
    () async {
      final speech = _Speech();
      final chat = _Chat();
      final cubit = VoiceAssistantCubit(speech, chat);
      await cubit.prepare();
      speech.addTranscript('  Nội dung ');
      await Future<void>.delayed(Duration.zero);
      speech.pendingStop = Completer<String>();

      final sending = cubit.send();
      final duplicate = cubit.send();
      speech.addTranscript('  Nội dung cuối  ');
      speech.pendingStop!.complete('  Nội dung cuối  ');
      await Future.wait([sending, duplicate]);

      expect(cubit.state.status, VoiceAssistantStatus.processing);
      expect(cubit.state.committedTranscript, 'Nội dung cuối');
      expect(speech.stopCount, 1);
      expect(chat.sentMessages, ['Nội dung cuối']);
      chat.events.add(
        const ChatStreamDone(threadId: '', reply: 'Phản hồi mẫu'),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, VoiceAssistantStatus.success);
      expect(cubit.state.answer, 'Phản hồi mẫu');

      await cubit.close();
      await speech.dispose();
      await chat.events.close();
    },
  );

  test('empty or whitespace-only transcript never sends', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    await cubit.send();
    speech.addTranscript('   ');
    await Future<void>.delayed(Duration.zero);
    await cubit.send();
    expect(chat.sentMessages, isEmpty);
    expect(cubit.state.status, VoiceAssistantStatus.listening);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('sending after pause uses the full committed transcript', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.addTranscript('Lượt đầu');
    await Future<void>.delayed(Duration.zero);
    await cubit.pauseListening();
    await cubit.startListening();
    speech.addTranscript('lượt sau');
    await Future<void>.delayed(Duration.zero);
    await cubit.pauseListening();

    await cubit.send();
    expect(chat.sentMessages, ['Lượt đầu lượt sau']);
    expect(speech.stopCount, 2);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('recognizer timeout pauses and does not send', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.addTranscript('Đang nói');
    await Future<void>.delayed(Duration.zero);
    speech.statusController.add(SpeechSessionStatus.done);
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.status, VoiceAssistantStatus.paused);
    expect(cubit.state.committedTranscript, 'Đang nói');
    expect(chat.sentMessages, isEmpty);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('closing during processing cancels response stream', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.addTranscript('Xin chào');
    await Future<void>.delayed(Duration.zero);
    await cubit.send();
    await cubit.close();
    expect(chat.events.hasListener, isFalse);

    await speech.dispose();
    await chat.events.close();
  });

  test('does not record before permission is granted', () async {
    final speech = _Speech()..permission = false;
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    expect(cubit.state.permissionNeeded, isTrue);
    expect(cubit.state.status, VoiceAssistantStatus.permissionRequired);
    expect(speech.startCount, 0);

    await cubit.requestPermission();
    expect(cubit.state.permissionAttempted, isTrue);
    expect(cubit.state.status, VoiceAssistantStatus.permissionRequired);
    expect(speech.startCount, 0);

    speech.permission = true;
    await cubit.requestPermission();
    expect(cubit.state.status, VoiceAssistantStatus.listening);
    expect(speech.startCount, 1);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('reports microphone permission lost during recording', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.permission = false;
    speech.errorController.add('permission denied');
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.status, VoiceAssistantStatus.permissionRequired);
    expect(cubit.state.error, VoiceAssistantError.permission);
    expect(chat.sentMessages, isEmpty);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('chatbot failure preserves the transcript for retry', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.addTranscript('Giữ nội dung này');
    await Future<void>.delayed(Duration.zero);
    await cubit.send();
    chat.events.add(const ChatStreamFailure('Không thể xử lý'));
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.status, VoiceAssistantStatus.error);
    expect(cubit.state.displayTranscript, 'Giữ nội dung này');
    expect(cubit.state.canSend, isTrue);
    expect(chat.sentMessages, ['Giữ nội dung này']);

    await cubit.close();
    await speech.dispose();
    await chat.events.close();
  });

  test('closing an unsent recording never contacts the chatbot', () async {
    final speech = _Speech();
    final chat = _Chat();
    final cubit = VoiceAssistantCubit(speech, chat);
    await cubit.prepare();
    speech.addTranscript('Chưa gửi');
    await Future<void>.delayed(Duration.zero);
    await cubit.close();

    expect(chat.sentMessages, isEmpty);
    expect(speech.stopCount, 1);
    await speech.dispose();
    await chat.events.close();
  });
}

class _Speech implements SpeechToTextRepository {
  final transcriptController = StreamController<SpeechTranscript>.broadcast();
  final statusController = StreamController<SpeechSessionStatus>.broadcast();
  final errorController = StreamController<String>.broadcast();
  bool permission = true;
  String latest = '';
  String? stopResult;
  Completer<String>? pendingStop;
  int startCount = 0;
  int stopCount = 0;

  void addTranscript(String text) {
    latest = text;
    transcriptController.add(SpeechTranscript(text: text, isFinal: false));
  }

  @override
  Stream<SpeechTranscript> get transcripts => transcriptController.stream;
  @override
  Stream<SpeechSessionStatus> get statuses => statusController.stream;
  @override
  Stream<String> get errors => errorController.stream;
  @override
  Future<bool> hasPermission() async => permission;
  @override
  Future<bool> initialize() async => true;
  @override
  Future<void> startListening() async {
    startCount++;
    latest = '';
    stopResult = null;
  }

  @override
  Future<String> stopListening() async {
    stopCount++;
    if (pendingStop case final pending?) return pending.future;
    return stopResult ?? latest;
  }

  @override
  Future<void> cancelListening() async {}
  @override
  Future<void> close() => dispose();

  Future<void> dispose() async {
    await transcriptController.close();
    await statusController.close();
    await errorController.close();
  }
}

class _Chat implements VoiceAssistantChatRepository {
  final events = StreamController<ChatStreamEvent>.broadcast();
  final sentMessages = <String>[];

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
  }) {
    sentMessages.add(message);
    return events.stream;
  }
}
