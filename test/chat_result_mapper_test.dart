import 'package:chatbot_project/data/mapper/chat_result_mapper.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('classifies typed read previews without mutation semantics', () {
    final cases = <({Object raw, Type expected})>[
      (
        raw: {
          'employeeCode': 'EMP001',
          'annualRemaining': 9,
          'annualTotal': 12,
          'sickRemaining': 30,
        },
        expected: ChatLeaveBalanceResult,
      ),
      (raw: [_leave], expected: ChatLeaveListResult),
      (raw: [_trip], expected: ChatTripListResult),
      (
        raw: {
          'leaves': [_leave],
          'trips': [_trip],
        },
        expected: ChatPendingApprovalsResult,
      ),
      (raw: [_jiraIssue], expected: ChatJiraIssuesResult),
    ];

    for (final item in cases) {
      final result = ChatResultMapper.map(item.raw);
      expect(result.runtimeType, item.expected);
      expect(result.isMutation, isFalse);
      expect(result.refreshScopes, isEmpty);
    }

    final jira = ChatResultMapper.map([_jiraIssue]) as ChatJiraIssuesResult;
    expect(jira.data.stats.total, 1);
    expect(jira.data.stats.toDo, 1);
    expect(jira.data.stats.byPriority, {'High': 1});
  });

  test('uses a trusted runtime hint to type an empty Jira result', () {
    final result = ChatResultMapper.map(
      const [],
      previewHint: ChatResultPreviewHint.jiraIssues,
    );

    expect(result, isA<ChatJiraIssuesResult>());
    final data = (result as ChatJiraIssuesResult).data;
    expect(data.issues, isEmpty);
    expect(data.stats.total, 0);
    expect(data.mayBeTruncated, isFalse);
  });

  test('accepts nullable Jira dates and URLs', () {
    final preview = ChatResultMapper.map([_jiraIssue]) as ChatJiraIssuesResult;
    expect(preview.data.issues.single.dueDate, isNull);
    expect(preview.data.issues.single.updated, isNull);
    expect(preview.data.issues.single.url, isNull);

    final createPayload = Map<String, dynamic>.from(_jiraCreate)
      ..['url'] = null;
    final mutation =
        ChatResultMapper.map(
              createPayload,
              confirmedTool: ChatConfirmationTool.createJiraTask,
            )
            as ChatJiraMutationResult;
    expect(mutation.data.url, isNull);
  });

  test('classifies mutations only with a matching confirmed tool', () {
    final cases =
        <
          ({
            ChatConfirmationTool tool,
            Object raw,
            Type expected,
            Set<DataRefreshScope> scopes,
          })
        >[
          (
            tool: ChatConfirmationTool.createLeave,
            raw: _leave,
            expected: ChatLeaveMutationResult,
            scopes: const {DataRefreshScope.leaves, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.updateLeave,
            raw: _leave,
            expected: ChatLeaveMutationResult,
            scopes: const {DataRefreshScope.leaves, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.cancelLeave,
            raw: _leave,
            expected: ChatLeaveMutationResult,
            scopes: const {DataRefreshScope.leaves, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.createTrip,
            raw: _trip,
            expected: ChatTripMutationResult,
            scopes: const {DataRefreshScope.trips, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.approveLeaves,
            raw: {
              'count': 1,
              'items': [_leave],
            },
            expected: ChatLeaveBatchMutationResult,
            scopes: const {DataRefreshScope.leaves, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.rejectLeaves,
            raw: {
              'count': 1,
              'items': [_leave],
            },
            expected: ChatLeaveBatchMutationResult,
            scopes: const {DataRefreshScope.leaves, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.approveTrips,
            raw: {
              'count': 1,
              'items': [_trip],
            },
            expected: ChatTripBatchMutationResult,
            scopes: const {DataRefreshScope.trips, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.rejectTrips,
            raw: {
              'count': 1,
              'items': [_trip],
            },
            expected: ChatTripBatchMutationResult,
            scopes: const {DataRefreshScope.trips, DataRefreshScope.home},
          ),
          (
            tool: ChatConfirmationTool.createJiraTask,
            raw: _jiraCreate,
            expected: ChatJiraMutationResult,
            scopes: const {DataRefreshScope.jira},
          ),
        ];

    for (final item in cases) {
      final result = ChatResultMapper.map(item.raw, confirmedTool: item.tool);
      expect(result.runtimeType, item.expected, reason: item.tool.name);
      expect(result.isMutation, isTrue, reason: item.tool.name);
      expect(result.refreshScopes, item.scopes, reason: item.tool.name);
    }
  });

  test('keeps empty, malformed and mismatched results unknown', () {
    final results = [
      ChatResultMapper.map(const []),
      ChatResultMapper.map({'unexpected': true}),
      ChatResultMapper.map(
        _trip,
        confirmedTool: ChatConfirmationTool.createLeave,
      ),
      ChatResultMapper.map({
        'count': 2,
        'items': [_leave],
      }, confirmedTool: ChatConfirmationTool.approveLeaves),
    ];

    for (final result in results) {
      expect(result, isA<ChatUnknownResult>());
      expect(result.isMutation, isFalse);
      expect(result.isKnown, isFalse);
    }
  });
}

const _leave = <String, dynamic>{
  '_id': 'leave-1',
  'employeeCode': 'EMP001',
  'employeeName': 'Nguyễn Văn A',
  'type': 'ANNUAL',
  'from': '2026-09-20',
  'to': '2026-09-21',
  'days': 2,
  'reason': 'Nghỉ phép',
  'status': 'PENDING',
};

const _trip = <String, dynamic>{
  '_id': 'trip-1',
  'employeeCode': 'EMP001',
  'employeeName': 'Nguyễn Văn A',
  'destination': 'Đà Nẵng',
  'from': '2026-09-20',
  'to': '2026-09-21',
  'purpose': 'Gặp khách hàng',
  'status': 'PENDING',
};

const _jiraIssue = <String, dynamic>{
  'key': 'SCRUM-1',
  'summary': 'Hoàn thiện SSE',
  'status': 'To Do',
  'statusCategory': 'TO_DO',
  'priority': 'High',
  'issueType': 'Task',
  'projectKey': 'SCRUM',
  'assignee': 'a@msb.vn',
  'dueDate': null,
  'updated': null,
  'url': null,
};

const _jiraCreate = <String, dynamic>{
  'key': 'SCRUM-2',
  'summary': 'Hoàn thiện SSE',
  'projectKey': 'SCRUM',
  'issueType': 'Task',
  'assigneeEmail': 'a@msb.vn',
  'url': 'https://jira.example/browse/SCRUM-2',
  'message': 'Đã tạo Jira SCRUM-2',
};
