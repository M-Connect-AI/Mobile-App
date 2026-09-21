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
import '../../../../domain/model/auth_session.dart';
import '../../../../domain/model/chat_message.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/chat_rich_content.dart';
import '../../../../domain/model/chat_stream_event.dart';
import '../../../../domain/model/home_data.dart';
import '../../../../domain/model/outlook.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/service/device_calendar_service.dart';
import '../../../../domain/service/jira_task_rules.dart';
import '../../../../generated/l10n.dart';
import '../../../../route/go_router.dart';
import '../../jira/jira_pages.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_text_size_cubit.dart';
import 'jira_result_card.dart';

typedef ExternalUrlOpener = Future<bool> Function(Uri uri);

Future<bool> _openExternalUrl(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

double _chatBodyFontSize(BuildContext context) => context
    .select<ChatTextSizeCubit?, int>((cubit) => cubit?.state ?? ChatTextSizeCubit.defaultSize)
    .sp;

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, this.openExternalUrl = _openExternalUrl});

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
    final hasJiraResult = message.executedResult is ChatJiraIssuesResult;
    final hasBody =
        message.type == MessageType.audio ||
        (!hasJiraResult && (message.content?.trim().isNotEmpty ?? false));
    final hasAttachments =
        !isUser &&
        (message.confirmation != null ||
            (message.executedResult?.isKnown ?? false) ||
            message.blocks.isNotEmpty ||
            message.uiAction != null ||
            message.citations.isNotEmpty);
    return Semantics(
      label: isUser ? S.of(context).yourMessage : S.of(context).aiResponse,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (hasBody) _MessageBubbleBody(message: message, isUser: isUser),
            if (hasAttachments) ...[
              if (hasBody) 8.height.heightBox,
              _AssistantAttachments(message: message, openExternalUrl: openExternalUrl),
            ],
            if (isUser && message.status == MessageStatus.failed) ...[
              4.height.heightBox,
              IrhTextButton(
                label: S.of(context).retry,
                onPressed: () => context.read<ChatBloc>().add(RetryMessage(message.id)),
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
                    highlights: message.highlights,
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
    required this.highlights,
  });

  final String content;
  final Color color;
  final bool isProcessing;
  final List<ChatHighlight> highlights;

  @override
  Widget build(BuildContext context) {
    final textSize = _chatBodyFontSize(context);
    if (highlights.isNotEmpty) {
      return _HighlightedText(
        content: content,
        highlights: highlights,
        color: color,
        isProcessing: isProcessing,
      );
    }
    final paragraphs = content.split(RegExp(r'\n\s*\n'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < paragraphs.length; index++) ...[
          Text(
            isProcessing && index == paragraphs.length - 1
                ? '${paragraphs[index]} ▍'
                : paragraphs[index],
            style: AppTextStyle.r16.copyWith(color: color, fontSize: textSize, height: 1.4),
          ),
          if (index < paragraphs.length - 1) 16.height.heightBox,
        ],
      ],
    );
  }
}

class _AssistantAttachments extends StatelessWidget {
  const _AssistantAttachments({required this.message, required this.openExternalUrl});

  final ChatMessage message;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final selectedSize = context.select<ChatTextSizeCubit?, int>(
      (cubit) => cubit?.state ?? ChatTextSizeCubit.defaultSize,
    );
    final mediaQuery = MediaQuery.of(context);
    final resultTextScale =
        mediaQuery.textScaler.scale(1) * selectedSize / ChatTextSizeCubit.defaultSize;
    final isLeaveCreation = message.confirmation?.tool == ChatConfirmationTool.createLeave;
    final hasJiraResult = message.executedResult is ChatJiraIssuesResult;
    final isLeaveList =
        message.executedResult is ChatLeaveListResult ||
        message.uiAction?.key == ChatUiActionKey.leaveResults;
    final isLeaveBalance = message.executedResult is ChatLeaveBalanceResult;
    final availableWidth = isLeaveCreation || hasJiraResult
        ? MediaQuery.sizeOf(context).width - 32.width
        : MediaQuery.sizeOf(context).width * .84;
    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(resultTextScale)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: message.uiAction == null ? 0 : availableWidth,
          maxWidth: availableWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (message.confirmation != null)
              _ConfirmationCard(message: message)
            else if (message.executedResult?.isKnown ?? false)
              _ChatResultView(result: message.executedResult!, openExternalUrl: openExternalUrl),
            if (!hasJiraResult)
              for (final block in message.blocks) ...[
                8.height.heightBox,
                _RichBlockCard(
                  block: block,
                  openExternalUrl: openExternalUrl,
                  isLeaveList: isLeaveList,
                  isLeaveBalance: isLeaveBalance,
                ),
              ],
            if (message.uiAction case final action?
                when action.key != ChatUiActionKey.none &&
                    !(hasJiraResult && action.key == ChatUiActionKey.jiraIssue)) ...[
              8.height.heightBox,
              _UiActionButton(action: action, openExternalUrl: openExternalUrl),
            ],
            if (message.citations.isNotEmpty) ...[
              8.height.heightBox,
              _CitationList(citations: message.citations, openExternalUrl: openExternalUrl),
            ],
          ],
        ),
      ),
    );
  }
}

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({
    required this.content,
    required this.highlights,
    required this.color,
    required this.isProcessing,
  });

  final String content;
  final List<ChatHighlight> highlights;
  final Color color;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final textSize = _chatBodyFontSize(context);
    final spans = <InlineSpan>[];
    var offset = 0;
    for (final highlight in highlights) {
      if (highlight.start < offset || highlight.end > content.length) continue;
      if (highlight.start > offset) {
        spans.add(TextSpan(text: content.substring(offset, highlight.start)));
      }
      spans.add(
        TextSpan(
          text: content.substring(highlight.start, highlight.end),
          style: AppTextStyle.sm16.copyWith(
            color: _toneColor(context, highlight.tone),
            fontSize: textSize,
          ),
        ),
      );
      offset = highlight.end;
    }
    if (offset < content.length) {
      spans.add(TextSpan(text: content.substring(offset)));
    }
    if (isProcessing) spans.add(const TextSpan(text: ' ▍'));
    return Text.rich(
      TextSpan(children: spans),
      style: AppTextStyle.r16.copyWith(color: color, fontSize: textSize, height: 1.4),
    );
  }
}

