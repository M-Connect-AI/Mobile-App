import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/components/app_toast.dart';
import '../../../../common/components/app_text_style.dart';
import '../../../../common/components/irh_button.dart';
import '../../../../common/components/irh_text.dart';
import '../../../../common/extensions/responsive_extension.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../domain/model/chat_message.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/chat_stream_event.dart';
import '../../../../domain/model/home_data.dart';
import '../../../../generated/l10n.dart';
import '../bloc/chat_bloc.dart';

typedef ExternalUrlOpener = Future<bool> Function(Uri uri);

Future<bool> _openExternalUrl(Uri uri) =>
    launchUrl(uri, mode: LaunchMode.externalApplication);

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    this.openExternalUrl = _openExternalUrl,
  });

  final ChatMessage message;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    if (message.sender == MessageSender.system) {
      return Center(
        child: IrhText.small(
          message.content ?? '',
          color: context.appColorScheme.textSecondary,
        ).paddingSymmetric(vertical: 8.height),
      );
    }
    final isUser = message.sender == MessageSender.user;
    final hasBody =
        message.type == MessageType.audio ||
        (message.content?.trim().isNotEmpty ?? false);
    final hasAttachments =
        !isUser &&
        (message.confirmation != null ||
            (message.executedResult?.isKnown ?? false) ||
            message.citations.isNotEmpty);
    return Semantics(
      label: isUser ? S.of(context).yourMessage : S.of(context).aiResponse,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (hasBody) _MessageBubbleBody(message: message, isUser: isUser),
            if (hasAttachments) ...[
              if (hasBody) 8.height.heightBox,
              _AssistantAttachments(
                message: message,
                openExternalUrl: openExternalUrl,
              ),
            ],
            if (isUser && message.status == MessageStatus.failed) ...[
              4.height.heightBox,
              IrhTextButton(
                label: S.of(context).retry,
                onPressed: () =>
                    context.read<ChatBloc>().add(RetryMessage(message.id)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MessageBubbleBody extends StatelessWidget {
  const _MessageBubbleBody({required this.message, required this.isUser});

  final ChatMessage message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final foreground = isUser ? colors.userText : colors.textPrimary;
    final bubbleColor = isUser
        ? colors.userBubble
        : Color.lerp(colors.surfaceSecondary, colors.iconBrand, .06)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: isUser ? TextDirection.rtl : TextDirection.ltr,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * (isUser ? .78 : .84),
          ),
          child: Container(
            key: Key('${isUser ? 'user' : 'ai'}-bubble-${message.id}'),
            padding: EdgeInsets.all(16.width),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16),
              border: isUser ? null : Border.all(color: colors.borderTertiary),
            ),
            child: message.type == MessageType.audio
                ? _AudioContent(message: message, color: foreground)
                : _TextMessageContent(
                    content: message.content ?? '',
                    color: foreground,
                    isProcessing: message.status == MessageStatus.processing,
                  ),
          ),
        ).flexible(),
      ],
    );
  }
}

class _TextMessageContent extends StatelessWidget {
  const _TextMessageContent({
    required this.content,
    required this.color,
    required this.isProcessing,
  });

  final String content;
  final Color color;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final paragraphs = content.split(RegExp(r'\n\s*\n'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < paragraphs.length; index++) ...[
          Text(
            isProcessing && index == paragraphs.length - 1
                ? '${paragraphs[index]} ▍'
                : paragraphs[index],
            style: AppTextStyle.r16.copyWith(color: color, height: 1.4),
          ),
          if (index < paragraphs.length - 1) 16.height.heightBox,
        ],
      ],
    );
  }
}

class _AssistantAttachments extends StatelessWidget {
  const _AssistantAttachments({
    required this.message,
    required this.openExternalUrl,
  });

  final ChatMessage message;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .84,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message.confirmation != null)
            _ConfirmationCard(message: message)
          else if (message.executedResult?.isKnown ?? false)
            _ChatResultView(
              result: message.executedResult!,
              openExternalUrl: openExternalUrl,
            ),
          if (message.citations.isNotEmpty) ...[
            8.height.heightBox,
            _CitationList(
              citations: message.citations,
              openExternalUrl: openExternalUrl,
            ),
          ],
        ],
      ),
    );
  }
}

