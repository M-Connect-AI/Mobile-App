import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_data.dart';
import 'hr_request.dart';

part 'chat_result.freezed.dart';

enum ChatMutationType {
  createLeave,
  updateLeave,
  cancelLeave,
  createTrip,
  approveLeaves,
  rejectLeaves,
  approveTrips,
  rejectTrips,
  createJiraTask,
}

enum DataRefreshScope { leaves, trips, home, jira }

@freezed
abstract class PendingApprovals with _$PendingApprovals {
  const factory PendingApprovals({
    required List<LeaveRequest> leaves,
    required List<TripRequest> trips,
  }) = _PendingApprovals;
}

@freezed
abstract class LeaveBatchMutation with _$LeaveBatchMutation {
  const factory LeaveBatchMutation({
    required int count,
    required List<LeaveRequest> items,
  }) = _LeaveBatchMutation;
}

@freezed
abstract class TripBatchMutation with _$TripBatchMutation {
  const factory TripBatchMutation({
    required int count,
    required List<TripRequest> items,
  }) = _TripBatchMutation;
}

@freezed
abstract class JiraIssue with _$JiraIssue {
  const factory JiraIssue({
    required String key,
    required String summary,
    required String status,
    required String statusCategory,
    required String priority,
    required String issueType,
    required String projectKey,
    required String assignee,
    String? dueDate,
    String? updated,
    String? url,
  }) = _JiraIssue;
}

@freezed
abstract class JiraCreateResult with _$JiraCreateResult {
  const factory JiraCreateResult({
    required String key,
    required String summary,
    required String projectKey,
    required String issueType,
    required String assigneeEmail,
    required String url,
    required String message,
  }) = _JiraCreateResult;
}

@freezed
sealed class ChatResultEnvelope with _$ChatResultEnvelope {
  const ChatResultEnvelope._();

  const factory ChatResultEnvelope.leaveBalance(LeaveBalance data) =
      ChatLeaveBalanceResult;
  const factory ChatResultEnvelope.leaveList(List<LeaveRequest> data) =
      ChatLeaveListResult;
  const factory ChatResultEnvelope.tripList(List<TripRequest> data) =
      ChatTripListResult;
  const factory ChatResultEnvelope.pendingApprovals(PendingApprovals data) =
      ChatPendingApprovalsResult;
  const factory ChatResultEnvelope.jiraIssues(List<JiraIssue> data) =
      ChatJiraIssuesResult;
  const factory ChatResultEnvelope.leaveMutation({
    required ChatMutationType mutation,
    required LeaveRequest data,
  }) = ChatLeaveMutationResult;
  const factory ChatResultEnvelope.tripMutation({
    required ChatMutationType mutation,
    required TripRequest data,
  }) = ChatTripMutationResult;
  const factory ChatResultEnvelope.leaveBatchMutation({
    required ChatMutationType mutation,
    required LeaveBatchMutation data,
  }) = ChatLeaveBatchMutationResult;
  const factory ChatResultEnvelope.tripBatchMutation({
    required ChatMutationType mutation,
    required TripBatchMutation data,
  }) = ChatTripBatchMutationResult;
  const factory ChatResultEnvelope.jiraMutation({
    required ChatMutationType mutation,
    required JiraCreateResult data,
  }) = ChatJiraMutationResult;
  const factory ChatResultEnvelope.unknown(Object? raw) = ChatUnknownResult;

  bool get isMutation => switch (this) {
    ChatLeaveMutationResult() ||
    ChatTripMutationResult() ||
    ChatLeaveBatchMutationResult() ||
    ChatTripBatchMutationResult() ||
    ChatJiraMutationResult() => true,
    _ => false,
  };

  bool get isKnown => this is! ChatUnknownResult;

  Set<DataRefreshScope> get refreshScopes => switch (this) {
    ChatLeaveMutationResult() || ChatLeaveBatchMutationResult() => const {
      DataRefreshScope.leaves,
      DataRefreshScope.home,
    },
    ChatTripMutationResult() || ChatTripBatchMutationResult() => const {
      DataRefreshScope.trips,
      DataRefreshScope.home,
    },
    ChatJiraMutationResult() => const {DataRefreshScope.jira},
    _ => const {},
  };
}