class _ConfirmationCard extends StatelessWidget {
  const _ConfirmationCard({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final action = message.confirmation!;
    if (action.tool == ChatConfirmationTool.createLeave) {
      return _LeaveBalanceConfirmationCard(message: message);
    }
    return _StandardConfirmationCard(message: message);
  }
}

class _StandardConfirmationCard extends StatelessWidget {
  const _StandardConfirmationCard({required this.message});

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
          IrhText.semibold(strings.reviewRequestTitle, color: colors.textPrimary),
          if (fields.isNotEmpty) ...[
            12.height.heightBox,
            for (var index = 0; index < fields.length; index++) ...[
              _ConfirmationField(field: fields[index]),
              if (index < fields.length - 1) 8.height.heightBox,
            ],
          ],
          16.height.heightBox,
          switch (message.confirmationStatus) {
            ConfirmationStatus.pending when action.canExecute => _PendingConfirmationActions(
              messageId: message.id,
            ),
            ConfirmationStatus.pending => IrhText.small(
              strings.unsupportedChatAction,
              color: colors.textError,
            ),
            ConfirmationStatus.submitting => _ConfirmationProgress(
              label: strings.submittingRequest,
            ),
            ConfirmationStatus.success => _ConfirmationSuccess(result: message.executedResult),
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

class _LeaveBalanceConfirmationCard extends StatefulWidget {
  const _LeaveBalanceConfirmationCard({required this.message});

  final ChatMessage message;

  @override
  State<_LeaveBalanceConfirmationCard> createState() => _LeaveBalanceConfirmationCardState();
}

class _LeaveBalanceConfirmationCardState extends State<_LeaveBalanceConfirmationCard> {
  Future<AuthSession?>? _sessionFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sessionFuture ??= context.read<CredentialRepository>().read();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthSession?>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        final session = snapshot.data;
        if (session == null) {
          return _StandardConfirmationCard(message: widget.message);
        }
        final data = _LeaveBalanceSummaryData.from(
          action: widget.message.confirmation!,
          user: session.user,
        );
        if (data == null) {
          return _StandardConfirmationCard(message: widget.message);
        }
        return _LeaveBalanceSummaryCard(message: widget.message, data: data);
      },
    );
  }
}

class _LeaveBalanceSummaryCard extends StatelessWidget {
  const _LeaveBalanceSummaryCard({required this.message, required this.data});

