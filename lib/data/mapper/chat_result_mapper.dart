import '../../domain/model/chat_result.dart';
import '../../domain/model/chat_stream_event.dart';
import '../../domain/model/hr_request.dart';
import '../model/home/home_models.dart';
import '../model/hr/hr_request_dto.dart';
import 'hr_request_mapper.dart';

enum ChatResultPreviewHint { leaveList, tripList, jiraIssues }

class ChatResultMapper {
  const ChatResultMapper._();

  static ChatResultEnvelope map(
    Object? raw, {
    ChatConfirmationTool? confirmedTool,
    ChatResultPreviewHint? previewHint,
  }) {
    try {
      if (confirmedTool != null) {
        return _mapMutation(raw, confirmedTool);
      }
      return _mapPreview(raw, previewHint: previewHint);
    } on Object {
      return ChatResultEnvelope.unknown(raw);
    }
  }

  static ChatResultEnvelope _mapMutation(
    Object? raw,
    ChatConfirmationTool tool,
  ) {
    final json = _map(raw);
    return switch (tool) {
      ChatConfirmationTool.createLeave => ChatResultEnvelope.leaveMutation(
        mutation: ChatMutationType.createLeave,
        data: _leave(json),
      ),
      ChatConfirmationTool.updateLeave => ChatResultEnvelope.leaveMutation(
        mutation: ChatMutationType.updateLeave,
        data: _leave(json),
      ),
      ChatConfirmationTool.cancelLeave => ChatResultEnvelope.leaveMutation(
        mutation: ChatMutationType.cancelLeave,
        data: _leave(json),
      ),
      ChatConfirmationTool.createTrip => ChatResultEnvelope.tripMutation(
        mutation: ChatMutationType.createTrip,
        data: _trip(json),
      ),
      ChatConfirmationTool.approveLeaves =>
        ChatResultEnvelope.leaveBatchMutation(
          mutation: ChatMutationType.approveLeaves,
          data: _leaveBatch(json),
        ),
      ChatConfirmationTool.rejectLeaves =>
        ChatResultEnvelope.leaveBatchMutation(
          mutation: ChatMutationType.rejectLeaves,
          data: _leaveBatch(json),
        ),
      ChatConfirmationTool.approveTrips => ChatResultEnvelope.tripBatchMutation(
        mutation: ChatMutationType.approveTrips,
        data: _tripBatch(json),
      ),
      ChatConfirmationTool.rejectTrips => ChatResultEnvelope.tripBatchMutation(
        mutation: ChatMutationType.rejectTrips,
        data: _tripBatch(json),
      ),
      ChatConfirmationTool.createJiraTask => ChatResultEnvelope.jiraMutation(
        mutation: ChatMutationType.createJiraTask,
        data: _jiraCreate(json),
      ),
      ChatConfirmationTool.unknown => ChatResultEnvelope.unknown(raw),
    };
  }

  static ChatResultEnvelope _mapPreview(
    Object? raw, {
    ChatResultPreviewHint? previewHint,
  }) {
    if (raw is Map) {
      final json = Map<String, dynamic>.from(raw);
      if (_hasKeys(json, const {
        'employeeCode',
        'annualRemaining',
        'annualTotal',
        'sickRemaining',
      })) {
        return ChatResultEnvelope.leaveBalance(
          HrRequestMapper.mapBalance(LeaveBalanceDto.fromJson(json)),
        );
      }
      if (json.keys.toSet().containsAll(const {'leaves', 'trips'})) {
        return ChatResultEnvelope.pendingApprovals(
          PendingApprovals(
            leaves: _leaveList(json['leaves']),
            trips: _tripList(json['trips']),
          ),
        );
      }
      return ChatResultEnvelope.unknown(raw);
    }
    if (raw is List && raw.isEmpty) {
      return switch (previewHint) {
        ChatResultPreviewHint.leaveList => const ChatResultEnvelope.leaveList(
          [],
        ),
        ChatResultPreviewHint.tripList => const ChatResultEnvelope.tripList([]),
        ChatResultPreviewHint.jiraIssues => ChatResultEnvelope.jiraIssues(
          JiraIssueList(issues: const [], stats: _jiraStats(const [])),
        ),
        null => ChatResultEnvelope.unknown(raw),
      };
    }
    if (raw is List) {
      final first = _map(raw.first);
      if (_hasKeys(first, const {'type', 'days', 'reason'})) {
        return ChatResultEnvelope.leaveList(_leaveList(raw));
      }
      if (_hasKeys(first, const {'destination', 'purpose'})) {
        return ChatResultEnvelope.tripList(_tripList(raw));
      }
      if (_hasKeys(first, const {
        'key',
        'summary',
        'status',
        'priority',
        'projectKey',
      })) {
        final issues = raw.map(_jiraIssue).toList(growable: false);
        return ChatResultEnvelope.jiraIssues(
          JiraIssueList(
            issues: issues,
            stats: _jiraStats(issues),
            mayBeTruncated: issues.length >= 50,
          ),
        );
      }
    }
    return ChatResultEnvelope.unknown(raw);
  }