class _ConfirmationCard extends StatelessWidget {
  const _ConfirmationCard({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final action = message.confirmation!;
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final fields = _confirmationFields(action, strings);
    return Container(
      key: Key('confirmation-card-${message.id}'),
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IrhText.semibold(
            strings.reviewRequestTitle,
            color: colors.textPrimary,
          ),
          if (fields.isNotEmpty) ...[
            12.height.heightBox,
            for (var index = 0; index < fields.length; index++) ...[
              _ConfirmationField(field: fields[index]),
              if (index < fields.length - 1) 8.height.heightBox,
            ],
          ],
          16.height.heightBox,
          switch (message.confirmationStatus) {
            ConfirmationStatus.pending when action.canExecute =>
              _PendingConfirmationActions(messageId: message.id),
            ConfirmationStatus.pending => IrhText.small(
              strings.unsupportedChatAction,
              color: colors.textError,
            ),
            ConfirmationStatus.submitting => _ConfirmationProgress(
              label: strings.submittingRequest,
            ),
            ConfirmationStatus.success => _ConfirmationSuccess(
              result: message.executedResult,
            ),
            ConfirmationStatus.failure => _ConfirmationFailure(
              messageId: message.id,
              error: message.confirmationError,
            ),
            ConfirmationStatus.cancelled => IrhText.smallMedium(
              strings.requestCancelled,
              color: colors.textSecondary,
            ),
          },
        ],
      ),
    );
  }
}

class _ConfirmationField extends StatelessWidget {
  const _ConfirmationField({required this.field});

  final _ConfirmationFieldData field;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88.width,
          child: IrhText.small(field.label, color: colors.textSecondary),
        ),
        8.width.widthBox,
        IrhText.smallMedium(field.value, color: colors.textPrimary).expanded(),
      ],
    );
  }
}

class _PendingConfirmationActions extends StatelessWidget {
  const _PendingConfirmationActions({required this.messageId});

  final String messageId;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Row(
      children: [
        IrhButton(
          key: const Key('confirm-action'),
          label: strings.confirmSubmitButton,
          height: 44.height,
          onPressed: () => context.read<ChatBloc>().add(
            ConfirmationResponded(messageId: messageId, confirmed: true),
          ),
        ).expanded(),
        8.width.widthBox,
        IrhButton(
          key: const Key('edit-action'),
          label: strings.editButton,
          height: 44.height,
          secondary: true,
          onPressed: () => context.read<ChatBloc>().add(
            ConfirmationEditRequested(messageId),
          ),
        ).expanded(),
      ],
    );
  }
}

class _ConfirmationProgress extends StatelessWidget {
  const _ConfirmationProgress({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoActivityIndicator(color: context.appColorScheme.iconBrand),
        8.width.widthBox,
        IrhText.smallMedium(label).expanded(),
      ],
    );
  }
}

class _ConfirmationSuccess extends StatelessWidget {
  const _ConfirmationSuccess({required this.result});

  final ChatResultEnvelope? result;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final details = _successDetails(result, strings);
    final mutation = _resultMutation(result);
    final successLabel = mutation == null
        ? strings.requestSubmitted
        : _mutationSuccessLabel(mutation, strings);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.checkmark_circle_fill,
          size: 24.sp,
          color: colors.textSuccess,
        ),
        8.width.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IrhText.smallMedium(successLabel, color: colors.textSuccess),
            if (details != null) ...[
              4.height.heightBox,
              IrhText.small(details, color: colors.textSecondary),
            ],
          ],
        ).expanded(),
      ],
    );
  }
}

class _ConfirmationFailure extends StatelessWidget {
  const _ConfirmationFailure({required this.messageId, required this.error});

  final String messageId;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.small(
          error?.trim().isNotEmpty == true ? error! : strings.requestFailed,
          color: colors.textError,
        ),
        8.height.heightBox,
        IrhButton(
          key: const Key('retry-confirmation'),
          label: strings.retry,
          height: 44.height,
          secondary: true,
          onPressed: () => context.read<ChatBloc>().add(
            ConfirmationRetryRequested(messageId),
          ),
        ),
      ],
    );
  }
}

typedef _ConfirmationFieldData = ({String label, String value});