  final ChatMessage message;
  final _LeaveBalanceSummaryData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final requestedDays = data.requestedDays;
    final hasRequestedDays = requestedDays != null;
    final displayedDays = data.displayedRemainingDays;
    final isInsufficient = data.isInsufficient;
    final accent = isInsufficient ? colors.textError : colors.iconBrand;
    final track = Color.lerp(
      colors.surfaceSecondary,
      isInsufficient ? colors.textError : colors.iconBrand,
      .16,
    )!;
    final initialDays = hasRequestedDays ? data.currentRemainingDays : displayedDays;
    return Container(
      key: Key('confirmation-card-${message.id}'),
      width: double.infinity,
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
        boxShadow: [
          BoxShadow(
            color: colors.borderPrimary.withValues(alpha: .24),
            blurRadius: 12.width,
            offset: Offset(0, 4.height),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: initialDays.toDouble(), end: displayedDays.toDouble()),
            duration: const Duration(milliseconds: 360),
            curve: Curves.easeOutCubic,
            builder: (context, animatedDays, child) {
              final progress = data.totalLeaveDays <= 0
                  ? 0.0
                  : (animatedDays / data.totalLeaveDays).clamp(0, 1).toDouble();
              final semanticLabel = hasRequestedDays
                  ? strings.leaveBalanceProjectedSemantics(
                      _formatLeaveDays(displayedDays),
                      _formatLeaveDays(data.totalLeaveDays),
                    )
                  : strings.leaveBalanceCurrentSemantics(
                      _formatLeaveDays(data.currentRemainingDays),
                      _formatLeaveDays(data.totalLeaveDays),
                    );
              return _LeaveBalanceHeader(
                animatedDays: animatedDays,
                progress: progress,
                semanticLabel: semanticLabel,
                accent: accent,
                track: track,
                leaveTypeLabel: _leaveTypeLabel(data.type, strings),
                totalLeaveDays: data.totalLeaveDays,
                hasRequestedDays: hasRequestedDays,
                targetRemainingDays: displayedDays,
              );
            },
          ),
          16.height.heightBox,
          Divider(height: 1.height, thickness: 1.height, color: colors.borderTertiary),
          4.height.heightBox,
          _LeaveBalanceInfoRow(
            label: strings.leaveBalanceCurrentLabel,
            value: strings.leaveBalanceDays(_formatLeaveDays(data.currentRemainingDays)),
          ),
          if (requestedDays != null) ...[
            _LeaveBalanceInfoRow(
              label: strings.leaveBalanceRequestedLabel,
              value: strings.leaveBalanceDays(_formatLeaveDays(requestedDays)),
            ),
            _LeaveBalanceInfoRow(
              label: strings.leaveBalanceProjectedLabel,
              value: strings.leaveBalanceDays(_formatLeaveDays(displayedDays)),
              valueColor: accent,
            ),
          ],
          8.height.heightBox,
          if (message.confirmationStatus == ConfirmationStatus.pending) ...[
            IrhText.small(
              isInsufficient
                  ? strings.leaveBalanceInsufficientHelper
                  : hasRequestedDays
                  ? strings.leaveBalanceEnoughHelper
                  : strings.leaveBalanceSelectDatesHelper,
              color: isInsufficient ? colors.textError : colors.textSecondary,
            ),
            16.height.heightBox,
            IrhButton(
              key: const Key('confirm-action'),
              label: strings.leaveBalanceContinue,
              height: 48.height,
              onPressed: !hasRequestedDays || isInsufficient || !message.confirmation!.canExecute
                  ? null
                  : () => context.read<ChatBloc>().add(
                      ConfirmationResponded(messageId: message.id, confirmed: true),
                    ),
            ),
            SizedBox(
              height: 44.height,
              child: IrhTextButton(
                key: const Key('edit-action'),
                label: isInsufficient
                    ? strings.leaveBalanceChooseDatesAgain
                    : strings.leaveBalanceChangeDates,
                onPressed: () =>
                    context.read<ChatBloc>().add(ConfirmationEditRequested(message.id)),
              ),
            ),
            SizedBox(
              height: 44.height,
              child: IrhTextButton(
                key: const Key('cancel-request-action'),
                label: strings.cancelRequest,
                onPressed: () => context.read<ChatBloc>().add(
                  ConfirmationResponded(messageId: message.id, confirmed: false),
                ),
              ),
            ),
          ] else ...[
            12.height.heightBox,
            switch (message.confirmationStatus) {
              ConfirmationStatus.submitting => _ConfirmationProgress(
                label: strings.submittingRequest,
              ),
              ConfirmationStatus.success => _ConfirmationSuccess(result: message.executedResult),
              ConfirmationStatus.failure => _ConfirmationFailure(
                messageId: message.id,
                error: message.confirmationError,
              ),
              ConfirmationStatus.cancelled => IrhText.smallMedium(
                strings.requestCancelled,
                color: colors.textSecondary,
              ),
              ConfirmationStatus.pending => const SizedBox.shrink(),
            },
          ],
        ],
      ),
    );
  }
}

class _LeaveBalanceHeader extends StatelessWidget {
  const _LeaveBalanceHeader({
    required this.animatedDays,
    required this.progress,
    required this.semanticLabel,
    required this.accent,
    required this.track,
    required this.leaveTypeLabel,
    required this.totalLeaveDays,
    required this.hasRequestedDays,
    required this.targetRemainingDays,
  });

  final double animatedDays;
  final double progress;
  final String semanticLabel;
  final Color accent;
  final Color track;
  final String leaveTypeLabel;
  final num totalLeaveDays;
  final bool hasRequestedDays;
  final num targetRemainingDays;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useColumn =
            constraints.maxWidth < 284.width || MediaQuery.textScalerOf(context).scale(1) > 1.3;
        final indicator = _LeaveBalanceIndicator(
          animatedDays: animatedDays,
          progress: progress,
          semanticLabel: semanticLabel,
          accent: accent,
          track: track,
        );
        final summary = _LeaveBalancePrimarySummary(
          leaveTypeLabel: leaveTypeLabel,
          totalLeaveDays: totalLeaveDays,
          hasRequestedDays: hasRequestedDays,
          targetRemainingDays: targetRemainingDays,
        );
        if (useColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [indicator, 12.height.heightBox, summary],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [indicator, 16.width.widthBox, summary.expanded()],
        );
      },
    );
  }
}

class _LeaveBalanceIndicator extends StatelessWidget {
  const _LeaveBalanceIndicator({
    required this.animatedDays,
    required this.progress,
    required this.semanticLabel,
    required this.accent,
    required this.track,
  });