  static LeaveBatchMutation _leaveBatch(Map<String, dynamic> json) {
    final count = json['count'];
    if (count is! num) throw const FormatException('Invalid batch count');
    final items = _leaveList(json['items']);
    if (count.toInt() != items.length) {
      throw const FormatException('Batch count mismatch');
    }
    return LeaveBatchMutation(count: count.toInt(), items: items);
  }

  static TripBatchMutation _tripBatch(Map<String, dynamic> json) {
    final count = json['count'];
    if (count is! num) throw const FormatException('Invalid batch count');
    final items = _tripList(json['items']);
    if (count.toInt() != items.length) {
      throw const FormatException('Batch count mismatch');
    }
    return TripBatchMutation(count: count.toInt(), items: items);
  }

  static List<dynamic> _list(Object? raw) {
    if (raw is! List) throw const FormatException('Expected list');
    return raw;
  }

  static List<LeaveRequest> _leaveList(Object? raw) =>
      _list(raw).map((item) => _leave(_map(item))).toList(growable: false);

  static List<TripRequest> _tripList(Object? raw) =>
      _list(raw).map((item) => _trip(_map(item))).toList(growable: false);

  static LeaveRequest _leave(Map<String, dynamic> json) =>
      HrRequestMapper.mapLeave(LeaveRequestDto.fromJson(json));

  static TripRequest _trip(Map<String, dynamic> json) =>
      HrRequestMapper.mapTrip(TripRequestDto.fromJson(json));

  static JiraIssue _jiraIssue(Object? raw) {
    final json = _map(raw);
    return JiraIssue(
      key: _string(json, 'key'),
      summary: _string(json, 'summary'),
      status: _string(json, 'status'),
      statusCategory: _string(json, 'statusCategory'),
      priority: _string(json, 'priority'),
      issueType: _string(json, 'issueType'),
      projectKey: _string(json, 'projectKey'),
      assignee: _string(json, 'assignee'),
      dueDate: _nullableString(json, 'dueDate'),
      updated: _nullableString(json, 'updated'),
      url: _nullableString(json, 'url'),
    );
  }

  static JiraCreateResult _jiraCreate(Map<String, dynamic> json) =>
      JiraCreateResult(
        key: _string(json, 'key'),
        summary: _string(json, 'summary'),
        projectKey: _string(json, 'projectKey'),
        issueType: _string(json, 'issueType'),
        assigneeEmail: _string(json, 'assigneeEmail'),
        url: _nullableString(json, 'url'),
        message: _string(json, 'message'),
      );

  static JiraStats _jiraStats(List<JiraIssue> issues) {
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(now.year, now.month, now.day);
    final staleBefore = today.subtract(const Duration(days: 14));
    var toDo = 0;
    var inProgress = 0;
    var done = 0;
    var unknown = 0;
    var overdue = 0;
    var stale = 0;
    var withoutDueDate = 0;
    final byStatus = <String, int>{};
    final byPriority = <String, int>{};
    final byIssueType = <String, int>{};
    final byProject = <String, int>{};
    for (final issue in issues) {
      switch (issue.statusCategory) {
        case 'TO_DO':
          toDo++;
        case 'IN_PROGRESS':
          inProgress++;
        case 'DONE':
          done++;
        default:
          unknown++;
      }
      _increment(byStatus, issue.status);
      _increment(byPriority, issue.priority);
      _increment(byIssueType, issue.issueType);
      _increment(byProject, issue.projectKey);
      final isDone = issue.statusCategory == 'DONE';
      final dueDate = DateTime.tryParse(issue.dueDate ?? '');
      if (!isDone && issue.dueDate == null) withoutDueDate++;
      if (!isDone && dueDate != null && dueDate.isBefore(today)) overdue++;
      final updated = DateTime.tryParse(issue.updated ?? '')?.toUtc();
      if (!isDone && updated != null && updated.isBefore(staleBefore)) stale++;
    }
    return JiraStats(
      total: issues.length,
      toDo: toDo,
      inProgress: inProgress,
      done: done,
      unknown: unknown,
      overdue: overdue,
      stale: stale,
      withoutDueDate: withoutDueDate,
      byStatus: byStatus,
      byPriority: byPriority,
      byIssueType: byIssueType,
      byProject: byProject,
    );
  }

  static void _increment(Map<String, int> values, String key) {
    values[key] = (values[key] ?? 0) + 1;
  }

  static Map<String, dynamic> _map(Object? raw) {
    if (raw is! Map) throw const FormatException('Expected map');
    return Map<String, dynamic>.from(raw);
  }

  static bool _hasKeys(Map<String, dynamic> json, Set<String> keys) =>
      json.keys.toSet().containsAll(keys);

  static String _string(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.trim().isEmpty) {
      throw FormatException('Invalid $key');
    }
    return value;
  }

  static String? _nullableString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is! String || value.trim().isEmpty) {
      throw FormatException('Invalid $key');
    }
    return value;
  }
}
