import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/chat/widgets/jira_result_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('supports loading, error and empty states', (tester) async {
    final emptyData = JiraIssueList(
      issues: const [],
      stats: _stats(total: 0, toDo: 0),
    );
    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: emptyData,
          isLoading: true,
          onOpenTask: (_) {},
        ),
      ),
    );
    expect(find.text('Đang tải công việc Jira...'), findsOneWidget);

    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: emptyData,
          errorMessage: 'Jira tạm thời không khả dụng.',
          onOpenTask: (_) {},
        ),
      ),
    );
    expect(find.text('Jira tạm thời không khả dụng.'), findsOneWidget);

    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(data: emptyData, onOpenTask: (_) {}),
      ),
    );
    expect(find.byKey(const Key('jira-result-empty')), findsOneWidget);
  });

  testWidgets('one task is detail-first and the full item is tappable', (
    tester,
  ) async {
    JiraIssue? opened;
    final issue = _issue('SCRUM-1', dueDate: '2026-09-19');
    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: JiraIssueList(
            issues: [issue],
            stats: _stats(total: 1, toDo: 1),
          ),
          now: DateTime(2026, 9, 17),
          onOpenTask: (value) => opened = value,
        ),
      ),
    );

    expect(find.text('Có 1 công việc khớp bộ lọc'), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.text('Còn 2 ngày'), findsOneWidget);
    final openButton = find.byKey(const Key('jira-issue-SCRUM-1'));
    await tester.ensureVisible(openButton);
    await tester.tap(openButton);
    await tester.pump();
    expect(opened, issue);
  });

  testWidgets('five tasks show summaries and at most three ranked previews', (
    tester,
  ) async {
    final issues = [
      _issue('REST', dueDate: '2026-10-30'),
      _issue('MISSING'),
      _issue(
        'PROGRESS',
        status: 'In Progress',
        statusCategory: 'IN_PROGRESS',
        dueDate: '2026-10-20',
      ),
      _issue('SOON', dueDate: '2026-09-19'),
      _issue('OVERDUE', dueDate: '2026-09-10'),
    ];
    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: JiraIssueList(
            issues: issues,
            stats: _stats(total: 5, toDo: 4, inProgress: 1),
          ),
          now: DateTime(2026, 9, 17),
          onOpenTask: (_) {},
          onOpenOverview: () {},
        ),
      ),
    );

    expect(find.text('Có 5 công việc khớp bộ lọc'), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-priority-chart')), findsNothing);
    expect(find.byKey(const Key('jira-issue-OVERDUE')), findsOneWidget);
    expect(find.byKey(const Key('jira-issue-SOON')), findsOneWidget);
    expect(find.byKey(const Key('jira-issue-PROGRESS')), findsOneWidget);
    expect(find.byKey(const Key('jira-issue-REST')), findsNothing);
    expect(find.text('Xem tất cả 5 công việc'), findsOneWidget);

    await tester.tap(find.text('Xem phân tích'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('jira-priority-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-composition-chart')), findsNothing);
    expect(find.text('Thu gọn'), findsOneWidget);
  });

  testWidgets('reveals meaningful donut and exposes calendar actions', (
    tester,
  ) async {
    JiraIssue? addedIssue;
    List<JiraIssue>? addedIssues;
    final issues = [
      _issue('TASK', dueDate: '2026-09-19'),
      _issue('BUG', dueDate: '2026-09-20', priority: 'High', issueType: 'Bug'),
      _issue('NO-DUE', priority: 'Low', issueType: 'Story'),
    ];
    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: JiraIssueList(
            issues: issues,
            stats: _stats(
              total: 3,
              toDo: 3,
              byPriority: const {'Medium': 1, 'High': 1, 'Low': 1},
              byIssueType: const {'Task': 1, 'Bug': 1, 'Story': 1},
            ),
          ),
          now: DateTime(2026, 9, 17),
          onOpenTask: (_) {},
          onAddToCalendar: (issue) async {
            addedIssue = issue;
            return true;
          },
          onAddAllToCalendar: (values) async {
            addedIssues = values;
            return values.map((issue) => issue.key).toSet();
          },
        ),
      ),
    );

    expect(find.byKey(const Key('jira-composition-chart')), findsNothing);
    await tester.tap(find.text('Xem phân tích'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('jira-composition-chart')), findsOneWidget);
    expect(find.text('3'), findsWidgets);
    expect(find.byKey(const Key('jira-add-calendar-NO-DUE')), findsOneWidget);
    expect(find.text('Thêm 3 công việc vào lịch'), findsOneWidget);

    final addButton = tester.widget<CupertinoButton>(
      find
          .ancestor(
            of: find.text('Thêm vào lịch').first,
            matching: find.byType(CupertinoButton),
          )
          .first,
    );
    addButton.onPressed!();
    await tester.pumpAndSettle();
    expect(addedIssue, isNotNull);
    expect(find.text('Đã thêm'), findsOneWidget);
    final addAllButton = tester.widget<CupertinoButton>(
      find
          .ancestor(
            of: find.text('Thêm 2 công việc vào lịch'),
            matching: find.byType(CupertinoButton),
          )
          .first,
    );
    addAllButton.onPressed!();
    await tester.pump();
    expect(addedIssues, hasLength(2));
  });

  testWidgets('stays readable at 320px and collapses unknown priorities', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final issues = [_issue('ONE', priority: ''), _issue('TWO', priority: '')];
    await tester.pumpWidget(
      _TestApp(
        child: JiraResultCard(
          data: JiraIssueList(
            issues: issues,
            stats: _stats(
              total: 2,
              toDo: 2,
              byPriority: const {'': 2},
              byIssueType: const {'Task': 2},
            ),
          ),
          onOpenTask: (_) {},
        ),
      ),
    );

    expect(find.byKey(const Key('jira-composition-chart')), findsNothing);
    await tester.tap(find.text('Xem phân tích'));
    await tester.pumpAndSettle();
    expect(find.text('Chưa có thông tin độ ưu tiên · 2 task'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MaterialApp(
      locale: const Locale('vi'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

JiraIssue _issue(
  String key, {
  String status = 'To Do',
  String statusCategory = 'TO_DO',
  String? dueDate,
  String priority = 'Medium',
  String issueType = 'Task',
}) => JiraIssue(
  key: key,
  summary: 'Task $key',
  status: status,
  statusCategory: statusCategory,
  priority: priority,
  issueType: issueType,
  projectKey: 'SCRUM',
  assignee: '',
  dueDate: dueDate,
  url: 'https://jira.example/$key',
);

JiraStats _stats({
  required int total,
  int toDo = 0,
  int inProgress = 0,
  int done = 0,
  Map<String, int> byPriority = const {},
  Map<String, int> byIssueType = const {},
}) => JiraStats(
  total: total,
  toDo: toDo,
  inProgress: inProgress,
  done: done,
  unknown: 0,
  overdue: 0,
  stale: 0,
  withoutDueDate: 0,
  byStatus: const {},
  byPriority: byPriority,
  byIssueType: byIssueType,
  byProject: const {},
);
