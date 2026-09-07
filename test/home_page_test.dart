import 'package:chatbot_project/common/theme/app_theme.dart';
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
import 'package:chatbot_project/resources/app_constants.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('AI button opens dashboard, then input opens chat screen', (
    tester,
  ) async {
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
                create: (_) => _FakeSpeechRepository(),
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

    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
    expect(find.text('9/12'), findsOneWidget);
    expect(find.text('Hà Nội'), findsOneWidget);
    expect(find.byKey(const Key('assistant-bubble')), findsOneWidget);
    expect(find.byKey(const Key('logout-button')), findsOneWidget);
    expect(find.byKey(const Key('server-config-button')), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.square_arrow_right), findsOneWidget);
    expect(find.text('Đăng xuất'), findsNothing);

    await tester.tap(find.byKey(const Key('assistant-bubble')));
    await tester.pumpAndSettle();

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

    await tester.tap(find.byKey(const Key('close-assistant')));
    await tester.pumpAndSettle();

    final homeBackButton = find.byKey(const Key('home-chat-back-button'));
    await tester.ensureVisible(homeBackButton);
    await tester.pumpAndSettle();
    await tester.tap(homeBackButton);
    await tester.pumpAndSettle();

    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
    expect(find.byKey(const Key('assistant-bubble')), findsOneWidget);
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
  const _FakeHomeRepository();

  @override
  Future<HomeData> getHomeData() async => _homeData;
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
  Future<bool> initialize() async => true;

  @override
  Future<void> startListening() async {}

  @override
  Future<String> stopListening() async => '';
}
