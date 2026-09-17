import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../common/components/app_text_style.dart';
import '../../../../../common/components/irh_button.dart';
import '../../../../../common/components/irh_text.dart';
import '../../../../../common/extensions/responsive_extension.dart';
import '../../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../../domain/model/chat_result.dart';
import '../../../../../domain/service/jira_task_rules.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

String jiraStatusLabel(BuildContext context, JiraIssue issue) {
  return switch (JiraTaskRules.workflowGroup(issue)) {
    JiraWorkflowGroup.todo => S.of(context).jiraStatusTodo,
    JiraWorkflowGroup.inProgress => S.of(context).jiraStatusInProgress,
    JiraWorkflowGroup.done => S.of(context).jiraStatusDone,
    JiraWorkflowGroup.unknown =>
      issue.status.trim().isEmpty
          ? S.of(context).jiraStatusUnknown
          : issue.status.trim(),
  };
}

String jiraPriorityLabel(BuildContext context, JiraIssue issue) {
  final strings = S.of(context);
  return switch (JiraTaskRules.priorityLevel(issue.priority)) {
    JiraPriorityLevel.highest => strings.jiraPriorityHighest,
    JiraPriorityLevel.high => strings.jiraPriorityHigh,
    JiraPriorityLevel.medium => strings.jiraPriorityMedium,
    JiraPriorityLevel.low ||
    JiraPriorityLevel.lowest => strings.jiraPriorityLow,
    JiraPriorityLevel.missing => strings.jiraPriorityMissing,
  };
}

String jiraDueLabel(BuildContext context, JiraIssue issue, {DateTime? now}) {
  final due = JiraDueInfo.fromIssue(issue, now: now);
  if (due.isOverdue) return S.of(context).jiraOverdueDays(due.overdueDays);
  if (due.isDueToday) return S.of(context).jiraDueToday;
  if (due.isDueSoon) {
    return S.of(context).jiraDueRemainingDays(due.daysUntilDue!);
  }
  if (due.date == null) return S.of(context).jiraDueMissing;
  return S
      .of(context)
      .jiraDueDate(intl.DateFormat('dd/MM/yyyy').format(due.date!));
}

class JiraCompactSummary extends StatelessWidget {
  const JiraCompactSummary({super.key, required this.data, this.now});

  final JiraIssueList data;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final risk = JiraTaskRules.riskSummary(data.issues, now: now);
    final overdue = data.stats.overdue > risk.overdue
        ? data.stats.overdue
        : risk.overdue;
    final withoutDueDate = data.stats.withoutDueDate > risk.withoutDueDate
        ? data.stats.withoutDueDate
        : risk.withoutDueDate;
    final risks = <String>[
      if (overdue > 0) strings.jiraRiskOverdue(overdue),
      if (withoutDueDate > 0) strings.jiraRiskWithoutDueDate(withoutDueDate),
    ];
    return Container(
      key: const Key('jira-compact-summary'),
      padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: colors.surfaceTemary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IrhText.smallMedium(
            strings.jiraWorkflowSummary(
              data.stats.toDo,
              data.stats.inProgress,
              data.stats.done,
            ),
            color: colors.textPrimary,
          ),
          if (risks.isNotEmpty) ...[
            8.height.heightBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _JiraRiskMark(color: colors.textError),
                8.width.widthBox,
                IrhText.small(
                  risks.join(' · '),
                  color: colors.textError,
                ).expanded(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class JiraTaskItem extends StatelessWidget {
  const JiraTaskItem({
    super.key,
    required this.issue,
    required this.onTap,
    this.onMore,
    this.now,
  });

  final JiraIssue issue;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final content = CupertinoButton(
      key: Key('jira-issue-${issue.key}'),
      padding: EdgeInsets.zero,
      minimumSize: Size(44.width, 44.height),
      onPressed: onTap,
      child: _JiraTaskContent(issue: issue, now: now),
    );
    if (onMore == null) return content;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content.expanded(),
        SizedBox(
          width: 44.width,
          height: 44.height,
          child: CupertinoButton(
            key: Key('jira-more-${issue.key}'),
            padding: EdgeInsets.zero,
            onPressed: onMore,
            child: Text(
              '•••',
              style: AppTextStyle.b16.copyWith(
                color: context.appColorScheme.iconSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class JiraTaskCard extends StatelessWidget {
  const JiraTaskCard({
    super.key,
    required this.issue,
    required this.onOpenJira,
    required this.onAddToCalendar,
    this.now,
    this.isAddingToCalendar = false,
    this.isAddedToCalendar = false,
  });

  final JiraIssue issue;
  final VoidCallback onOpenJira;
  final VoidCallback? onAddToCalendar;
  final DateTime? now;
  final bool isAddingToCalendar;
  final bool isAddedToCalendar;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final due = JiraDueInfo.fromIssue(issue, now: now);
    final addColor = isAddedToCalendar ? colors.textSuccess : colors.textBrand;
    return Container(
      key: Key('jira-card-${issue.key}'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Stack(
        children: [
          if (due.isOverdue)
            Positioned(
              left: 0,
              top: 12.height,
              bottom: 12.height,
              child: Container(
                width: 4.width,
                decoration: BoxDecoration(
                  color: colors.textError,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IrhText.small(
                    issue.key,
                    color: colors.textTertiary,
                    maxLines: 1,
                  ).expanded(),
                  8.width.widthBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: JiraStatusBadge(issue: issue),
                  ).flexible(),
                ],
              ),
              8.height.heightBox,
              Text(
                issue.summary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.sm16.copyWith(
                  color: colors.textPrimary,
                  height: 1.35,
                ),
              ),
              12.height.heightBox,
              JiraTaskMetadata(issue: issue, now: now),
              16.height.heightBox,
              Row(
                children: [
                  IrhIconTextButton(
                    key: Key('jira-issue-${issue.key}'),
                    label: strings.jiraOpenExternal,
                    icon: Assets.image.icExternalLink.svg(
                      width: 20.sp,
                      height: 20.sp,
                      colorFilter: ColorFilter.mode(
                        colors.iconPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    foregroundColor: colors.textPrimary,
                    backgroundColor: colors.surfaceSecondary,
                    borderColor: colors.borderPrimary,
                    onPressed: onOpenJira,
                  ).expanded(),
                  8.width.widthBox,
                  IrhIconTextButton(
                    key: Key('jira-add-calendar-${issue.key}'),
                    label: isAddedToCalendar
                        ? strings.jiraAddedToCalendar
                        : strings.jiraAddToCalendar,
                    icon:
                        (isAddedToCalendar
                                ? Assets.image.icCheck
                                : Assets.image.icCalendar)
                            .svg(
                              width: 20.sp,
                              height: 20.sp,
                              colorFilter: ColorFilter.mode(
                                addColor,
                                BlendMode.srcIn,
                              ),
                            ),
                    foregroundColor: addColor,
                    backgroundColor: Color.lerp(
                      colors.surfaceSecondary,
                      addColor,
                      0.08,
                    ),
                    loading: isAddingToCalendar,
                    onPressed: isAddedToCalendar ? null : onAddToCalendar,
                  ).expanded(),
                ],
              ),
            ],
          ).paddingAll(16.width),
        ],
      ),
    );
  }
}

class _JiraTaskContent extends StatelessWidget {
  const _JiraTaskContent({required this.issue, required this.now});

  final JiraIssue issue;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _JiraTaskHeading(issue: issue),
          8.height.heightBox,
          JiraTaskMetadata(issue: issue, now: now),
        ],
      ),
    );
  }
}

class _JiraTaskHeading extends StatelessWidget {
  const _JiraTaskHeading({required this.issue});

  final JiraIssue issue;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    return LayoutBuilder(
      builder: (context, constraints) {
        final wrapBadge = constraints.maxWidth < 260.width || textScale > 1.3;
        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IrhText.small(
              issue.key,
              color: context.appColorScheme.textSecondary,
              maxLines: 1,
            ),
            4.height.heightBox,
            Text(
              issue.summary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.sm14.copyWith(
                color: context.appColorScheme.textPrimary,
                height: 1.35,
              ),
            ),
          ],
        );
        final badge = JiraStatusBadge(issue: issue);
        if (wrapBadge) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title, 8.height.heightBox, badge],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title.expanded(), 12.width.widthBox, badge],
        );
      },
    );
  }
}

