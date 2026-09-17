import 'package:chatbot_project/domain/model/calendar_event.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/service/device_calendar_service.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/jira/jira_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('all filter shows dashboard and status filter hides it', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _TestApp(
        child: JiraTaskOverviewPage(
          data: _overviewData,
          calendarService: _FakeCalendarService(CalendarEventResult.saved),
        ),
      ),
    );

    expect(find.byKey(const Key('jira-dashboard')), findsOneWidget);
    expect(find.byKey(const Key('jira-status-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-composition-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-priority-chart')), findsOneWidget);
    expect(find.byKey(const Key('jira-risk-chart')), findsOneWidget);

    final todoButton = tester.widget<CupertinoButton>(
      find
          .ancestor(
            of: find.text('Cần làm').first,
            matching: find.byType(CupertinoButton),
          )
          .first,
    );
    todoButton.onPressed!();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('jira-dashboard')), findsNothing);
    expect(find.byKey(const Key('jira-issue-SCRUM-8')), findsOneWidget);
    expect(find.byKey(const Key('jira-issue-SCRUM-9')), findsNothing);
  });

  testWidgets('missing due date asks for options before opening Calendar', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final service = _FakeCalendarService(CalendarEventResult.opened);
    await tester.pumpWidget(
      _TestApp(
        child: JiraTaskDetailPage(issue: _issue, calendarService: service),
      ),
    );

    await tester.tap(find.text('Thêm vào lịch'));
    await tester.pumpAndSettle();
    expect(find.text('Task này chưa có deadline.'), findsOneWidget);
    expect(find.text('Cả ngày'), findsOneWidget);
    expect(find.text('Có thời gian'), findsOneWidget);
    expect(find.text('Nhắc trước 1 ngày'), findsOneWidget);

    await tester.tap(find.text('Có thời gian'));
    await tester.tap(find.text('Không nhắc'));
    await tester.tap(find.text('Tiếp tục tới Lịch'));
    await tester.pumpAndSettle();

    expect(service.draft, isNotNull);
    expect(service.draft!.isAllDay, isFalse);
    expect(service.draft!.start.hour, 9);
    expect(
      service.draft!.end.difference(service.draft!.start),
      const Duration(hours: 1),
    );
    expect(service.draft!.reminderBefore, isNull);
    expect(find.text('Đã mở biểu mẫu Lịch.'), findsOneWidget);
  });

  testWidgets('completed task disables the Calendar action with a reason', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _TestApp(
        child: JiraTaskDetailPage(
          issue: _issue.copyWith(
            status: 'Closed',
            statusCategory: 'DONE',
            dueDate: '2020-01-01',
          ),
          calendarService: _FakeCalendarService(CalendarEventResult.saved),
        ),
      ),
    );

    final button = tester.widget<CupertinoButton>(
      find
          .ancestor(
            of: find.text('Thêm vào lịch'),
            matching: find.byType(CupertinoButton),
          )
          .first,
    );
    expect(button.onPressed, isNull);
    expect(
      find.text('Task đã hoàn thành nên không thể thêm vào lịch.'),
      findsOneWidget,
    );
    expect(find.textContaining('Quá hạn'), findsNothing);
  });

  testWidgets('timed Jira due date preserves its original instant', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final service = _FakeCalendarService(CalendarEventResult.cancelled);
    const dueDate = '2026-09-20T14:30:00+07:00';
    await tester.pumpWidget(
      _TestApp(
        child: JiraTaskDetailPage(
          issue: _issue.copyWith(dueDate: dueDate),
          calendarService: service,
        ),
      ),
    );

    await tester.tap(find.text('Thêm vào lịch'));
    await tester.pumpAndSettle();

    expect(service.draft, isNotNull);
    expect(service.draft!.isAllDay, isFalse);
    expect(service.draft!.start.toUtc(), DateTime.parse(dueDate).toUtc());
    expect(
      service.draft!.end.difference(service.draft!.start),
      const Duration(hours: 1),
    );
  });
}

class _FakeCalendarService implements DeviceCalendarService {
  _FakeCalendarService(this.result);

  final CalendarEventResult result;
  CalendarEventDraft? draft;

  @override
  Future<CalendarEventResult> openCreateEvent(CalendarEventDraft draft) async {
    this.draft = draft;
    return result;
  }
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [GoRoute(path: '/', builder: (_, _) => child)],
    );
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) => MaterialApp.router(
        locale: const Locale('vi'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}

const _issue = JiraIssue(
  key: 'SCRUM-8',
  summary: 'Đưa solution tích hợp ePro',
  status: 'To Do',
  statusCategory: 'TO_DO',
  priority: 'Medium',
  issueType: 'Task',
  projectKey: 'SCRUM',
  assignee: 'Nguyễn Văn A',
  url: 'https://jira.example/SCRUM-8',
);

final _overviewData = JiraIssueList(
  issues: [
    _issue,
    _issue.copyWith(
      key: 'SCRUM-9',
      summary: 'Đồng bộ dữ liệu',
      status: 'In Progress',
      statusCategory: 'IN_PROGRESS',
      priority: 'High',
      issueType: 'Story',
      dueDate: '2026-09-20',
    ),
  ],
  stats: const JiraStats(
    total: 2,
    toDo: 1,
    inProgress: 1,
    done: 0,
    unknown: 0,
    overdue: 1,
    stale: 0,
    withoutDueDate: 1,
    byStatus: {'To Do': 1, 'In Progress': 1},
    byPriority: {'Medium': 1, 'High': 1},
    byIssueType: {'Task': 1, 'Story': 1},
    byProject: {'SCRUM': 2},
  ),
  mayBeTruncated: false,
);
