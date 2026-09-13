import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/home/home_page.dart';
import 'package:chatbot_project/resources/app_constants.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'assistant launcher opens AI screen, then input opens chat screen',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final speechRepository = _FakeSpeechRepository();
      final router = GoRouter(
        initialLocation: const HomeRoute().location,
        routes: appRoutes,
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        RepositoryProvider<ChatThreadRepository>(
          create: (_) => const _FakeChatThreadRepository(),
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HomeRepository>(
                create: (_) => const _FakeHomeRepository(),
              ),
              RepositoryProvider<CredentialRepository>(
                create: (_) => _FakeCredentialRepository(),
              ),
            ],
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider<ChatRepository>(
                  create: (_) => _FakeChatRepository(),
                ),
                RepositoryProvider<SpeechToTextRepository>(
                  create: (_) => speechRepository,
                ),
              ],
              child: ScreenUtilInit(
                designSize: const Size(390, 844),
                minTextAdapt: true,
                splitScreenMode: true,
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
          ),
        ),
      );
      await tester.pump();

      expect(find.text(S.current.homeGreetingName('Minh')), findsOneWidget);
      expect(find.byKey(const Key('task-summary-list')), findsOneWidget);
      expect(find.byKey(const Key('leave-summary-card')), findsOneWidget);
      expect(find.byKey(const Key('supplement-summary-card')), findsOneWidget);
      expect(find.text(S.current.homeNeedsAttention), findsNothing);
      expect(find.text(S.current.homeWaitingApproval), findsWidgets);
      expect(
        tester.getSize(find.byKey(const Key('task-summary-list'))),
        const Size(390, 120),
      );
      expect(
        tester.getSize(find.byKey(const Key('leave-summary-card'))),
        const Size(260, 120),
      );
      expect(
        tester.getTopLeft(find.byKey(const Key('leave-summary-card'))).dx,
        16,
      );

      await tester.drag(
        find.byKey(const Key('task-summary-list')),
        const Offset(-720, 0),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('edocman-summary-card')), findsOneWidget);
      expect(find.byKey(const Key('eis-summary-card')), findsOneWidget);
      expect(find.byKey(const Key('home-banner-placeholder')), findsOneWidget);
      expect(find.text('TIỆN ÍCH'), findsOneWidget);
      expect(find.byKey(const Key('assistant-bubble')), findsOneWidget);
      expect(
        tester.widget<Scaffold>(find.byType(Scaffold).first).extendBody,
        isFalse,
      );
      expect(
        tester
            .widget<BottomAppBar>(find.byKey(const Key('home-bottom-bar')))
            .color,
        AppColorScheme.light.surfaceSecondary,
      );
      expect(
        tester
            .widget<Text>(find.text(S.current.navigationAssistant))
            .style
            ?.color,
        AppColorScheme.light.textBrand,
      );
      expect(
        tester.widget<Text>(find.text(S.current.navigationHome)).style?.color,
        AppColorScheme.light.iconPrimary,
      );
      expect(
        tester.widget<Text>(find.text(S.current.navigationHris)).style?.color,
        AppColorScheme.light.textSecondary,
      );
      expect(
        tester
            .widget<Text>(find.text(S.current.navigationHris))
            .style
            ?.fontWeight,
        FontWeight.w500,
      );
      expect(
        tester.getSize(find.byKey(const Key('home-bottom-bar'))).height,
        64,
      );
      expect(
        tester.getSize(find.byKey(const Key('assistant-bubble'))).width,
        56,
      );
      expect(
        tester.getTopLeft(find.byKey(const Key('home-bottom-bar'))).dy -
            tester.getTopLeft(find.byKey(const Key('assistant-bubble'))).dy,
        closeTo(16, 2),
      );
      expect(
        tester.getTopLeft(find.text(S.current.navigationAssistant)).dy -
            tester.getBottomLeft(find.byKey(const Key('assistant-bubble'))).dy,
        closeTo(4, 2),
      );
      expect(find.byKey(const Key('logout-button')), findsNothing);
      expect(find.byKey(const Key('server-config-button')), findsNothing);
      expect(find.text('Đăng xuất'), findsNothing);

      await tester.tap(find.byKey(const Key('utilities-navigation-item')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('utilities-content')), findsOneWidget);
      expect(find.byKey(const Key('utilities-profile-card')), findsOneWidget);
      expect(find.text('minh@msb.vn'), findsOneWidget);
      expect(find.text('EMP001'), findsOneWidget);
      expect(find.text('Khối bán lẻ'), findsOneWidget);
      expect(find.text(S.current.profileStaffRole), findsOneWidget);
      expect(find.text(S.current.profileAnnualDays(9, 12)), findsOneWidget);
      expect(find.text(S.current.profileSickDays(30)), findsOneWidget);
      await tester.drag(
        find.byKey(const Key('utilities-content')),
        const Offset(0, -400),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('logout-button')), findsOneWidget);
      expect(find.byKey(const Key('server-config-button')), findsOneWidget);
      expect(find.text('Đăng xuất'), findsOneWidget);
      expect(find.byKey(const Key('task-summary-list')), findsNothing);

      await tester.tap(find.byKey(const Key('home-navigation-item')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('home-content')), findsOneWidget);
      expect(find.byKey(const Key('logout-button')), findsNothing);
      expect(find.byKey(const Key('server-config-button')), findsNothing);

      await tester.tap(find.byKey(const Key('assistant-bubble')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('home-bottom-bar')), findsNothing);
      expect(find.byKey(const Key('home-chat-back-button')), findsOneWidget);
      expect(find.text('Tối ưu thao tác,\ntự động quy trình.'), findsOneWidget);
      expect(find.text(S.current.leaveRequestSuggestion), findsOneWidget);
      expect(find.text('Xem đơn nghỉ phép của tôi'), findsOneWidget);
      expect(find.text('Tôi còn bao nhiêu ngày phép?'), findsOneWidget);
      expect(find.text('Lịch sử'), findsOneWidget);
      expect(
        find.textContaining('Tôi muốn xin nghỉ phép từ ngày 10/09'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('home-chat-input')), findsOneWidget);
      expect(find.text('Try premium'), findsNothing);

      final seeAllButton = find.byKey(const Key('chat-history-see-all'));
      await tester.ensureVisible(seeAllButton);
      await tester.pumpAndSettle();
      await tester.tap(seeAllButton);
      await tester.pumpAndSettle();

      expect(find.text('Lịch sử trò chuyện'), findsOneWidget);
      expect(find.text('Đơn nghỉ phép năm'), findsOneWidget);
      expect(find.text('Chính sách nghỉ phép'), findsOneWidget);

      await tester.tap(find.byKey(const Key('chat-history-back-button')));
      await tester.pumpAndSettle();

      expect(find.text('Tối ưu thao tác,\ntự động quy trình.'), findsOneWidget);

      final suggestion = find.byKey(const Key('leave-request-suggestion'));
      await tester.ensureVisible(suggestion);
      await tester.pumpAndSettle();
      await tester.tap(suggestion);
      await tester.pumpAndSettle();

      expect(find.text(AppConstants.chatbotName), findsOneWidget);
      expect(find.byKey(const Key('close-assistant')), findsOneWidget);
      final chatTextField = tester.widget<TextField>(
        find.byKey(const Key('chat-text-field')),
      );
      expect(chatTextField.controller?.text, isEmpty);
      expect(find.text(S.current.leaveRequestSuggestion), findsOneWidget);

      await tester.tap(find.byKey(const Key('close-assistant')));
      await tester.pumpAndSettle();

      expect(find.text('Tối ưu thao tác,\ntự động quy trình.'), findsOneWidget);

      await tester.tap(find.byKey(const Key('home-chat-input')));
      await tester.pumpAndSettle();

      expect(find.text(AppConstants.chatbotName), findsOneWidget);
      final focusedChatInput = tester.widget<TextField>(
        find.byKey(const Key('chat-text-field')),
      );
      expect(focusedChatInput.focusNode?.hasFocus, isTrue);

      await tester.tap(find.byKey(const Key('chat-action-button')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('microphone-permission-dialog')),
        findsOneWidget,
      );
      await tester.tap(find.text(S.current.cancelButton).last);
      await tester.pumpAndSettle();
      expect(speechRepository.initializeCallCount, 0);

      await tester.tap(find.byKey(const Key('close-assistant')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
      await tester.pump();
      expect(
        find.byKey(const Key('microphone-permission-dialog')),
        findsOneWidget,
      );
      expect(speechRepository.initializeCallCount, 0);

      await tester.tap(find.text(S.current.cancelButton).last);
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('microphone-permission-dialog')),
        findsNothing,
      );
      expect(speechRepository.initializeCallCount, 0);

      await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.microphonePermissionContinue));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text(AppConstants.chatbotName), findsOneWidget);
      expect(speechRepository.initializeCallCount, 1);

      await tester.tap(find.byKey(const Key('close-assistant')));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      speechRepository.permissionGranted = true;
      await tester.tap(find.byKey(const Key('chat-launcher-microphone')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('microphone-permission-dialog')),
        findsNothing,
      );
      expect(speechRepository.initializeCallCount, 2);

      await tester.tap(find.byKey(const Key('close-assistant')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('home-chat-back-button')));
      await tester.pumpAndSettle();

      expect(find.text(S.current.homeGreetingName('Minh')), findsOneWidget);
      expect(find.byKey(const Key('assistant-bubble')), findsOneWidget);

      await tester.tap(find.text(S.current.navigationAssistant));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('home-chat-back-button')), findsOneWidget);
    },
  );

  testWidgets('manager sees both task statuses', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<HomeRepository>(
            create: (_) => const _FakeHomeRepository(role: UserRole.manager),
          ),
          RepositoryProvider<CredentialRepository>(
            create: (_) => _FakeCredentialRepository(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            theme: AppTheme.dark,
            locale: const Locale('vi'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const HomePage(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text(S.current.homeNeedsAttention), findsWidgets);
    expect(find.text(S.current.homeWaitingApproval), findsWidgets);
    expect(
      tester
          .widget<BottomAppBar>(find.byKey(const Key('home-bottom-bar')))
          .color,
      AppColorScheme.dark.surfaceSecondary,
    );

    await tester.tap(find.byKey(const Key('utilities-navigation-item')));
    await tester.pumpAndSettle();
    expect(find.text(S.current.profileManagerRole), findsOneWidget);
  });
}

class _FakeChatThreadRepository implements ChatThreadRepository {
  const _FakeChatThreadRepository();

  @override
  Future<List<ChatThread>> getThreads() async => [
    ChatThread(
      threadId: 'thread-annual-leave-001',
      title: 'Đơn nghỉ phép năm',
      preview: 'Tôi muốn xin nghỉ phép từ ngày 10/09 đến ngày 12/09.',
      updatedAt: DateTime(2026, 9, 6),
    ),
    ChatThread(
      threadId: 'thread-leave-policy-004',
      title: 'Chính sách nghỉ phép',
      preview: 'Tóm tắt quy định về phép năm.',
      updatedAt: DateTime(2026, 9, 1),
    ),
  ];
}

class _FakeChatRepository implements ChatRepository {
  @override
  Future<ChatThreadDetail> getThread(String threadId) async =>
      ChatThreadDetail(threadId: threadId, messages: const []);

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
    bool confirm = false,
  }) async* {
    yield const ChatStreamToken('Đã xử lý');
    yield ChatStreamDone(
      threadId: threadId ?? 'thread-new',
      citations: const [],
    );
  }

  @override
  void close() {}
}

