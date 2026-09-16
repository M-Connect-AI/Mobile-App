import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/model/chat_message.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:chatbot_project/presentation/pages/chat/bloc/chat_bloc.dart';
import 'package:chatbot_project/presentation/pages/chat/chat_page.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/resources/app_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sends text and shows streamed backend response', (tester) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();

    expect(find.text(AppConstants.chatbotName), findsOneWidget);
    expect(find.textContaining('Xin chào'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      'Xin chào AI',
    );
    await tester.pump();
    expect(find.byKey(const ValueKey('send-icon')), findsOneWidget);
    final inputBeforeSend = tester.widget<TextField>(
      find.byKey(const Key('chat-text-field')),
    );
    expect(inputBeforeSend.focusNode?.hasFocus, isTrue);

    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    expect(inputBeforeSend.focusNode?.hasFocus, isFalse);
    expect(find.text(S.current.thinking), findsWidgets);
    expect(find.byTooltip('Sao chép'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Tôi đã hiểu yêu cầu'), findsOneWidget);
    expect(find.byKey(const Key('copy-welcome')), findsOneWidget);
    expect(find.byTooltip('Sao chép'), findsNWidgets(2));
  });

  testWidgets('failed request offers retry and succeeds', (tester) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(find.byKey(const Key('chat-text-field')), '#fail');
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text(S.current.retry), findsOneWidget);
    await tester.tap(find.text(S.current.retry));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Tôi đã hiểu yêu cầu'), findsOneWidget);
  });

  testWidgets('shows backend status label while a turn is running', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(find.byKey(const Key('chat-text-field')), '#status');
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 30));

    expect(find.text('Đang tra cứu task Jira…'), findsWidgets);

    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Đang tra cứu task Jira…'), findsNothing);
  });

  testWidgets('renders backend confirmation and sends confirm flag', (
    tester,
  ) async {
    final repository = _FakeChatRepository();
    await tester.pumpWidget(_ChatTestApp(repository: repository));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Gửi đơn nghỉ phép'), findsOneWidget);
    expect(find.text('Xác nhận'), findsOneWidget);

    await tester.ensureVisible(find.text('Xác nhận'));
    await tester.pump();
    await tester.tap(find.text('Xác nhận'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(repository.requests.last.message, 'Xác nhận');
    expect(repository.requests.last.confirm, isTrue);
    expect(
      repository.requests.last.confirmedTool,
      ChatConfirmationTool.createLeave,
    );
    expect(repository.requests.last.threadId, 'thread-new');
    expect(
      find.text('Thao tác đã được backend thực thi thành công.'),
      findsOneWidget,
    );
  });

  testWidgets('renders read preview without a completed-action label', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#preview',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();

    expect(find.text('Phép năm: 9/12 ngày · Phép ốm: 30 ngày'), findsOneWidget);
    expect(find.text(S.current.chatActionCompleted), findsNothing);
  });

  testWidgets('notifies affected data only after a confirmed mutation', (
    tester,
  ) async {
    final coordinator = DataRefreshCoordinator();
    addTearDown(coordinator.close);
    final changes = <Set<DataRefreshScope>>[];
    final subscription = coordinator.changes.listen(changes.add);
    addTearDown(subscription.cancel);

    await tester.pumpWidget(_ChatTestApp(refreshCoordinator: coordinator));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#preview',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();
    expect(changes, isEmpty);

    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(S.current.confirmButton));
    await tester.tap(find.text(S.current.confirmButton));
    await tester.pumpAndSettle();

    expect(changes, [
      {DataRefreshScope.leaves, DataRefreshScope.home},
    ]);
  });

  testWidgets('dismisses keyboard when tapping outside the chat input', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();

    final inputFinder = find.byKey(const Key('chat-text-field'));
    await tester.tap(inputFinder);
    await tester.pump();
    final input = tester.widget<TextField>(inputFinder);
    expect(input.focusNode?.hasFocus, isTrue);

    await tester.tap(find.byKey(const Key('chat-list')));
    await tester.pump();

    expect(input.focusNode?.hasFocus, isFalse);
  });

  testWidgets('scrolls to the latest message after restoring a thread', (
    tester,
  ) async {
    final messages = List.generate(
      24,
      (index) => ChatMessage(
        id: 'restored-$index',
        type: MessageType.text,
        sender: index.isEven ? MessageSender.user : MessageSender.assistant,
        content: 'Nội dung lịch sử hội thoại số $index',
        createdAt: DateTime.utc(2026, 9, 6, 8, index),
        status: MessageStatus.success,
      ),
    );
    await tester.pumpWidget(
      _ChatTestApp(
        repository: _FakeChatRepository(detailMessages: messages),
        threadId: 'thread-long',
      ),
    );
    await tester.pumpAndSettle();

    final listView = tester.widget<ListView>(
      find.byKey(const Key('chat-list')),
    );
    final position = listView.controller!.position;
    expect(position.maxScrollExtent, greaterThan(0));
    expect(position.pixels, closeTo(position.maxScrollExtent, .1));
  });
}