List<_ConfirmationFieldData> _confirmationFields(
  ChatConfirmAction action,
  S strings,
) {
  final args = action.args;
  final fields = <_ConfirmationFieldData>[];
  void add(String label, String key, {String Function(String)? format}) {
    final value = args[key]?.toString().trim();
    if (value == null || value.isEmpty) return;
    fields.add((label: label, value: format?.call(value) ?? value));
  }

  String formatDate(String value) {
    final date = DateTime.tryParse(value);
    return date == null ? value : intl.DateFormat('dd/MM/yyyy').format(date);
  }

  String formatLeaveType(String value) => switch (value.toUpperCase()) {
    'ANNUAL' => strings.leaveAnnualType,
    'SICK' => strings.leaveSickType,
    'UNPAID' => strings.leaveUnpaidType,
    _ => value,
  };

  void addPeriod() {
    final fromValue = args['from']?.toString().trim();
    final toValue = args['to']?.toString().trim();
    if (fromValue == null ||
        fromValue.isEmpty ||
        toValue == null ||
        toValue.isEmpty) {
      add(strings.requestFrom, 'from', format: formatDate);
      add(strings.requestTo, 'to', format: formatDate);
      return;
    }
    final formattedFrom = formatDate(fromValue);
    final formattedTo = formatDate(toValue);
    fields.add((
      label: strings.requestPeriod,
      value: formattedFrom == formattedTo
          ? formattedFrom
          : strings.tripDateRange(formattedFrom, formattedTo),
    ));
    final from = DateTime.tryParse(fromValue);
    final to = DateTime.tryParse(toValue);
    if (from != null && to != null && !to.isBefore(from)) {
      fields.add((
        label: strings.leaveDays,
        value: strings.leaveDayCount(to.difference(from).inDays + 1),
      ));
    }
  }

  switch (action.tool) {
    case ChatConfirmationTool.createLeave:
    case ChatConfirmationTool.updateLeave:
      add(strings.leaveType, 'type', format: formatLeaveType);
      addPeriod();
      add(strings.leaveReason, 'reason');
      add(strings.requestCode, 'id');
    case ChatConfirmationTool.createTrip:
      add(strings.tripDestination, 'destination');
      addPeriod();
      add(strings.tripPurpose, 'purpose');
    case ChatConfirmationTool.cancelLeave:
      add(strings.requestCode, 'id');
    case ChatConfirmationTool.approveLeaves:
    case ChatConfirmationTool.rejectLeaves:
    case ChatConfirmationTool.approveTrips:
    case ChatConfirmationTool.rejectTrips:
      final ids = args['ids'];
      if (ids is List && ids.isNotEmpty) {
        fields.add((label: strings.requestCode, value: ids.join(', ')));
      }
    case ChatConfirmationTool.createJiraTask:
      add(strings.jiraProject, 'projectKey');
      add(strings.jiraTaskSummary, 'summary');
      add(strings.jiraIssueTypeLabel, 'issueType');
      add(strings.jiraDueDateLabel, 'dueDate', format: formatDate);
    case ChatConfirmationTool.unknown:
      break;
  }
  return fields;
}

String? _successDetails(ChatResultEnvelope? result, S strings) {
  return switch (result) {
    ChatLeaveMutationResult(:final data) =>
      '${strings.requestCode}: ${data.id} · ${_requestStatus(data.status, strings)}',
    ChatTripMutationResult(:final data) =>
      '${strings.requestCode}: ${data.id} · ${_requestStatus(data.status, strings)}',
    ChatLeaveBatchMutationResult(:final data) => strings.completedRequestCount(
      data.count,
    ),
    ChatTripBatchMutationResult(:final data) => strings.completedRequestCount(
      data.count,
    ),
    ChatJiraMutationResult(:final data) => strings.jiraCreatedResult(data.key),
    _ => null,
  };
}

ChatMutationType? _resultMutation(ChatResultEnvelope? result) =>
    switch (result) {
      ChatLeaveMutationResult(:final mutation) => mutation,
      ChatTripMutationResult(:final mutation) => mutation,
      ChatLeaveBatchMutationResult(:final mutation) => mutation,
      ChatTripBatchMutationResult(:final mutation) => mutation,
      ChatJiraMutationResult(:final mutation) => mutation,
      _ => null,
    };