class JiraStatusBadge extends StatelessWidget {
  const JiraStatusBadge({super.key, required this.issue});

  final JiraIssue issue;

  @override
  Widget build(BuildContext context) {
    final group = JiraTaskRules.workflowGroup(issue);
    final colors = context.appColorScheme;
    final color = switch (group) {
      JiraWorkflowGroup.todo => colors.textSecondary,
      JiraWorkflowGroup.inProgress => colors.textPrimary,
      JiraWorkflowGroup.done => colors.textSuccess,
      JiraWorkflowGroup.unknown => colors.textSecondary,
    };
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 1,
      child: Container(
        constraints: BoxConstraints(maxWidth: 120.width),
        padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 4.height),
        decoration: BoxDecoration(
          color: Color.lerp(colors.surfaceSecondary, color, .12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          jiraStatusLabel(context, issue),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.sm12.copyWith(color: color),
        ),
      ),
    );
  }
}

class JiraTaskMetadata extends StatelessWidget {
  const JiraTaskMetadata({super.key, required this.issue, required this.now});

  final JiraIssue issue;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final due = JiraDueInfo.fromIssue(issue, now: now);
    final priority = JiraTaskRules.priorityLevel(issue.priority);
    final colors = context.appColorScheme;
    final priorityColor = switch (priority) {
      JiraPriorityLevel.highest || JiraPriorityLevel.high => colors.textError,
      JiraPriorityLevel.medium => colors.textSecondary,
      JiraPriorityLevel.low || JiraPriorityLevel.lowest => colors.textSecondary,
      JiraPriorityLevel.missing => colors.textTertiary,
    };
    final dueColor = switch (due) {
      JiraDueInfo(isOverdue: true) => colors.textError,
      JiraDueInfo(isDueToday: true) ||
      JiraDueInfo(isDueSoon: true) => colors.textBrand,
      JiraDueInfo(isMissing: true) => colors.textTertiary,
      _ => colors.textSecondary,
    };
    return Wrap(
      spacing: 8.width,
      runSpacing: 4.height,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          jiraPriorityLabel(context, issue),
          style: AppTextStyle.r12.copyWith(color: priorityColor),
        ),
        Text('·', style: AppTextStyle.r12.copyWith(color: colors.textTertiary)),
        if (due.isOverdue) _JiraRiskMark(color: colors.textError),
        Text(
          jiraDueLabel(context, issue, now: now),
          style: AppTextStyle.r12.copyWith(color: dueColor),
        ),
      ],
    );
  }
}

class _JiraRiskMark extends StatelessWidget {
  const _JiraRiskMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 16.width,
    height: 16.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: color),
    ),
    child: Text(
      '!',
      style: AppTextStyle.sm12.copyWith(color: color, height: 1),
    ),
  );
}