class _ChatTestApp extends StatelessWidget {
  const _ChatTestApp({this.repository, this.threadId, this.refreshCoordinator});

  final _FakeChatRepository? repository;
  final String? threadId;
  final DataRefreshCoordinator? refreshCoordinator;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider(
          create: (_) => ChatBloc(
            repository ?? _FakeChatRepository(),
            FakeSpeechToTextRepository(),
            refreshCoordinator: refreshCoordinator,
          )..add(ChatStarted(threadId: threadId)),
          child: const ChatPage(),
        ),
      ),
    );
  }
}

class _FakeChatRepository implements ChatRepository {
  _FakeChatRepository({this.detailMessages = const []});

  final List<ChatMessage> detailMessages;
  final Set<String> _failedOnce = {};
  final List<
    ({
      String message,
      String? threadId,
      bool confirm,
      ChatConfirmationTool? confirmedTool,
    })
  >
  requests = [];

  @override
  Future<ChatThreadDetail> getThread(String threadId) async =>
      ChatThreadDetail(threadId: threadId, messages: detailMessages);

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
    bool confirm = false,
    ChatConfirmationTool? confirmedTool,
  }) async* {
    requests.add((
      message: message,
      threadId: threadId,
      confirm: confirm,
      confirmedTool: confirmedTool,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 20));
    if (message == '#fail' && _failedOnce.add(message)) {
      throw const ChatRepositoryException('Không thể gửi tin nhắn');
    }
    if (message == '#status') {
      yield const ChatStreamStatus('Đang tra cứu task Jira…');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      yield const ChatStreamToken('Đã tìm thấy task Jira.');
      yield const ChatStreamDone(threadId: 'thread-new', citations: []);
      return;
    }
    if (message == '#preview') {
      yield const ChatStreamResult(
        ChatResultEnvelope.leaveBalance(
          LeaveBalance(
            employeeCode: 'EMP001',
            annualRemaining: 9,
            annualTotal: 12,
            sickRemaining: 30,
          ),
        ),
      );
      yield const ChatStreamDone(threadId: 'thread-new', citations: []);
      return;
    }
    if (message == '#confirm') {
      yield const ChatStreamToken('Bạn có muốn xác nhận?');
      yield const ChatStreamConfirmation(
        ChatConfirmAction(
          tool: ChatConfirmationTool.createLeave,
          args: {'type': 'ANNUAL'},
          summary: 'Gửi đơn nghỉ phép',
        ),
      );
      yield const ChatStreamDone(threadId: 'thread-new', citations: []);
      return;
    }
    if (confirm) {
      yield ChatStreamResult(
        ChatResultEnvelope.leaveMutation(
          mutation: ChatMutationType.createLeave,
          data: LeaveRequest(
            id: 'leave-id',
            employeeCode: 'EMP001',
            type: LeaveType.annual,
            from: DateTime(2026, 9, 20),
            to: DateTime(2026, 9, 20),
            days: 1,
            reason: 'Nghỉ phép',
            status: RequestStatus.pending,
          ),
        ),
      );
      yield ChatStreamDone(
        threadId: threadId ?? 'thread-new',
        citations: const [],
      );
      return;
    }
    yield const ChatStreamToken(
      'Tôi đã hiểu yêu cầu của bạn. Đây là phản hồi từ AI.',
    );
    yield ChatStreamDone(
      threadId: threadId ?? 'thread-new',
      citations: const [],
    );
  }

  @override
  void close() {}
}

class FakeSpeechToTextRepository implements SpeechToTextRepository {
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
  Future<bool> hasPermission() async => false;

  @override
  Future<bool> initialize() async => true;

  @override
  Future<void> startListening() async {}

  @override
  Future<String> stopListening() async => '';
}