  final double animatedDays;
  final double progress;
  final String semanticLabel;
  final Color accent;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 92.width,
          height: 92.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 92.width,
                height: 92.width,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8.width,
                  strokeCap: StrokeCap.round,
                  color: accent,
                  backgroundColor: track,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatLeaveDays(animatedDays),
                      style: AppTextStyle.b28.copyWith(color: accent),
                    ),
                    IrhText.small(
                      S.of(context).leaveBalanceDaysRemaining,
                      color: context.appColorScheme.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaveBalancePrimarySummary extends StatelessWidget {
  const _LeaveBalancePrimarySummary({
    required this.leaveTypeLabel,
    required this.totalLeaveDays,
    required this.hasRequestedDays,
    required this.targetRemainingDays,
  });

  final String leaveTypeLabel;
  final num totalLeaveDays;
  final bool hasRequestedDays;
  final num targetRemainingDays;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasRequestedDays
              ? strings.leaveBalanceProjectedTitle(_formatLeaveDays(targetRemainingDays))
              : strings.leaveBalanceCurrentTitle,
          style: AppTextStyle.sm20.copyWith(color: colors.textPrimary),
        ),
        4.height.heightBox,
        IrhText.small(
          hasRequestedDays
              ? strings.leaveBalanceAfterSubmission
              : strings.leaveBalanceCurrentAvailable(_formatLeaveDays(targetRemainingDays)),
          color: colors.textSecondary,
        ),
        8.height.heightBox,
        IrhText.small(
          strings.leaveBalanceTypeTotal(leaveTypeLabel, _formatLeaveDays(totalLeaveDays)),
          color: colors.textSecondary,
        ),
      ],
    );
  }
}

class _LeaveBalanceInfoRow extends StatelessWidget {
  const _LeaveBalanceInfoRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 44.height),
      child: Row(
        children: [
          IrhText.regular(label, color: colors.textSecondary).expanded(),
          12.width.widthBox,
          IrhText.medium(value, color: valueColor ?? colors.textPrimary),
        ],
      ),
    );
  }
}

class _LeaveBalanceSummaryData {
  const _LeaveBalanceSummaryData({
    required this.type,
    required this.totalLeaveDays,
    required this.currentRemainingDays,
    required this.requestedDays,
  });

  final String type;
  final num totalLeaveDays;
  final num currentRemainingDays;
  final num? requestedDays;

  num get projectedRemainingDays => currentRemainingDays - (requestedDays ?? 0);

  num get displayedRemainingDays => projectedRemainingDays < 0 ? 0 : projectedRemainingDays;

  bool get isInsufficient => requestedDays != null && projectedRemainingDays < 0;

  static _LeaveBalanceSummaryData? from({
    required ChatConfirmAction action,
    required AuthUser user,
  }) {
    final args = action.args;
    final type = args['type']?.toString().trim().toUpperCase() ?? '';
    final fallback = switch (type) {
      'ANNUAL' => (total: user.annualTotal as num, remaining: user.annualRemaining as num),
      'SICK' => (total: user.sickRemaining as num, remaining: user.sickRemaining as num),
      _ => null,
    };
    final total = _firstNum(args, const ['totalLeaveDays', 'totalDays', 'annualTotal']);
    final remaining = _firstNum(args, const [
      'remainingLeaveDays',
      'remainingDays',
      'annualRemaining',
    ]);
    final resolvedTotal = total ?? fallback?.total;
    final resolvedRemaining = remaining ?? fallback?.remaining;
    if (resolvedTotal == null ||
        resolvedRemaining == null ||
        resolvedTotal <= 0 ||
        resolvedRemaining < 0) {
      return null;
    }
    return _LeaveBalanceSummaryData(
      type: type,
      totalLeaveDays: resolvedTotal,
      currentRemainingDays: resolvedRemaining,
      requestedDays:
          _firstNum(args, const ['requestedLeaveDays', 'requestedDays', 'days']) ??
          _inclusiveDays(args['from'], args['to']),
    );
  }
}

num? _firstNum(Map<String, dynamic> args, List<String> keys) {
  for (final key in keys) {
    final value = args[key];
    final parsed = value is num
        ? value
        : value is String
        ? num.tryParse(value)
        : null;
    if (parsed != null && parsed >= 0) return parsed;
  }
  return null;
}

num? _inclusiveDays(Object? fromValue, Object? toValue) {
  final from = DateTime.tryParse(fromValue?.toString() ?? '');
  final to = DateTime.tryParse(toValue?.toString() ?? '');
  if (from == null || to == null || to.isBefore(from)) return null;
  return to.difference(from).inDays + 1;
}

String _leaveTypeLabel(String value, S strings) => switch (value) {
  'ANNUAL' => strings.leaveAnnualType,
  'SICK' => strings.leaveSickType,
  'UNPAID' => strings.leaveUnpaidType,
  _ => value,
};

String _formatLeaveDays(num value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return intl.NumberFormat('0.##', 'en_US').format(value);
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
    return Column(
      children: [
        Row(
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
              onPressed: () => context.read<ChatBloc>().add(ConfirmationEditRequested(messageId)),
            ).expanded(),
          ],
        ),
        SizedBox(
          height: 44.height,
          child: IrhTextButton(
            key: const Key('cancel-request-action'),
            label: strings.cancelRequest,
            onPressed: () => context.read<ChatBloc>().add(
              ConfirmationResponded(messageId: messageId, confirmed: false),
            ),
          ),
        ),
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
        Icon(CupertinoIcons.checkmark_circle_fill, size: 24.sp, color: colors.textSuccess),
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
          onPressed: () => context.read<ChatBloc>().add(ConfirmationRetryRequested(messageId)),
        ),
      ],
    );
  }
}

