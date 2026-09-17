import 'package:chatbot_project/common/components/irh_button.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/chat_rich_content.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/model/chat_message.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
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

  testWidgets('reconciles done reply and sends exact suggestion text', (
    tester,
  ) async {
    final repository = _FakeChatRepository();
    await tester.pumpWidget(_ChatTestApp(repository: repository));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('chat-text-field')), '#rich');
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();

    expect(find.text('Phản hồi đầy đủ từ máy chủ'), findsOneWidget);
    expect(find.text('Phản hồi dở'), findsNothing);
    expect(find.byKey(const Key('rich-block-kpis')), findsOneWidget);

    await tester.tap(find.byKey(const Key('chat-suggestion-0')));
    await tester.pump();
    expect(find.byKey(const Key('chat-suggestion-0')), findsNothing);
    await tester.pumpAndSettle();
    expect(repository.requests.last.message, 'Liệt kê đơn nghỉ của tôi');
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
    expect(
      find.text(S.current.leaveBalanceProjectedTitle('6')),
      findsOneWidget,
    );
    expect(find.textContaining(S.current.leaveAnnualType), findsOneWidget);
    expect(find.text('8 ngày'), findsOneWidget);
    expect(find.text('2 ngày'), findsOneWidget);
    expect(find.text('6 ngày'), findsOneWidget);
    expect(find.text(S.current.leaveBalanceContinue), findsOneWidget);

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

  testWidgets('supports half-day leave and blocks an insufficient balance', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final message = ChatMessage(
      id: 'leave-balance',
      type: MessageType.text,
      sender: MessageSender.assistant,
      createdAt: DateTime(2026, 9, 17),
      status: MessageStatus.success,
      confirmation: const ChatConfirmAction(
        tool: ChatConfirmationTool.createLeave,
        args: {
          'type': 'ANNUAL',
          'from': '2026-09-20',
          'to': '2026-09-20',
          'reason': 'Việc cá nhân',
          'requestedDays': 8.5,
        },
        summary: 'Gửi đơn nghỉ phép',
      ),
    );

    await tester.pumpWidget(_BubbleTestApp(message: message));
    await tester.pumpAndSettle();

    expect(find.text('8.5 ngày'), findsOneWidget);
    expect(find.text('0 ngày'), findsOneWidget);
    expect(find.text(S.current.leaveBalanceInsufficientHelper), findsOneWidget);
    expect(find.text(S.current.leaveBalanceChooseDatesAgain), findsOneWidget);
    expect(
      tester
          .widget<IrhButton>(find.byKey(const Key('confirm-action')))
          .onPressed,
      isNull,
    );
  });

  testWidgets('recalculates a valid half-day request consistently', (
    tester,
  ) async {
    final message = ChatMessage(
      id: 'half-day-balance',
      type: MessageType.text,
      sender: MessageSender.assistant,
      createdAt: DateTime(2026, 9, 17),
      status: MessageStatus.success,
      confirmation: const ChatConfirmAction(
        tool: ChatConfirmationTool.createLeave,
        args: {
          'type': 'ANNUAL',
          'reason': 'Việc cá nhân',
          'requestedDays': 1.5,
        },
        summary: 'Gửi đơn nghỉ phép',
      ),
    );

    await tester.pumpWidget(_BubbleTestApp(message: message));
    await tester.pumpAndSettle();

    expect(find.text('1.5 ngày'), findsOneWidget);
    expect(find.text('6.5 ngày'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('6[.,]5.*12')), findsOneWidget);
    expect(
      tester
          .widget<IrhButton>(find.byKey(const Key('confirm-action')))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('shows only the current balance before dates are selected', (
    tester,
  ) async {
    final message = ChatMessage(
      id: 'current-leave-balance',
      type: MessageType.text,
      sender: MessageSender.assistant,
      createdAt: DateTime(2026, 9, 17),
      status: MessageStatus.success,
      confirmation: const ChatConfirmAction(
        tool: ChatConfirmationTool.createLeave,
        args: {'type': 'ANNUAL', 'reason': 'Việc cá nhân'},
        summary: 'Gửi đơn nghỉ phép',
      ),
    );

    await tester.pumpWidget(_BubbleTestApp(message: message));
    await tester.pumpAndSettle();

    expect(find.text(S.current.leaveBalanceCurrentTitle), findsNWidgets(2));
    expect(find.text(S.current.leaveBalanceRequestedLabel), findsNothing);
    expect(find.text(S.current.leaveBalanceProjectedLabel), findsNothing);
    expect(
      tester
          .widget<IrhButton>(find.byKey(const Key('confirm-action')))
          .onPressed,
      isNull,
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

  testWidgets('does not accept a mutation result when done disagrees', (
    tester,
  ) async {
    final repository = _FakeChatRepository(didMutateOnConfirm: false);
    await tester.pumpWidget(_ChatTestApp(repository: repository));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      '#confirm',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm-action')));
    await tester.pumpAndSettle();

    expect(find.text(S.current.mutationResultMismatch), findsOneWidget);
    expect(find.text(S.current.createLeaveSuccess), findsNothing);
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
      {
        DataRefreshScope.leaves,
        DataRefreshScope.home,
        DataRefreshScope.chatHistory,
      },
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

    expect(find.text(S.current.jiraMatchingWork(50)), findsOneWidget);
    expect(find.byKey(const Key('jira-overview-section')), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-segmented-progress')), findsNothing);
    expect(find.text('SCRUM-1'), findsNWidgets(3));
    expect(find.text('Hoàn thiện SSE'), findsNWidgets(3));
    expect(find.text('Hạn: 30/09/2026'), findsNWidgets(3));
    expect(find.text(S.current.jiraViewAllWork(50)), findsOneWidget);
    expect(find.text(S.current.jiraPossiblyTruncated), findsNothing);
  });

  testWidgets('renders a single Jira task as a tappable detail card', (
    tester,
  ) async {
    Uri? openedUri;
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          result: ChatResultEnvelope.jiraIssues(
            JiraIssueList(
              issues: const [_jiraIssue],
              stats: _jiraStats(total: 1, toDo: 1),
            ),
          ),
        ),
        openExternalUrl: (uri) async {
          openedUri = uri;
          return true;
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(S.current.jiraMatchingWork(1)), findsOneWidget);
    expect(find.byKey(const Key('jira-overview-section')), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-segmented-progress')), findsNothing);
    expect(find.text(S.current.jiraStatusTodo), findsWidgets);
    expect(find.text('Hạn: 30/09/2026'), findsOneWidget);
    expect(find.text('Cao'), findsOneWidget);
    final openButton = find.byKey(const Key('jira-issue-SCRUM-1'));
    await tester.ensureVisible(openButton);
    await tester.tap(openButton);
    await tester.pump();
    expect(openedUri, Uri.parse('https://jira.example/browse/SCRUM-1'));
  });

  testWidgets('renders compact Jira metadata and overdue states', (
    tester,
  ) async {
    final longTitle = List.filled(20, 'Tiêu đề Jira rất dài').join(' ');
    final issues = [
      _jiraIssue.copyWith(
        key: 'SCRUM-OVERDUE',
        summary: 'Task quá hạn',
        dueDate: '2020-01-01',
      ),
      _jiraIssue.copyWith(
        key: 'SCRUM-DONE',
        summary: 'Task đã hoàn thành',
        status: 'Closed',
        statusCategory: 'DONE',
        dueDate: '2020-01-01',
        priority: 'Medium',
      ),
      _jiraIssue.copyWith(
        key: 'SCRUM-LONG',
        summary: longTitle,
        status: 'In Review',
        statusCategory: 'IN_PROGRESS',
        dueDate: null,
        priority: '',
      ),
    ];
    await tester.pumpWidget(
      _BubbleTestApp(
        message: _assistantMessage(
          result: ChatResultEnvelope.jiraIssues(
            JiraIssueList(
              issues: issues,
              stats: _jiraStats(total: 3, toDo: 1, inProgress: 1, done: 1),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('jira-overview-section')), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-segmented-progress')), findsNothing);
    expect(find.textContaining('Quá hạn '), findsOneWidget);
    expect(find.text('Hạn: 01/01/2020'), findsOneWidget);
    expect(find.text(S.current.jiraDueMissing), findsOneWidget);
    expect(find.text(S.current.jiraPriorityMissing), findsOneWidget);
    expect(find.text(S.current.jiraStatusDone), findsWidgets);
    expect(find.text(S.current.jiraStatusInProgress), findsWidgets);
    expect(find.textContaining(longTitle), findsOneWidget);
    expect(tester.takeException(), isNull);
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
    expect(find.text(S.current.jiraEmptyResult), findsOneWidget);

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

  testWidgets('renders rich blocks, action and suggestions', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _BubbleTestApp(
        message: ChatMessage(
          id: 'rich-message',
          type: MessageType.text,
          sender: MessageSender.assistant,
          content: 'Bạn còn 9 ngày phép',
          createdAt: DateTime(2026, 9, 17),
          status: MessageStatus.success,
          highlights: const [
            ChatHighlight(
              start: 9,
              end: 10,
              kind: ChatHighlightKind.metric,
              tone: ChatTone.ok,
            ),
          ],
          blocks: const [
            ChatRichBlock(
              type: ChatBlockType.kpis,
              items: [
                ChatBlockItem(
                  label: 'Phép còn lại',
                  value: 9,
                  tone: ChatTone.ok,
                ),
              ],
            ),
          ],
          uiAction: const ChatUiAction(
            key: ChatUiActionKey.leaveResults,
            label: 'Xem đơn nghỉ phép',
            path: '/leaves',
          ),
          suggestions: const [
            ChatSuggestion(label: 'Xem chi tiết', text: 'Liệt kê đơn nghỉ'),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('rich-block-kpis')), findsOneWidget);
    expect(find.text('Phép còn lại'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('Xem đơn nghỉ phép'), findsOneWidget);
    expect(
      tester
          .getSize(find.byKey(const Key('chat-ui-action-leaveResults')))
          .width,
      greaterThan(200),
    );
    expect(find.text('Xem chi tiết'), findsNothing);
    expect(find.byType(IrhOptionChip), findsNothing);
  });

  testWidgets('shows suggestion chips only for the latest message', (
    tester,
  ) async {
    final messages = [
      ChatMessage(
        id: 'older-suggestions',
        type: MessageType.text,
        sender: MessageSender.assistant,
        content: 'Phản hồi cũ',
        createdAt: DateTime(2026, 9, 17, 8),
        status: MessageStatus.success,
        suggestions: const [
          ChatSuggestion(label: 'Lựa chọn cũ', text: 'Nội dung cũ'),
        ],
      ),
      ChatMessage(
        id: 'latest-suggestions',
        type: MessageType.text,
        sender: MessageSender.assistant,
        content: 'Phản hồi mới',
        createdAt: DateTime(2026, 9, 17, 9),
        status: MessageStatus.success,
        suggestions: const [
          ChatSuggestion(label: 'Lựa chọn mới', text: 'Nội dung mới'),
          ChatSuggestion(label: 'Lựa chọn khác', text: 'Nội dung khác'),
        ],
      ),
    ];

    await tester.pumpWidget(
      _ChatTestApp(
        repository: _FakeChatRepository(detailMessages: messages),
        threadId: 'thread-suggestions',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Lựa chọn cũ'), findsNothing);
    expect(find.text('Lựa chọn mới'), findsOneWidget);
    expect(find.text('Lựa chọn khác'), findsOneWidget);
    expect(find.byType(IrhOptionChip), findsNWidgets(2));
    expect(
      tester.getTopLeft(find.text('Lựa chọn mới')).dy,
      tester.getTopLeft(find.text('Lựa chọn khác')).dy,
    );
    expect(
      tester.getTopLeft(find.text('Lựa chọn mới')).dx,
      lessThan(tester.getTopLeft(find.text('Lựa chọn khác')).dx),
    );
    expect(find.byKey(const Key('chat-quick-actions')), findsOneWidget);
    expect(
      tester.getBottomLeft(find.byKey(const Key('chat-quick-actions'))).dy,
      lessThanOrEqualTo(
        tester.getTopLeft(find.byKey(const Key('chat-text-field'))).dy,
      ),
    );
  });

  testWidgets('makes Jira quick actions entity-specific', (tester) async {
    final message = ChatMessage(
      id: 'jira-suggestions',
      type: MessageType.text,
      sender: MessageSender.assistant,
      createdAt: DateTime(2026, 9, 17),
      status: MessageStatus.success,
      executedResult: ChatResultEnvelope.jiraIssues(
        JiraIssueList(
          issues: const [_jiraIssue],
          stats: _jiraStats(total: 1, toDo: 1),
        ),
      ),
      suggestions: const [
        ChatSuggestion(label: 'Tóm tắt task thứ nhất', text: 'Tóm tắt task'),
        ChatSuggestion(
          label: 'Chuyển trạng thái task này',
          text: 'Chuyển trạng thái task',
        ),
      ],
    );
    await tester.pumpWidget(
      _ChatTestApp(
        repository: _FakeChatRepository(detailMessages: [message]),
        threadId: 'thread-jira-suggestions',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tóm tắt SCRUM-1'), findsOneWidget);
    expect(find.text('Chuyển trạng thái SCRUM-1'), findsOneWidget);
    expect(find.text('Tóm tắt task thứ nhất'), findsNothing);
  });

  testWidgets('opens validated Jira rich action externally', (tester) async {
    Uri? opened;
    await tester.pumpWidget(
      _BubbleTestApp(
        message: ChatMessage(
          id: 'jira-action',
          type: MessageType.text,
          sender: MessageSender.assistant,
          content: 'Đã tìm thấy Jira task',
          createdAt: DateTime(2026, 9, 17),
          status: MessageStatus.success,
          uiAction: const ChatUiAction(
            key: ChatUiActionKey.jiraIssue,
            label: 'Mở SCRUM-1',
            url: 'https://jira.example/browse/SCRUM-1',
          ),
        ),
        openExternalUrl: (uri) async {
          opened = uri;
          return true;
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('chat-ui-action-jiraIssue')));
    await tester.pumpAndSettle();

    expect(opened?.toString(), 'https://jira.example/browse/SCRUM-1');
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

  testWidgets('settles at the bottom while restored lazy items are laid out', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final messages = List.generate(
      80,
      (index) => ChatMessage(
        id: 'lazy-restored-$index',
        type: MessageType.text,
        sender: index.isEven ? MessageSender.user : MessageSender.assistant,
        content: List.filled(
          index % 5 + 1,
          'Nội dung dài của tin nhắn lịch sử số $index',
        ).join('\n'),
        createdAt: DateTime.utc(2026, 9, 6, 8).add(Duration(minutes: index)),
        status: MessageStatus.success,
      ),
    );

    await tester.pumpWidget(
      _ChatTestApp(
        repository: _FakeChatRepository(detailMessages: messages),
        threadId: 'thread-lazy-long',
      ),
    );
    await tester.pumpAndSettle();

    final listView = tester.widget<ListView>(
      find.byKey(const Key('chat-list')),
    );
    final position = listView.controller!.position;
    expect(position.maxScrollExtent, greaterThan(0));
    expect(position.pixels, closeTo(position.maxScrollExtent, .1));
    expect(find.byKey(const Key('ai-bubble-lazy-restored-79')), findsOneWidget);
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
      builder: (context, child) =>
          RepositoryProvider<CredentialRepository>.value(
            value: const _FakeCredentialRepository(),
            child: MaterialApp(
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
      builder: (context, child) =>
          RepositoryProvider<CredentialRepository>.value(
            value: const _FakeCredentialRepository(),
            child: MaterialApp(
              locale: const Locale('vi'),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: SingleChildScrollView(
                  child: ChatBubble(
                    message: message,
                    openExternalUrl: openExternalUrl ?? (_) async => true,
                  ),
                ),
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
    this.didMutateOnConfirm = true,
  });

  final List<ChatMessage> detailMessages;
  final bool failConfirmationOnce;
  final bool didMutateOnConfirm;
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
    if (message == '#rich') {
      yield const ChatStreamToken('Phản hồi dở');
      yield const ChatStreamDone(
        threadId: 'thread-new',
        reply: 'Phản hồi đầy đủ từ máy chủ',
        blocks: [
          ChatRichBlock(
            type: ChatBlockType.kpis,
            items: [ChatBlockItem(label: 'Phép còn lại', value: 9)],
          ),
        ],
        suggestions: [
          ChatSuggestion(
            label: 'Xem chi tiết',
            text: 'Liệt kê đơn nghỉ của tôi',
          ),
        ],
      );
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
            'to': '2026-09-18',
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
        didMutate: didMutateOnConfirm,
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

class _FakeCredentialRepository implements CredentialRepository {
  const _FakeCredentialRepository();

  @override
  Future<AuthSession?> read() async => _chatSession;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}

  @override
  Future<void> clear() async {}
}

const _chatSession = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'D',
    annualRemaining: 8,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);

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

JiraStats _jiraStats({
  required int total,
  int toDo = 0,
  int inProgress = 0,
  int done = 0,
}) => JiraStats(
  total: total,
  toDo: toDo,
  inProgress: inProgress,
  done: done,
  unknown: total - toDo - inProgress - done,
  overdue: 0,
  stale: 0,
  withoutDueDate: 0,
  byStatus: const {},
  byPriority: const {},
  byIssueType: const {},
  byProject: const {},
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
