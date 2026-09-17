import '../model/calendar_event.dart';
import '../model/chat_result.dart';

enum JiraWorkflowGroup { todo, inProgress, done, unknown }

enum JiraPriorityLevel { highest, high, medium, low, lowest, missing }

class JiraDueInfo {
  const JiraDueInfo({
    this.date,
    required this.daysUntilDue,
    required this.done,
  });

  final DateTime? date;
  final int? daysUntilDue;
  final bool done;

  bool get isMissing => date == null;
  bool get isOverdue => !done && (daysUntilDue ?? 0) < 0;
  bool get isDueToday => !done && daysUntilDue == 0;
  bool get isDueSoon =>
      !done && daysUntilDue != null && daysUntilDue! > 0 && daysUntilDue! <= 7;
  int get overdueDays => isOverdue ? -daysUntilDue! : 0;

  factory JiraDueInfo.fromIssue(JiraIssue issue, {DateTime? now}) {
    final parsed = DateTime.tryParse(issue.dueDate?.trim() ?? '');
    final group = JiraTaskRules.workflowGroup(issue);
    if (parsed == null) {
      return JiraDueInfo(
        daysUntilDue: null,
        done: group == JiraWorkflowGroup.done,
      );
    }
    final localDate = parsed.toLocal();
    final current = (now ?? DateTime.now()).toLocal();
    final today = DateTime(current.year, current.month, current.day);
    final dueDay = DateTime(localDate.year, localDate.month, localDate.day);
    return JiraDueInfo(
      date: localDate,
      daysUntilDue: dueDay.difference(today).inDays,
      done: group == JiraWorkflowGroup.done,
    );
  }
}

class JiraRiskSummary {
  const JiraRiskSummary({required this.overdue, required this.withoutDueDate});

  final int overdue;
  final int withoutDueDate;

  bool get hasRisks => overdue > 0 || withoutDueDate > 0;
}

abstract final class JiraTaskRules {
  static Uri? issueUri(JiraIssue issue) {
    final value = issue.url?.trim() ?? '';
    if (value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      return null;
    }
    return uri;
  }

  static JiraWorkflowGroup workflowGroup(JiraIssue issue) {
    final category = issue.statusCategory.trim().toUpperCase();
    if (category == 'TO_DO' || category == 'TODO' || category == 'NEW') {
      return JiraWorkflowGroup.todo;
    }
    if (category == 'IN_PROGRESS' || category == 'IN PROGRESS') {
      return JiraWorkflowGroup.inProgress;
    }
    if (category == 'DONE' || category == 'COMPLETE') {
      return JiraWorkflowGroup.done;
    }
    final status = issue.status.trim().toLowerCase();
    if (status.contains('done') ||
        status.contains('complete') ||
        status.contains('closed')) {
      return JiraWorkflowGroup.done;
    }
    if (status.contains('progress') || status.contains('review')) {
      return JiraWorkflowGroup.inProgress;
    }
    if (status.contains('to do') ||
        status.contains('open') ||
        status.contains('backlog')) {
      return JiraWorkflowGroup.todo;
    }
    return JiraWorkflowGroup.unknown;
  }

  static JiraPriorityLevel priorityLevel(String value) {
    return switch (value.trim().toLowerCase()) {
      'highest' => JiraPriorityLevel.highest,
      'high' => JiraPriorityLevel.high,
      'medium' => JiraPriorityLevel.medium,
      'low' => JiraPriorityLevel.low,
      'lowest' => JiraPriorityLevel.lowest,
      _ => JiraPriorityLevel.missing,
    };
  }

  static JiraRiskSummary riskSummary(
    Iterable<JiraIssue> issues, {
    DateTime? now,
  }) {
    var overdue = 0;
    var withoutDueDate = 0;
    for (final issue in issues) {
      final due = JiraDueInfo.fromIssue(issue, now: now);
      if (due.isOverdue) overdue++;
      if (!due.done && due.isMissing) withoutDueDate++;
    }
    return JiraRiskSummary(overdue: overdue, withoutDueDate: withoutDueDate);
  }

  static List<JiraIssue> rankedIssues(
    Iterable<JiraIssue> issues, {
    DateTime? now,
  }) {
    final indexed = issues.indexed.toList(growable: false);
    indexed.sort((left, right) {
      final priorityCompare = _rank(
        left.$2,
        now: now,
      ).compareTo(_rank(right.$2, now: now));
      if (priorityCompare != 0) return priorityCompare;
      final leftUpdated = DateTime.tryParse(left.$2.updated ?? '');
      final rightUpdated = DateTime.tryParse(right.$2.updated ?? '');
      if (leftUpdated != null && rightUpdated != null) {
        final updatedCompare = rightUpdated.compareTo(leftUpdated);
        if (updatedCompare != 0) return updatedCompare;
      }
      return left.$1.compareTo(right.$1);
    });
    return indexed.map((entry) => entry.$2).toList(growable: false);
  }

  static int _rank(JiraIssue issue, {DateTime? now}) {
    final due = JiraDueInfo.fromIssue(issue, now: now);
    if (due.isOverdue) return 0;
    if (due.isDueSoon || due.isDueToday) return 1;
    if (workflowGroup(issue) == JiraWorkflowGroup.inProgress) return 2;
    if (!due.done && due.isMissing) return 3;
    final priority = priorityLevel(issue.priority);
    if (priority == JiraPriorityLevel.highest ||
        priority == JiraPriorityLevel.high) {
      return 4;
    }
    return 5;
  }
}

abstract final class JiraCalendarDraftMapper {
  static CalendarEventDraft fromIssue({
    required JiraIssue issue,
    required DateTime start,
    required bool isAllDay,
    required String statusLabel,
    required String priorityLabel,
    required String statusPrefix,
    required String priorityPrefix,
    required String assigneePrefix,
    required String jiraPrefix,
    Duration? reminderBefore,
  }) {
    final normalizedStart = isAllDay
        ? DateTime(start.year, start.month, start.day)
        : start;
    final end = isAllDay
        ? normalizedStart.add(const Duration(days: 1))
        : normalizedStart.add(const Duration(hours: 1));
    final description = <String>[
      '$statusPrefix: $statusLabel',
      '$priorityPrefix: $priorityLabel',
      if (issue.assignee.trim().isNotEmpty)
        '$assigneePrefix: ${issue.assignee.trim()}',
      if (issue.url?.trim().isNotEmpty == true)
        '$jiraPrefix: ${issue.url!.trim()}',
    ].join('\n');
    return CalendarEventDraft(
      title: '[Jira] ${issue.key} · ${issue.summary}',
      description: description,
      start: normalizedStart,
      end: end,
      isAllDay: isAllDay,
      reminderBefore: reminderBefore,
    );
  }
}
