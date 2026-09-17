import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/service/jira_task_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 9, 17);

  test('ranks overdue, due soon, in progress and missing due date', () {
    final remaining = _issue('REST', dueDate: '2026-10-30');
    final missing = _issue('MISSING', dueDate: null);
    final inProgress = _issue(
      'PROGRESS',
      status: 'In Progress',
      statusCategory: 'IN_PROGRESS',
      dueDate: '2026-10-20',
    );
    final dueSoon = _issue('SOON', dueDate: '2026-09-19');
    final overdue = _issue('OVERDUE', dueDate: '2026-09-10');

    final ranked = JiraTaskRules.rankedIssues([
      remaining,
      missing,
      inProgress,
      dueSoon,
      overdue,
    ], now: now);

    expect(ranked.map((issue) => issue.key), [
      'OVERDUE',
      'SOON',
      'PROGRESS',
      'MISSING',
      'REST',
    ]);
  });

  test('does not count completed old task as overdue', () {
    final completed = _issue(
      'DONE',
      status: 'Closed',
      statusCategory: 'DONE',
      dueDate: '2020-01-01',
    );

    final due = JiraDueInfo.fromIssue(completed, now: now);
    final risk = JiraTaskRules.riskSummary([completed], now: now);

    expect(due.isOverdue, isFalse);
    expect(risk.overdue, 0);
  });

  test('maps Jira due date to an exclusive all-day calendar range', () {
    final issue = _issue('SCRUM-8', dueDate: '2026-09-20');
    final draft = JiraCalendarDraftMapper.fromIssue(
      issue: issue,
      start: DateTime(2026, 9, 20),
      isAllDay: true,
      statusLabel: 'Cần làm',
      priorityLabel: 'Medium',
      statusPrefix: 'Trạng thái',
      priorityPrefix: 'Ưu tiên',
      assigneePrefix: 'Người phụ trách',
      jiraPrefix: 'Jira',
      reminderBefore: const Duration(days: 1),
    );

    expect(draft.title, '[Jira] SCRUM-8 · Task SCRUM-8');
    expect(draft.start, DateTime(2026, 9, 20));
    expect(draft.end, DateTime(2026, 9, 21));
    expect(draft.isAllDay, isTrue);
    expect(draft.reminderBefore, const Duration(days: 1));
    expect(draft.description, contains('Trạng thái: Cần làm'));
    expect(draft.description, contains('Jira: https://jira.example/SCRUM-8'));
  });

  test('accepts only safe HTTP Jira issue URLs', () {
    expect(
      JiraTaskRules.issueUri(_issue('SAFE')),
      Uri.parse('https://jira.example/SAFE'),
    );
    expect(
      JiraTaskRules.issueUri(
        _issue('UNSAFE').copyWith(url: 'javascript:alert(1)'),
      ),
      isNull,
    );
    expect(
      JiraTaskRules.issueUri(_issue('MISSING').copyWith(url: null)),
      isNull,
    );
  });
}

JiraIssue _issue(
  String key, {
  String status = 'To Do',
  String statusCategory = 'TO_DO',
  String? dueDate,
}) => JiraIssue(
  key: key,
  summary: 'Task $key',
  status: status,
  statusCategory: statusCategory,
  priority: 'Medium',
  issueType: 'Task',
  projectKey: 'SCRUM',
  assignee: 'Nguyễn Văn A',
  dueDate: dueDate,
  url: 'https://jira.example/$key',
);