typedef _ConfirmationFieldData = ({String label, String value});

List<_ConfirmationFieldData> _confirmationFields(ChatConfirmAction action, S strings) {
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
    if (fromValue == null || fromValue.isEmpty || toValue == null || toValue.isEmpty) {
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
    case ChatConfirmationTool.createTrip:
      add(strings.tripDestination, 'destination');
      addPeriod();
      add(strings.tripPurpose, 'purpose');
    case ChatConfirmationTool.cancelLeave:
      break;
    case ChatConfirmationTool.approveLeaves:
    case ChatConfirmationTool.rejectLeaves:
    case ChatConfirmationTool.approveTrips:
    case ChatConfirmationTool.rejectTrips:
      break;
    case ChatConfirmationTool.createJiraTask:
      add(strings.jiraProject, 'projectKey');
      add(strings.jiraTaskSummary, 'summary');
      add(strings.jiraIssueTypeLabel, 'issueType');
      add(strings.jiraDueDateLabel, 'dueDate', format: formatDate);
    case ChatConfirmationTool.createOutlookEvent:
      add(strings.outlookSubject, 'subject');
      add(strings.outlookStart, 'start', format: formatDate);
      add(strings.outlookEnd, 'end', format: formatDate);
      add(strings.outlookLocation, 'location');
      final attendees = args['attendees'];
      if (attendees is List && attendees.isNotEmpty) {
        fields.add((label: strings.outlookAttendees, value: attendees.join(', ')));
      }
    case ChatConfirmationTool.replyOutlookMail:
      add(strings.outlookMessageId, 'messageId');
      add(strings.outlookReply, 'comment');
    case ChatConfirmationTool.unknown:
      break;
  }
  return fields;
}

String? _successDetails(ChatResultEnvelope? result, S strings) {
  return switch (result) {
    ChatLeaveMutationResult(:final data) => _requestStatus(data.status, strings),
    ChatTripMutationResult(:final data) => _requestStatus(data.status, strings),
    ChatLeaveBatchMutationResult(:final data) => strings.completedRequestCount(data.count),
    ChatTripBatchMutationResult(:final data) => strings.completedRequestCount(data.count),
    ChatJiraMutationResult(:final data) => strings.jiraCreatedResult(data.key),
    ChatOutlookEventMutationResult(:final data) => data.event.subject,
    ChatOutlookReplyMutationResult(:final data) => data.microsoftEmail,
    _ => null,
  };
}

ChatMutationType? _resultMutation(ChatResultEnvelope? result) => switch (result) {
  ChatLeaveMutationResult(:final mutation) => mutation,
  ChatTripMutationResult(:final mutation) => mutation,
  ChatLeaveBatchMutationResult(:final mutation) => mutation,
  ChatTripBatchMutationResult(:final mutation) => mutation,
  ChatJiraMutationResult(:final mutation) => mutation,
  ChatOutlookEventMutationResult(:final mutation) => mutation,
  ChatOutlookReplyMutationResult(:final mutation) => mutation,
  _ => null,
};

