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
import 'package:chatbot_project/presentation/pages/chat/widgets/chat_bubble.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sends text and shows streamed backend response', (tester) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();

    expect(find.text(S.current.newConversationTitle), findsOneWidget);
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
    expect(find.byTooltip('Sao chép'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Tôi đã hiểu yêu cầu'), findsOneWidget);
    expect(find.byKey(const Key('copy-welcome')), findsNothing);
    expect(find.byTooltip('Sao chép'), findsNothing);
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
    await tester.pumpAndSettle();

    expect(find.text('Gửi đơn nghỉ phép'), findsNothing);
    expect(find.text(S.current.reviewRequestTitle), findsOneWidget);
    expect(find.text(S.current.leaveAnnualType), findsOneWidget);
    expect(find.text('17/09/2026'), findsOneWidget);
    expect(find.text('1 ngày'), findsOneWidget);
    expect(find.text('Đi concert'), findsOneWidget);
    expect(find.text(S.current.confirmSubmitButton), findsOneWidget);

    final confirmButton = find.byKey(const Key('confirm-action'));
    await tester.ensureVisible(confirmButton);
    await tester.pump();
    await tester.tap(confirmButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(repository.requests.last.message, 'Xác nhận');
    expect(repository.requests.last.confirm, isTrue);
    expect(
      repository.requests.last.confirmedTool,
      ChatConfirmationTool.createLeave,
    );
    expect(repository.requests.last.threadId, 'thread-new');
    expect(find.text(S.current.createLeaveSuccess), findsOneWidget);
    expect(find.textContaining('leave-id'), findsOneWidget);
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

  testWidgets('keeps a failed confirmation on the same card and retries', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repository = _FakeChatRepository(failConfirmationOnce: true);
    await tester.pumpWidget(_ChatTestApp(repository: repository));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump(const Duration(seconds: 1));

    final card = find.byWidgetPredicate(
      (widget) =>
          widget.key?.toString().contains('confirmation-card-assistant-') ==
          true,
    );
    expect(card, findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('confirm-action')));
    await tester.tap(find.byKey(const Key('confirm-action')));
    await tester.pump();
    expect(find.text(S.current.submittingRequest), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Không thể gửi đơn'), findsWidgets);
    expect(find.byKey(const Key('retry-confirmation')), findsOneWidget);

    await tester.tap(find.byKey(const Key('retry-confirmation')));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text(S.current.createLeaveSuccess), findsOneWidget);
    expect(card, findsOneWidget);
  });

  testWidgets('prefills the composer when editing a confirmation card', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(const Key('edit-action')));
    await tester.pump();

    final input = tester.widget<TextField>(
      find.byKey(const Key('chat-text-field')),
    );
    expect(input.controller?.text, S.current.editConfirmationPrompt);
    expect(find.byKey(const Key('confirm-action')), findsOneWidget);
  });

  testWidgets('notifies chat history and affected mutation data', (
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
    expect(changes, [
      {DataRefreshScope.chatHistory},
    ]);
    changes.clear();

    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();
    final confirmButton = find.byKey(const Key('confirm-action'));
    await tester.ensureVisible(confirmButton);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    expect(changes.where((scopes) => scopes.contains(DataRefreshScope.home)), [
      {DataRefreshScope.leaves, DataRefreshScope.home},
    ]);
    expect(
      changes
          .where((scopes) => scopes.contains(DataRefreshScope.chatHistory))
          .length,
      2,
    );
  });

  testWidgets('renders Jira issue details, stats and truncated state', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          result: ChatResultEnvelope.jiraIssues(
            JiraIssueList(
              issues: List.filled(50, _jiraIssue),
              stats: const JiraStats(
                total: 50,
                toDo: 50,
                inProgress: 0,
                done: 0,
                unknown: 0,
                overdue: 0,
                stale: 0,
                withoutDueDate: 0,
                byStatus: {'To Do': 50},
                byPriority: {'High': 50},
                byIssueType: {'Task': 50},
                byProject: {'SCRUM': 50},
              ),
              mayBeTruncated: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('SCRUM-1'), findsNWidgets(5));
    expect(find.text('Hoàn thiện SSE'), findsNWidgets(5));
    expect(find.text('To Do · High'), findsNWidgets(5));
    expect(find.text('Hạn: 2026-09-30'), findsNWidgets(5));
    expect(find.text('Và 45 task khác'), findsOneWidget);
    expect(
      find.text('Kết quả có thể đã được giới hạn ở 50 task.'),
      findsOneWidget,
    );
  });

  testWidgets('renders Jira empty and capability-unavailable states', (
    tester,
  ) async {
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          result: const ChatResultEnvelope.jiraIssues(
            JiraIssueList(
              issues: [],
              stats: JiraStats(
                total: 0,
                toDo: 0,
                inProgress: 0,
                done: 0,
                unknown: 0,
                overdue: 0,
                stale: 0,
                withoutDueDate: 0,
                byStatus: {},
                byPriority: {},
                byIssueType: {},
                byProject: {},
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Không có Jira task nào khớp yêu cầu.'), findsOneWidget);

    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#capability',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();
    expect(
      find.text('Jira MCP chưa được cấu hình credential trên máy chủ.'),
      findsWidgets,
    );
  });

  testWidgets('opens only validated HTTP citations externally', (tester) async {
    final opened = <Uri>[];
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          citations: const [
            'https://jira.example/browse/SCRUM-1',
            'Quy định nghỉ phép (hr-policy.pdf)',
            'javascript:alert(1)',
          ],
        ),
        openExternalUrl: (uri) async {
          opened.add(uri);
          return true;
        },
      ),
    );

    expect(find.byKey(const Key('citation-link-0')), findsOneWidget);
    expect(find.byKey(const Key('policy-citation-1')), findsOneWidget);
    expect(find.byKey(const Key('policy-citation-2')), findsOneWidget);
    await tester.tap(find.byKey(const Key('citation-link-0')));
    await tester.pump();
    expect(opened.single.toString(), 'https://jira.example/browse/SCRUM-1');
  });

  testWidgets('renders created Jira result with validated task link', (
    tester,
  ) async {
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          result: const ChatResultEnvelope.jiraMutation(
            mutation: ChatMutationType.createJiraTask,
            data: JiraCreateResult(
              key: 'SCRUM-2',
              summary: 'Tạo card Jira',
              projectKey: 'SCRUM',
              issueType: 'Task',
              assigneeEmail: 'a@msb.vn',
              url: 'https://jira.example/browse/SCRUM-2',
              message: 'Đã tạo Jira SCRUM-2',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Đã tạo SCRUM-2'), findsOneWidget);
    expect(find.text(S.current.createJiraTaskSuccess), findsOneWidget);
    expect(find.text('Tạo card Jira'), findsOneWidget);
    expect(find.text('Task · Gán cho a@msb.vn'), findsOneWidget);
    expect(find.byKey(const Key('jira-created-SCRUM-2')), findsOneWidget);
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

  testWidgets('shows back, title and overflow actions in the app bar', (
    tester,
  ) async {
    const longTitle =
        'Cuộc trò chuyện có tiêu đề rất dài cần được rút gọn trên một dòng';
    await tester.pumpWidget(const _ChatTestApp(title: longTitle));
    await tester.pump();

    expect(find.byKey(const Key('assistant-logo')), findsNothing);
    expect(find.byKey(const Key('assistant-subtitle')), findsNothing);
    expect(find.byKey(const Key('chat-back-button')), findsOneWidget);
    expect(find.byKey(const Key('chat-more-button')), findsOneWidget);
    final title = tester.widget<Text>(find.text(longTitle));
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
  });

  testWidgets('moves request cancellation into the app bar menu', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp());
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('cancel-action')), findsNothing);
    await tester.tap(find.byKey(const Key('chat-more-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('cancel-request-action')), findsOneWidget);
    expect(find.text(S.current.cancelRequest), findsOneWidget);

    await tester.tap(find.byKey(const Key('cancel-request-action')));
    await tester.pumpAndSettle();

    expect(find.text(S.current.requestCancelled), findsOneWidget);
    expect(find.byKey(const Key('cancel-request-action')), findsNothing);
  });

  testWidgets('scrolls to the latest message when the keyboard opens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    final messages = List.generate(
      24,
      (index) => ChatMessage(
        id: 'keyboard-$index',
        type: MessageType.text,
        sender: index.isEven ? MessageSender.user : MessageSender.assistant,
        content: 'Nội dung hội thoại số $index',
        createdAt: DateTime.utc(2026, 9, 16, 8, index),
        status: MessageStatus.success,
      ),
    );
    await tester.pumpWidget(
      _ChatTestApp(
        repository: _FakeChatRepository(detailMessages: messages),
        threadId: 'thread-keyboard',
      ),
    );
    await tester.pumpAndSettle();

    final listView = tester.widget<ListView>(
      find.byKey(const Key('chat-list')),
    );
    final position = listView.controller!.position;
    final maxBeforeKeyboard = position.maxScrollExtent;

    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(position.maxScrollExtent, greaterThan(maxBeforeKeyboard));
    expect(position.pixels, closeTo(position.maxScrollExtent, .1));
  });

  testWidgets('shows the supplied thread title in the floating header', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp(title: 'Chính sách nghỉ phép'));
    await tester.pump();

    expect(find.text('Chính sách nghỉ phép'), findsOneWidget);
    expect(find.text(S.current.newConversationTitle), findsNothing);
  });

  testWidgets('uses a localized fallback for an empty thread title', (
    tester,
  ) async {
    await tester.pumpWidget(const _ChatTestApp(title: '   '));
    await tester.pump();

    expect(find.text(S.current.newConversationTitle), findsOneWidget);
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
    expect(find.byKey(const Key('assistant-subtitle')), findsNothing);
  });
}

