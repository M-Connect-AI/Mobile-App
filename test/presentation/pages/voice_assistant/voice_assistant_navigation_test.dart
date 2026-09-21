import 'dart:async';

import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/model/chat_message.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/domain/repository/text_to_speech_repository.dart';
import 'package:chatbot_project/domain/repository/voice_assistant_chat_repository.dart';
import 'package:chatbot_project/data/repository/chat_repository_voice_assistant_chat_repository.dart';
import 'package:chatbot_project/data/repository/unavailable_text_to_speech_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  for (final size in [const Size(390, 844), const Size(320, 640)]) {
    testWidgets('Home AI microphone opens Voice Assistant at ${size.width}', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final speech = _Speech();
      await _pumpApp(tester, speech);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(const Key('voice-microphone')), findsOneWidget);
      expect(find.byKey(const Key('voice-reset')), findsOneWidget);
      expect(find.byKey(const Key('voice-send')), findsOneWidget);
      expect(find.byKey(const Key('voice-back')), findsOneWidget);
      expect(find.byKey(const Key('voice-close')), findsNothing);
      final microphone = tester.getRect(
        find.byKey(const Key('voice-microphone')),
      );
      final reset = tester.getRect(find.byKey(const Key('voice-reset')));
      final send = tester.getRect(find.byKey(const Key('voice-send')));
      final sideOffset = 116 * size.width / 390;
      expect(microphone.center.dx - reset.center.dx, closeTo(sideOffset, 2));
      expect(send.center.dx - microphone.center.dx, closeTo(sideOffset, 2));
      expect(find.text(S.current.voiceAssistantListening), findsOneWidget);
      expect(find.text(S.current.voiceAssistantReviewBeforeSend), findsNothing);
      expect(speech.starts, 1);
      expect(tester.takeException(), isNull);

      Color microphoneColor() =>
          (tester
                      .widgetList<Container>(
                        find.descendant(
                          of: find.byKey(const Key('voice-microphone')),
                          matching: find.byType(Container),
                        ),
                      )
                      .firstWhere(
                        (container) =>
                            container.decoration is BoxDecoration &&
                            (container.decoration! as BoxDecoration).shape ==
                                BoxShape.circle,
                      )
                      .decoration!
                  as BoxDecoration)
              .color!;
      expect(microphoneColor(), AppColorScheme.light.textError);

      await tester.tap(find.byKey(const Key('voice-microphone')));
      await tester.pump();
      expect(microphoneColor(), AppColorScheme.light.surfaceTemary);
      expect(find.text(S.current.voiceAssistantReviewBeforeSend), findsNothing);

      await tester.tap(find.byKey(const Key('voice-back')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('home-chat-input')), findsOneWidget);
      expect(speech.stops, 1);
    });
  }

  testWidgets('permission screen offers typing without microphone access', (
    tester,
  ) async {
    final speech = _Speech()..permission = false;
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text(S.current.voiceAssistantPermissionTitle), findsOneWidget);
    expect(find.byKey(const Key('voice-allow-microphone')), findsOneWidget);
    expect(find.byKey(const Key('voice-microphone')), findsNothing);
    expect(speech.starts, 0);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('voice-allow-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(S.current.voiceAssistantPermissionDenied), findsOneWidget);
    expect(find.text(S.current.voiceAssistantOpenSettings), findsOneWidget);
    expect(speech.starts, 0);

    await tester.tap(find.byKey(const Key('voice-keyboard-switch')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('chat-text-field')), findsOneWidget);
    expect(chat.sends, 0);
  });

  testWidgets('switching to typing keeps the speech transcript as draft', (
    tester,
  ) async {
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    speech.addTranscript('Đơn nghỉ phép của tôi');
    await tester.pump();

    await tester.tap(find.byKey(const Key('voice-keyboard-switch')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('chat-text-field')))
          .controller!
          .text,
      'Đơn nghỉ phép của tôi',
    );
    expect(speech.stops, 1);
    expect(chat.sends, 0);
  });

  testWidgets('system permission prompt does not cancel microphone setup', (
    tester,
  ) async {
    final speech = _Speech()
      ..permission = false
      ..pendingInitialize = Completer<bool>();
    await _pumpApp(tester, speech);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byKey(const Key('voice-allow-microphone')));
    await tester.pump();

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    speech.permission = true;
    speech.pendingInitialize!.complete(true);
    await tester.pump();
    await tester.pump();

    expect(find.text(S.current.voiceAssistantListening), findsOneWidget);
    expect(speech.starts, 1);
  });

  testWidgets('sending uses the chat API once and opens its thread', (
    tester,
  ) async {
    final speech = _Speech();
    final chat = _NoNetworkChatRepository();
    await _pumpApp(tester, speech, chatRepository: chat);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    speech.addTranscript('Xem đơn nghỉ phép');
    await tester.pump();

    await tester.tap(find.byKey(const Key('voice-send')));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('chat-list')), findsOneWidget);
    expect(find.text('Xem đơn nghỉ phép'), findsOneWidget);
    expect(find.text('Kết quả thật'), findsOneWidget);
    expect(speech.stops, 1);
    expect(chat.sends, 1);
    expect(chat.loadedThreads, 1);
  });

  testWidgets('paused transcript shows review guidance', (tester) async {
    final speech = _Speech();
    await _pumpApp(tester, speech);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    speech.addTranscript('Kiểm tra lời nói');
    await tester.pump();
    await tester.tap(find.byKey(const Key('voice-microphone')));
    await tester.pump();

    expect(find.text(S.current.voiceAssistantPaused), findsOneWidget);
    expect(find.text(S.current.voiceAssistantReviewBeforeSend), findsOneWidget);
  });

  testWidgets('chat API failure keeps transcript and shows a friendly status', (
    tester,
  ) async {
    final speech = _Speech();
    final chat = _NoNetworkChatRepository()..failSend = true;
    await _pumpApp(tester, speech, chatRepository: chat);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    speech.addTranscript('Giữ nội dung này');
    await tester.pump();
    await tester.tap(find.byKey(const Key('voice-send')));
    await tester.pumpAndSettle();

    expect(find.text(S.current.voiceAssistantChatError), findsOneWidget);
    expect(find.text('Giữ nội dung này'), findsOneWidget);
    expect(find.byKey(const Key('chat-list')), findsNothing);
    expect(chat.sends, 1);
  });

  testWidgets('long transcript keeps controls visible on a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue,
    );
    final speech = _Speech();
    await _pumpApp(tester, speech);
    await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    speech.addTranscript(List.filled(80, 'Nội dung cần kiểm tra').join(' '));
    await tester.pump();

    expect(find.byKey(const Key('voice-microphone')), findsOneWidget);
    expect(find.byKey(const Key('voice-keyboard-switch')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpApp(
  WidgetTester tester,
  _Speech speech, {
  _NoNetworkChatRepository? chatRepository,
}) async {
  final chat = chatRepository ?? _NoNetworkChatRepository();
  final router = GoRouter(
    initialLocation: HomeChatAiRoute.path,
    routes: appRoutes,
  );
  addTearDown(router.dispose);
  addTearDown(speech.dispose);
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatThreadRepository>.value(value: const _Threads()),
        RepositoryProvider<ChatRepository>.value(value: chat),
        RepositoryProvider<CredentialRepository>.value(
          value: const _Credentials(),
        ),
        RepositoryProvider<VoiceAssistantChatRepository>.value(
          value: ChatRepositoryVoiceAssistantChatRepository(chat),
        ),
        RepositoryProvider<SpeechToTextRepository>.value(value: speech),
        RepositoryProvider<TextToSpeechRepository>.value(
          value: const UnavailableTextToSpeechRepository(),
        ),
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
  int loadedThreads = 0;
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
  Future<ChatThreadDetail> getThread(String threadId) async {
    loadedThreads++;
    return ChatThreadDetail(
      threadId: threadId,
      messages: [
        ChatMessage(
          id: 'user-real',
          type: MessageType.text,
          sender: MessageSender.user,
          content: lastMessage,
          createdAt: DateTime(2026, 9, 21),
          status: MessageStatus.sent,
        ),
        ChatMessage(
          id: 'answer-real',
          type: MessageType.text,
          sender: MessageSender.assistant,
          content: 'Kết quả thật',
          createdAt: DateTime(2026, 9, 21),
          status: MessageStatus.success,
        ),
      ],
    );
  }

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
  Completer<bool>? pendingInitialize;
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
  Future<bool> initialize() async => await pendingInitialize?.future ?? true;
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