String _mutationSuccessLabel(ChatMutationType mutation, S strings) => switch (mutation) {
  ChatMutationType.createLeave => strings.createLeaveSuccess,
  ChatMutationType.updateLeave => strings.updateLeaveSuccess,
  ChatMutationType.cancelLeave => strings.cancelLeaveSuccess,
  ChatMutationType.createTrip => strings.createTripSuccess,
  ChatMutationType.approveLeaves => strings.approveLeavesSuccess,
  ChatMutationType.rejectLeaves => strings.rejectLeavesSuccess,
  ChatMutationType.approveTrips => strings.approveTripsSuccess,
  ChatMutationType.rejectTrips => strings.rejectTripsSuccess,
  ChatMutationType.createJiraTask => strings.createJiraTaskSuccess,
  ChatMutationType.createOutlookEvent => strings.createOutlookEventSuccess,
  ChatMutationType.replyOutlookMail => strings.replyOutlookMailSuccess,
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
      return JiraResultCard(
        data: data,
        onOpenTask: (issue) async {
          final uri = JiraTaskRules.issueUri(issue);
          if (uri != null && await openExternalUrl(uri)) return;
          if (context.mounted) {
            AppToast.failed(context, S.of(context).linkOpenFailed);
          }
        },
        onOpenOverview: data.issues.length > 1
            ? () => JiraTaskOverviewRoute(data).push(context)
            : null,
        onAddToCalendar: (issue) => JiraCalendarCoordinator.add(
          context,
          issue: issue,
          service: context.read<DeviceCalendarService>(),
        ),
        onAddAllToCalendar: (issues) async {
          final addedIssueKeys = <String>{};
          for (final issue in issues) {
            if (!context.mounted) return addedIssueKeys;
            final added = await JiraCalendarCoordinator.add(
              context,
              issue: issue,
              service: context.read<DeviceCalendarService>(),
            );
            if (added) addedIssueKeys.add(issue.key);
          }
          return addedIssueKeys;
        },
      );
    }
    if (result case ChatJiraMutationResult(:final mutation, :final data)) {
      return _JiraCreatedCard(mutation: mutation, data: data, openExternalUrl: openExternalUrl);
    }
    if (result case ChatOutlookEventMutationResult(:final data)) {
      return _OutlookEventResultCard(data: data, openExternalUrl: openExternalUrl);
    }
    if (result case ChatOutlookReplyMutationResult(:final data)) {
      return IrhText.smallMedium(
        S.of(context).outlookReplySentTo(data.microsoftEmail),
        color: context.appColorScheme.textSuccess,
      );
    }
    final label = switch (result) {
      ChatLeaveBalanceResult(:final data) => strings.chatLeaveBalanceResult(
        data.annualRemaining,
        data.annualTotal,
        data.sickRemaining,
      ),
      ChatLeaveListResult(:final data) => strings.chatLeaveListResult(data.length),
      ChatTripListResult(:final data) => strings.chatTripListResult(data.length),
      ChatPendingApprovalsResult(:final data) => strings.chatPendingResult(
        data.leaves.length,
        data.trips.length,
      ),
      ChatJiraIssuesResult() => '',
      ChatLeaveMutationResult(:final mutation) => _mutationSuccessLabel(mutation, strings),
      ChatTripMutationResult(:final mutation) => _mutationSuccessLabel(mutation, strings),
      ChatLeaveBatchMutationResult(:final mutation) => _mutationSuccessLabel(mutation, strings),
      ChatTripBatchMutationResult(:final mutation) => _mutationSuccessLabel(mutation, strings),
      ChatJiraMutationResult() => '',
      ChatOutlookEventMutationResult() => '',
      ChatOutlookReplyMutationResult() => '',
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

class _OutlookEventResultCard extends StatelessWidget {
  const _OutlookEventResultCard({required this.data, required this.openExternalUrl});

  final OutlookEventMutation data;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final event = data.event;
    final uri = _validatedHttpUri(event.webLink);
    return Container(
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IrhText.smallMedium(event.subject, color: colors.textPrimary),
          4.height.heightBox,
          IrhText.small('${event.start} → ${event.end}', color: colors.textSecondary),
          if (event.location != null) ...[
            4.height.heightBox,
            IrhText.small(event.location!, color: colors.textSecondary),
          ],
          if (uri != null) ...[
            8.height.heightBox,
            _ExternalLinkButton(
              label: S.of(context).outlookOpenEvent,
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
          IrhText.small(_mutationSuccessLabel(mutation, strings), color: colors.textSuccess),
          4.height.heightBox,
          IrhText.smallMedium(strings.jiraCreatedResult(data.key), color: colors.textPrimary),
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

class _RichBlockCard extends StatelessWidget {
  const _RichBlockCard({
    required this.block,
    required this.openExternalUrl,
    required this.isLeaveList,
    required this.isLeaveBalance,
  });

  final ChatRichBlock block;
  final ExternalUrlOpener openExternalUrl;
  final bool isLeaveList;
  final bool isLeaveBalance;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      key: Key('rich-block-${block.type.name}'),
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: switch (block.type) {
        ChatBlockType.kpis => _MetricItems(
          items: block.items,
          isLeaveList: isLeaveList,
          isLeaveBalance: isLeaveBalance,
        ),
        ChatBlockType.bars || ChatBlockType.donut => _ChartItems(block: block),
        ChatBlockType.progress => _ProgressBlock(block: block),
        ChatBlockType.list => _RichList(
          block: block,
          openExternalUrl: openExternalUrl,
          isLeaveList: isLeaveList,
        ),
        ChatBlockType.quote => _QuoteBlock(block: block),
      },
    );
  }
}

class _MetricItems extends StatelessWidget {
  const _MetricItems({
    required this.items,
    required this.isLeaveList,
    required this.isLeaveBalance,
  });

  final List<ChatBlockItem> items;
  final bool isLeaveList;
  final bool isLeaveBalance;

  @override
  Widget build(BuildContext context) {
    final showsLeaveBalance = isLeaveBalance || _isLeaveBalanceMetrics(items);
    if ((isLeaveList || showsLeaveBalance) && items.length == 3) {
      final colors = context.appColorScheme;
      final labelHeight = MediaQuery.textScalerOf(context).scale(16.sp) * 2;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0)
              Container(width: 1.width, height: 48.height, color: colors.borderSecondary),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showsLeaveBalance)
                  SizedBox(
                    height: labelHeight > 32.height ? labelHeight : 32.height,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        items[index].label ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.r12.copyWith(color: colors.textSecondary),
                      ),
                    ),
                  )
                else
                  IrhText.small(items[index].label ?? '', textAlign: TextAlign.center, maxLines: 2),
                4.height.heightBox,
                Text(
                  _displayValue(items[index].value),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.b20.copyWith(
                    color: index == (showsLeaveBalance ? 0 : 1)
                        ? colors.textBrand
                        : colors.textPrimary,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 4.width).expanded(),
          ],
        ],
      );
    }
    return Wrap(
      spacing: 16.width,
      runSpacing: 12.height,
      children: [
        for (final item in items)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IrhText.small(item.label ?? '', color: context.appColorScheme.textSecondary),
              4.height.heightBox,
              Text(
                _displayValue(item.value),
                style: AppTextStyle.b20.copyWith(color: _toneColor(context, item.tone)),
              ),
            ],
          ),
      ],
    );
  }
}