class _ChatTestApp extends StatelessWidget {
  const _ChatTestApp({
    this.repository,
    this.threadId,
    this.title,
    this.refreshCoordinator,
  });

  final _FakeChatRepository? repository;
  final String? threadId;
  final String? title;
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
          child: ChatPage(title: title),
        ),
      ),
    );
  }
}

class _BubbleTestApp extends StatelessWidget {
  const _BubbleTestApp({required this.message, this.openExternalUrl});

  final ChatMessage message;
  final ExternalUrlOpener? openExternalUrl;

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
        home: Scaffold(
          body: ChatBubble(
            message: message,
            openExternalUrl: openExternalUrl ?? (_) async => true,
          ),
        ),
      ),
    );
  }
}

class _FakeChatRepository implements ChatRepository {
  _FakeChatRepository({
    this.detailMessages = const [],
    this.failConfirmationOnce = false,
  });

  final List<ChatMessage> detailMessages;
  final bool failConfirmationOnce;
  final Set<String> _failedOnce = {};
  bool _confirmationFailed = false;
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
    if (message == '#capability') {
      yield const ChatStreamFailure(
        'Jira MCP chưa được cấu hình credential trên máy chủ.',
      );
      return;
    }
    if (message == '#confirm') {
      yield const ChatStreamToken('Bạn có muốn xác nhận?');
      yield const ChatStreamConfirmation(
        ChatConfirmAction(
          tool: ChatConfirmationTool.createLeave,
          args: {
            'type': 'ANNUAL',
            'from': '2026-09-17',
            'to': '2026-09-17',
            'reason': 'Đi concert',
          },
          summary: 'Gửi đơn nghỉ phép',
        ),
      );
      yield const ChatStreamDone(threadId: 'thread-new', citations: []);
      return;
    }
    if (confirm) {
      if (failConfirmationOnce && !_confirmationFailed) {
        _confirmationFailed = true;
        yield const ChatStreamFailure('Không thể gửi đơn');
        return;
      }
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

ChatMessage _assistantMessage({
  ChatResultEnvelope? result,
  List<String> citations = const [],
}) => ChatMessage(
  id: 'assistant-test',
  type: MessageType.text,
  sender: MessageSender.assistant,
  content: 'Kết quả Jira',
  createdAt: DateTime(2026, 9, 16),
  status: MessageStatus.success,
  citations: citations,
  executedResult: result,
);

const _jiraIssue = JiraIssue(
  key: 'SCRUM-1',
  summary: 'Hoàn thiện SSE',
  status: 'To Do',
  statusCategory: 'TO_DO',
  priority: 'High',
  issueType: 'Task',
  projectKey: 'SCRUM',
  assignee: 'a@msb.vn',
  dueDate: '2026-09-30',
  url: 'https://jira.example/browse/SCRUM-1',
);

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