class _FakeHomeRepository implements HomeRepository {
  const _FakeHomeRepository({this.role = UserRole.staff});

  final UserRole role;

  @override
  Future<HomeData> getHomeData() async =>
      _homeData.copyWith(user: _homeData.user.copyWith(role: role));
}

class _FakeCredentialRepository implements CredentialRepository {
  @override
  Future<void> clear() async {}

  @override
  Future<AuthSession?> read() async => null;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
}

final _homeData = HomeData(
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'minh@msb.vn',
    fullName: 'Minh',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
  leaveBalance: LeaveBalance(
    employeeCode: 'EMP001',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
  upcomingTrips: [
    BusinessTrip(
      id: 'trip-id',
      employeeCode: 'EMP001',
      destination: 'Hà Nội',
      from: DateTime(2026, 9, 8),
      to: DateTime(2026, 9, 10),
      purpose: 'Gặp đối tác',
      status: RequestStatus.pending,
    ),
  ],
);

class _FakeSpeechRepository implements SpeechToTextRepository {
  int initializeCallCount = 0;
  bool permissionGranted = false;

  @override
  Stream<String> get errors => const Stream.empty();

  @override
  Stream<SpeechSessionStatus> get statuses => const Stream.empty();

  @override
  Stream<SpeechTranscript> get transcripts => const Stream.empty();

  @override
  Future<void> cancelListening() async {}

  @override
  Future<void> close() async {}

  @override
  Future<bool> hasPermission() async => permissionGranted;

  @override
  Future<bool> initialize() async {
    initializeCallCount += 1;
    return false;
  }

  @override
  Future<void> startListening() async {}

  @override
  Future<String> stopListening() async => '';
}