class _ChartItems extends StatelessWidget {
  const _ChartItems({required this.block});

  final ChatRichBlock block;

  @override
  Widget build(BuildContext context) {
    final maxValue = block.items
        .map((item) => item.value)
        .whereType<num>()
        .fold<num>(0, (current, value) => value > current ? value : current);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.smallMedium(block.title ?? '', color: context.appColorScheme.textPrimary),
        12.height.heightBox,
        for (var index = 0; index < block.items.length; index++) ...[
          _ChartRow(item: block.items[index], maxValue: maxValue),
          if (index < block.items.length - 1) 8.height.heightBox,
        ],
      ],
    );
  }
}

class _ChartRow extends StatelessWidget {
  const _ChartRow({required this.item, required this.maxValue});

  final ChatBlockItem item;
  final num maxValue;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final value = item.value is num ? item.value! as num : 0;
    final progress = maxValue <= 0 ? 0.0 : (value / maxValue).clamp(0, 1).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IrhText.small(item.label ?? '', color: colors.textSecondary).expanded(),
            8.width.widthBox,
            IrhText.smallMedium(_displayValue(value), color: colors.textPrimary),
          ],
        ),
        4.height.heightBox,
        LinearProgressIndicator(
          value: progress,
          minHeight: 4.height,
          color: colors.iconBrand,
          backgroundColor: colors.surfaceTemary,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

class _ProgressBlock extends StatelessWidget {
  const _ProgressBlock({required this.block});

  final ChatRichBlock block;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final value = block.value ?? 0;
    final max = block.max ?? 1;
    final progress = (value / max).clamp(0, 1).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IrhText.smallMedium(block.title ?? '', color: colors.textPrimary).expanded(),
            8.width.widthBox,
            IrhText.small(
              '${_displayValue(value)}/${_displayValue(max)}${block.suffix ?? ''}',
              color: colors.textSecondary,
            ),
          ],
        ),
        8.height.heightBox,
        LinearProgressIndicator(
          value: progress,
          minHeight: 8.height,
          color: colors.iconBrand,
          backgroundColor: colors.surfaceTemary,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }
}

class _RichList extends StatelessWidget {
  const _RichList({required this.block, required this.openExternalUrl, required this.isLeaveList});

  final ChatRichBlock block;
  final ExternalUrlOpener openExternalUrl;
  final bool isLeaveList;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (block.title != null) ...[
          isLeaveList
              ? IrhText.semibold(
                  '${block.title!} (${block.items.length})',
                  color: colors.textPrimary,
                  maxLines: 1,
                )
              : IrhText.smallMedium(block.title!, color: colors.textPrimary),
          8.height.heightBox,
        ],
        for (var index = 0; index < block.items.length; index++) ...[
          _RichListItem(
            item: block.items[index],
            openExternalUrl: openExternalUrl,
            isLeaveList: isLeaveList,
          ),
          if (index < block.items.length - 1)
            isLeaveList
                ? Container(
                    height: 1.height,
                    color: colors.borderSecondary,
                  ).paddingSymmetric(vertical: 12.height)
                : 8.height.heightBox,
        ],
      ],
    );
  }
}

class _RichListItem extends StatelessWidget {
  const _RichListItem({
    required this.item,
    required this.openExternalUrl,
    required this.isLeaveList,
  });

  final ChatBlockItem item;
  final ExternalUrlOpener openExternalUrl;
  final bool isLeaveList;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final uri = _validatedHttpUri(item.url);
    if (isLeaveList) {
      final isPending =
          item.tone == ChatTone.warn ||
          (item.badge?.isNotEmpty ?? false) &&
              S.of(context).statusPending.toLowerCase().contains(item.badge!.toLowerCase());
      final badgeColor = isPending ? colors.textBrand : _toneColor(context, item.tone);
      final subtitleHasDate = item.subtitle != null && _leaveDatePattern.hasMatch(item.subtitle!);
      final kickerHasDate = item.kicker != null && _leaveDatePattern.hasMatch(item.kicker!);
      var dateLine = kickerHasDate && !subtitleHasDate ? item.kicker : item.subtitle;
      var reasonLine = kickerHasDate && !subtitleHasDate ? item.subtitle : item.kicker;
      if (reasonLine == null && dateLine != null && _leaveDatePattern.hasMatch(dateLine)) {
        final parts = dateLine.split(' · ');
        if (parts.length > 2) {
          dateLine = parts.take(2).join(' · ');
          reasonLine = parts.skip(2).join(' · ');
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IrhText.smallMedium(
                item.title ?? '',
                color: colors.textPrimary,
                maxLines: 2,
              ).expanded(),
              if (item.badge != null) ...[
                8.width.widthBox,
                Container(
                  constraints: BoxConstraints(maxWidth: 104.width, minHeight: 24.height),
                  decoration: BoxDecoration(
                    color: Color.lerp(colors.surfaceSecondary, badgeColor, .08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IrhText.small(
                    item.badge!,
                    color: badgeColor,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 8.width, vertical: 4.height),
                ),
              ],
            ],
          ),
          if (dateLine != null) ...[
            4.height.heightBox,
            IrhText.small(
              _formatLeaveDateRange(dateLine),
              color: Color.lerp(colors.textSecondary, colors.textPrimary, .4),
              maxLines: 2,
            ),
          ],
          if (reasonLine != null) ...[
            4.height.heightBox,
            IrhText.small(reasonLine, color: colors.textPrimary, maxLines: 2),
          ],
          if (uri != null)
            _ExternalLinkButton(
              label: item.title ?? uri.host,
              uri: uri,
              openExternalUrl: openExternalUrl,
            ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (item.kicker != null) IrhText.small(item.kicker!, color: colors.textBrand),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IrhText.smallMedium(item.title ?? '', color: colors.textPrimary).expanded(),
            if (item.badge != null) ...[
              8.width.widthBox,
              IrhText.small(item.badge!, color: _toneColor(context, item.tone)),
            ],
          ],
        ),
        if (item.subtitle != null) ...[
          4.height.heightBox,
          IrhText.small(item.subtitle!, color: colors.textSecondary),
        ],
        if (uri != null)
          _ExternalLinkButton(
            label: item.title ?? uri.host,
            uri: uri,
            openExternalUrl: openExternalUrl,
          ),
      ],
    );
  }
}

