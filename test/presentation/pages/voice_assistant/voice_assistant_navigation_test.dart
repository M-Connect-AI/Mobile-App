import 'dart:async';

import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('granted microphone opens chat and starts recording', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await _settleRecorder(tester);

    expect(find.byKey(const Key('voice-recorder')), findsOneWidget);
    expect(find.byKey(const Key('stop-send-voice')), findsOneWidget);
    expect(find.text(S.current.voiceListening), findsOneWidget);
    expect(speech.starts, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('denied microphone shows the permission dialog and can cancel', (tester) async {
    final speech = _Speech()..permission = false;
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('microphone-permission-dialog')), findsOneWidget);
    expect(find.text(S.current.microphonePermissionTitle), findsOneWidget);

    await tester.tap(find.text(S.current.cancelButton));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('microphone-permission-dialog')), findsNothing);
    expect(find.byKey(const Key('voice-recorder')), findsNothing);
    expect(find.byKey(const Key('home-chat-input')), findsOneWidget);
    expect(speech.starts, 0);
  });

  testWidgets('confirming the permission dialog opens chat recording', (tester) async {
    final speech = _Speech()..permission = false;
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S.current.microphonePermissionContinue));
    await _settleRecorder(tester);

    expect(find.byKey(const Key('voice-recorder')), findsOneWidget);
    expect(speech.starts, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sending a recording uses the chat API once', (tester) async {
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await _settleRecorder(tester);
    speech.latest = 'Xem đơn nghỉ phép';
    speech.addTranscript('Xem đơn nghỉ phép');
    await tester.pump();

    await tester.tap(find.byKey(const Key('stop-send-voice')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // The recorder is dismissed once the transcript is sent to the chat API.
    expect(find.byKey(const Key('voice-recorder')), findsNothing);
    expect(speech.stops, 1);
    expect(chat.sends, 1);
    expect(chat.lastMessage, 'Xem đơn nghỉ phép');
  });

  testWidgets('cancelling a recording returns to the chat input', (tester) async {
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await _settleRecorder(tester);
    expect(find.byKey(const Key('voice-recorder')), findsOneWidget);

    await tester.tap(find.text(S.current.cancelButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byKey(const Key('voice-recorder')), findsNothing);
    expect(find.byKey(const Key('chat-text-field')), findsOneWidget);
    expect(speech.cancels, 1);
    expect(chat.sends, 0);
  });

  testWidgets('long transcript keeps recorder controls visible on a narrow screen', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.binding.platformDispatcher.clearTextScaleFactorTestValue);
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);

    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await _settleRecorder(tester);
    speech.addTranscript(List.filled(80, 'Nội dung cần kiểm tra').join(' '));
    await tester.pump();

    expect(find.byKey(const Key('voice-recorder')), findsOneWidget);
    expect(find.byKey(const Key('stop-send-voice')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

/// The voice recorder renders a continuous waveform animation, so
/// [WidgetTester.pumpAndSettle] never completes while it is on screen.
/// Pump fixed frames instead to let the route transition and the initial
/// recording state settle.
Future<void> _settleRecorder(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> _pumpApp(
  WidgetTester tester,
  _Speech speech, {
  _NoNetworkChatRepository? chatRepository,
}) async {
  final chat = chatRepository ?? _NoNetworkChatRepository();
  final router = GoRouter(initialLocation: HomeChatAiRoute.path, routes: appRoutes);
  addTearDown(router.dispose);
  addTearDown(speech.dispose);
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatThreadRepository>.value(value: const _Threads()),
        RepositoryProvider<ChatRepository>.value(value: chat),
        RepositoryProvider<CredentialRepository>.value(value: const _Credentials()),
        RepositoryProvider<SpeechToTextRepository>.value(value: speech),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.light,
          locale: const Locale('vi'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _NoNetworkChatRepository implements ChatRepository {
  int sends = 0;
  String? lastMessage;
  bool failSend = false;

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
    bool confirm = false,
    ChatConfirmationTool? confirmedTool,
  }) {
    sends++;
    lastMessage = message;
    if (failSend) {
      return Stream.value(const ChatStreamFailure('Lỗi máy chủ'));
    }
    return Stream.fromIterable(const [
      ChatStreamToken('Kết quả thật'),
      ChatStreamDone(threadId: 'voice-thread', reply: 'Kết quả thật'),
    ]);
  }

  @override
  Future<ChatThreadDetail> getThread(String threadId) async =>
      ChatThreadDetail(threadId: threadId, messages: const []);

  @override
  void close() {}
}

class _Threads implements ChatThreadRepository {
  const _Threads();
  @override
  Future<List<ChatThread>> getThreads() async => [];
}

class _Credentials implements CredentialRepository {
  const _Credentials();
  @override
  Future<AuthSession?> read() async => null;
  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
  @override
  Future<void> clear() async {}
}

class _Speech implements SpeechToTextRepository {
  final transcriptController = StreamController<SpeechTranscript>.broadcast();
  bool permission = true;
  String latest = '';
  int starts = 0;
  int stops = 0;
  int cancels = 0;

  @override
  Stream<SpeechTranscript> get transcripts => transcriptController.stream;
  @override
  Stream<SpeechSessionStatus> get statuses => const Stream.empty();
  @override
  Stream<String> get errors => const Stream.empty();
  @override
  Future<bool> hasPermission() async => permission;
  @override
  Future<bool> initialize() async => true;
  @override
  Future<void> startListening() async {
    starts++;
  }

  @override
  Future<String> stopListening() async {
    stops++;
    return latest;
  }

  void addTranscript(String text) {
    latest = text;
    transcriptController.add(SpeechTranscript(text: text, isFinal: false));
  }

  Future<void> dispose() => transcriptController.close();

  @override
  Future<void> cancelListening() async {
    cancels++;
  }

  @override
  Future<void> close() async {}
}