String _mutationSuccessLabel(ChatMutationType mutation, S strings) =>
    switch (mutation) {
      ChatMutationType.createLeave => strings.createLeaveSuccess,
      ChatMutationType.updateLeave => strings.updateLeaveSuccess,
      ChatMutationType.cancelLeave => strings.cancelLeaveSuccess,
      ChatMutationType.createTrip => strings.createTripSuccess,
      ChatMutationType.approveLeaves => strings.approveLeavesSuccess,
      ChatMutationType.rejectLeaves => strings.rejectLeavesSuccess,
      ChatMutationType.approveTrips => strings.approveTripsSuccess,
      ChatMutationType.rejectTrips => strings.rejectTripsSuccess,
      ChatMutationType.createJiraTask => strings.createJiraTaskSuccess,
    };

String _requestStatus(RequestStatus status, S strings) => switch (status) {
  RequestStatus.pending => strings.statusPending,
  RequestStatus.approved => strings.statusApproved,
  RequestStatus.rejected => strings.statusRejected,
  RequestStatus.cancelled => strings.statusCancelled,
};

class _ChatResultView extends StatelessWidget {
  const _ChatResultView({required this.result, required this.openExternalUrl});

  final ChatResultEnvelope result;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (result case ChatJiraIssuesResult(:final data)) {
      return _JiraIssueListView(data: data, openExternalUrl: openExternalUrl);
    }
    if (result case ChatJiraMutationResult(:final mutation, :final data)) {
      return _JiraCreatedCard(
        mutation: mutation,
        data: data,
        openExternalUrl: openExternalUrl,
      );
    }
    final label = switch (result) {
      ChatLeaveBalanceResult(:final data) => strings.chatLeaveBalanceResult(
        data.annualRemaining,
        data.annualTotal,
        data.sickRemaining,
      ),
      ChatLeaveListResult(:final data) => strings.chatLeaveListResult(
        data.length,
      ),
      ChatTripListResult(:final data) => strings.chatTripListResult(
        data.length,
      ),
      ChatPendingApprovalsResult(:final data) => strings.chatPendingResult(
        data.leaves.length,
        data.trips.length,
      ),
      ChatJiraIssuesResult() => '',
      ChatLeaveMutationResult(:final mutation) => _mutationSuccessLabel(
        mutation,
        strings,
      ),
      ChatTripMutationResult(:final mutation) => _mutationSuccessLabel(
        mutation,
        strings,
      ),
      ChatLeaveBatchMutationResult(:final mutation) => _mutationSuccessLabel(
        mutation,
        strings,
      ),
      ChatTripBatchMutationResult(:final mutation) => _mutationSuccessLabel(
        mutation,
        strings,
      ),
      ChatJiraMutationResult() => '',
      ChatUnknownResult() => '',
    };
    return Text(
      label,
      style: AppTextStyle.sm12.copyWith(
        color: result.isMutation
            ? context.appColorScheme.textSuccess
            : context.appColorScheme.textSecondary,
      ),
    );
  }
}

class _JiraIssueListView extends StatelessWidget {
  const _JiraIssueListView({required this.data, required this.openExternalUrl});

  final JiraIssueList data;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    if (data.issues.isEmpty) {
      return IrhText.small(
        strings.jiraEmptyResult,
        color: colors.textSecondary,
      );
    }
    final visibleIssues = data.issues.take(5).toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.small(
          strings.jiraStatsResult(
            data.stats.total,
            data.stats.toDo,
            data.stats.inProgress,
            data.stats.done,
          ),
          color: colors.textSecondary,
        ),
        8.height.heightBox,
        for (var index = 0; index < visibleIssues.length; index++) ...[
          _JiraIssueCard(
            issue: visibleIssues[index],
            openExternalUrl: openExternalUrl,
          ),
          if (index < visibleIssues.length - 1) 8.height.heightBox,
        ],
        if (data.issues.length > visibleIssues.length) ...[
          8.height.heightBox,
          IrhText.small(
            strings.jiraMoreIssues(data.issues.length - visibleIssues.length),
            color: colors.textSecondary,
          ),
        ],
        if (data.mayBeTruncated) ...[
          8.height.heightBox,
          IrhText.small(
            strings.jiraPossiblyTruncated,
            color: colors.textSecondary,
          ),
        ],
      ],
    );
  }
}

class _JiraIssueCard extends StatelessWidget {
  const _JiraIssueCard({required this.issue, required this.openExternalUrl});