class _QuoteBlock extends StatelessWidget {
  const _QuoteBlock({required this.block});

  final ChatRichBlock block;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.smallMedium(block.title ?? '', color: colors.textPrimary),
        8.height.heightBox,
        Text(
          block.text ?? '',
          style: AppTextStyle.r14.copyWith(color: colors.textSecondary, height: 1.4),
        ),
        if (block.source != null) ...[
          8.height.heightBox,
          IrhText.small(block.source!, color: colors.textTertiary),
        ],
      ],
    );
  }
}

class _UiActionButton extends StatelessWidget {
  const _UiActionButton({required this.action, required this.openExternalUrl});

  final ChatUiAction action;
  final ExternalUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    return IrhButton(
      key: Key('chat-ui-action-${action.key.name}'),
      label: action.label,
      height: 44.height,
      secondary: true,
      onPressed: () => _openAction(context),
    );
  }

  Future<void> _openAction(BuildContext context) async {
    switch (action.key) {
      case ChatUiActionKey.leaveResults:
        await const LeaveListRoute().push(context);
      case ChatUiActionKey.tripResults:
        await const TripListRoute().push(context);
      case ChatUiActionKey.jiraIssue:
        final uri = _validatedHttpUri(action.url);
        if (uri != null && await openExternalUrl(uri)) return;
        if (context.mounted) {
          AppToast.failed(context, S.of(context).linkOpenFailed);
        }
      case ChatUiActionKey.outlookCalendar:
        final uri = _validatedHttpUri(action.url);
        if (uri != null) {
          if (await openExternalUrl(uri)) return;
          if (context.mounted) {
            AppToast.failed(context, S.of(context).linkOpenFailed);
          }
          return;
        }
        await const OutlookCalendarRoute().push(context);
      case ChatUiActionKey.outlookMail:
        await const OutlookMailListRoute().push(context);
      case ChatUiActionKey.outlookConnect:
        await const OutlookConnectionRoute().push(context);
      case ChatUiActionKey.none:
      case ChatUiActionKey.unknown:
        AppToast.failed(context, S.of(context).unsupportedChatAction);
    }
  }
}

String _displayValue(Object? value) =>
    value is num ? intl.NumberFormat.decimalPattern().format(value) : value?.toString() ?? '';

bool _isLeaveBalanceMetrics(List<ChatBlockItem> items) {
  if (items.length != 3) return false;
  final labels = items.map((item) => item.label?.trim().toLowerCase() ?? '').toList();
  return labels[0].startsWith('phép năm còn') &&
      labels[1].startsWith('phép năm tổng') &&
      labels[2].startsWith('khung phép ốm');
}

final RegExp _leaveDatePattern = RegExp(r'\b\d{2}/\d{2}/\d{4}\b');
final RegExp _leaveDateRangePattern = RegExp(
  r'(\d{2}/\d{2}/\d{4})\s*(?:→|–|-)\s*(\d{2}/\d{2}/\d{4})',
);

String _formatLeaveDateRange(String value) => value.replaceAllMapped(
  _leaveDateRangePattern,
  (match) =>
      match.group(1) == match.group(2) ? match.group(1)! : '${match.group(1)} → ${match.group(2)}',
);

Color _toneColor(BuildContext context, ChatTone? tone) {
  final colors = context.appColorScheme;
  return switch (tone) {
    ChatTone.ok => colors.textSuccess,
    ChatTone.warn => colors.textBrand,
    ChatTone.bad => colors.textError,
    ChatTone.neutral || null => colors.textPrimary,
  };
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
    final textSize = _chatBodyFontSize(context);
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
            style: AppTextStyle.r16.copyWith(color: color, fontSize: textSize, height: 1.35),
          ),
        ],
      ],
    );
  }
}