  final JiraIssue issue;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final uri = _validatedHttpUri(issue.url);
    return Container(
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IrhText.small(issue.key, color: colors.textBrand),
          4.height.heightBox,
          IrhText.smallMedium(issue.summary, color: colors.textPrimary),
          4.height.heightBox,
          IrhText.small(
            S.of(context).jiraIssueMeta(issue.status, issue.priority),
            color: colors.textSecondary,
          ),
          if (issue.dueDate != null) ...[
            4.height.heightBox,
            IrhText.small(
              S.of(context).jiraDueDate(issue.dueDate!),
              color: colors.textSecondary,
            ),
          ],
          if (uri != null) ...[
            4.height.heightBox,
            _ExternalLinkButton(
              key: Key('jira-issue-${issue.key}'),
              label: S.of(context).jiraOpenIssue,
              uri: uri,
              openExternalUrl: openExternalUrl,
            ),
          ],
        ],
      ),
    );
  }
}

class _JiraCreatedCard extends StatelessWidget {
  const _JiraCreatedCard({
    required this.mutation,
    required this.data,
    required this.openExternalUrl,
  });

  final ChatMutationType mutation;
  final JiraCreateResult data;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final uri = _validatedHttpUri(data.url);
    return Container(
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IrhText.small(
            _mutationSuccessLabel(mutation, strings),
            color: colors.textSuccess,
          ),
          4.height.heightBox,
          IrhText.smallMedium(
            strings.jiraCreatedResult(data.key),
            color: colors.textPrimary,
          ),
          4.height.heightBox,
          IrhText.small(data.summary, color: colors.textPrimary),
          4.height.heightBox,
          IrhText.small(
            strings.jiraCreatedMeta(data.issueType, data.assigneeEmail),
            color: colors.textSecondary,
          ),
          if (uri != null) ...[
            4.height.heightBox,
            _ExternalLinkButton(
              key: Key('jira-created-${data.key}'),
              label: strings.jiraOpenIssue,
              uri: uri,
              openExternalUrl: openExternalUrl,
            ),
          ],
        ],
      ),
    );
  }
}

class _CitationList extends StatelessWidget {
  const _CitationList({required this.citations, required this.openExternalUrl});

  final List<String> citations;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.width,
      runSpacing: 8.height,
      children: [
        for (var index = 0; index < citations.length; index++)
          if (_validatedHttpUri(citations[index]) case final uri?)
            _ExternalLinkButton(
              key: Key('citation-link-$index'),
              label: citations[index],
              uri: uri,
              openExternalUrl: openExternalUrl,
            )
          else
            Chip(
              key: Key('policy-citation-$index'),
              label: IrhText.small(citations[index]),
              backgroundColor: context.appColorScheme.surfaceSecondary,
            ),
      ],
    );
  }
}

class _ExternalLinkButton extends StatelessWidget {
  const _ExternalLinkButton({
    super.key,
    required this.label,
    required this.uri,
    required this.openExternalUrl,
  });

  final String label;
  final Uri uri;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    return IrhTextButton(
      label: label,
      onPressed: () async {
        try {
          final opened = await openExternalUrl(uri);
          if (opened || !context.mounted) return;
        } on Object {
          if (!context.mounted) return;
        }
        AppToast.failed(context, S.of(context).linkOpenFailed);
      },
    );
  }
}

Uri? _validatedHttpUri(String? value) {
  final uri = Uri.tryParse(value?.trim() ?? '');
  if (uri == null ||
      (uri.scheme != 'http' && uri.scheme != 'https') ||
      uri.host.isEmpty ||
      uri.userInfo.isNotEmpty) {
    return null;
  }
  return uri;
}

class _AudioContent extends StatelessWidget {
  const _AudioContent({required this.message, required this.color});
  final ChatMessage message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final seconds = message.duration?.inSeconds ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic_rounded, color: color, size: 23),
            const SizedBox(width: 6),
            ...List.generate(9, (index) {
              final height = 7.0 + ((index * 7) % 15);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                width: 2.5,
                height: height,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .72),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
            const SizedBox(width: 9),
            Text(
              '0:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(color: color, fontSize: 13),
            ),
          ],
        ),
        if (message.content?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          Text(
            message.content!,
            style: TextStyle(color: color, fontSize: 14, height: 1.35),
          ),
        ],
      ],
    );
  }
}
