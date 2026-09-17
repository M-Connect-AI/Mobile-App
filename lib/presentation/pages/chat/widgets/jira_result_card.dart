import 'dart:math' as math;

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/app_text_style.dart';
import '../../../../common/components/app_toast.dart';
import '../../../../common/components/irh_button.dart';
import '../../../../common/components/irh_text.dart';
import '../../../../common/extensions/responsive_extension.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/service/jira_task_rules.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../jira/widgets/jira_task_components.dart';
import '../bloc/jira_result_card_cubit.dart';

typedef JiraCalendarAction = Future<bool> Function(JiraIssue issue);
typedef JiraCalendarBatchAction =
    Future<Set<String>> Function(List<JiraIssue> issues);

class JiraResultCard extends StatelessWidget {
  const JiraResultCard({
    super.key,
    required this.data,
    required this.onOpenTask,
    this.onOpenOverview,
    this.onAddToCalendar,
    this.onAddAllToCalendar,
    this.now,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final JiraIssueList data;
  final ValueChanged<JiraIssue> onOpenTask;
  final VoidCallback? onOpenOverview;
  final JiraCalendarAction? onAddToCalendar;
  final JiraCalendarBatchAction? onAddAllToCalendar;
  final DateTime? now;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => JiraResultCardCubit(),
    child: _JiraResultCardView(
      data: data,
      onOpenTask: onOpenTask,
      onOpenOverview: onOpenOverview,
      onAddToCalendar: onAddToCalendar,
      onAddAllToCalendar: onAddAllToCalendar,
      now: now,
      isLoading: isLoading,
      errorMessage: errorMessage,
      onRetry: onRetry,
    ),
  );
}

class _JiraResultCardView extends StatelessWidget {
  const _JiraResultCardView({
    required this.data,
    required this.onOpenTask,
    required this.onOpenOverview,
    required this.onAddToCalendar,
    required this.onAddAllToCalendar,
    required this.now,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
  });

  final JiraIssueList data;
  final ValueChanged<JiraIssue> onOpenTask;
  final VoidCallback? onOpenOverview;
  final JiraCalendarAction? onAddToCalendar;
  final JiraCalendarBatchAction? onAddAllToCalendar;
  final DateTime? now;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    if (isLoading) {
      return const _JiraResultStateCard(isLoading: true);
    }
    if (errorMessage?.trim().isNotEmpty == true) {
      return _JiraResultStateCard(
        message: errorMessage!.trim(),
        onRetry: onRetry,
      );
    }
    if (data.issues.isEmpty) {
      return Container(
        key: const Key('jira-result-empty'),
        width: double.infinity,
        padding: EdgeInsets.all(16.width),
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSecondary),
        ),
        child: IrhText.small(
          S.of(context).jiraEmptyResult,
          color: colors.textSecondary,
        ),
      );
    }

    final total = math.max(data.stats.total, data.issues.length);
    final visibleIssues = JiraTaskRules.rankedIssues(
      data.issues,
      now: now,
    ).take(3).toList(growable: false);
    final calendarIssues = data.issues
        .where(
          (issue) =>
              JiraTaskRules.workflowGroup(issue) != JiraWorkflowGroup.done,
        )
        .toList(growable: false);
    final composition = _JiraChartData.issueTypes(data);
    final priorities = _JiraChartData.priorities(data);

    return Container(
      key: Key('jira-result-$total'),
      width: double.infinity,
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: Offset(0, 4.height),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _JiraOverviewSection(data: data, total: total),
          20.height.heightBox,
          _JiraStatusChartSection(data: data, total: total),
          if (composition.length > 1 || priorities.isNotEmpty) ...[
            12.height.heightBox,
            BlocBuilder<JiraResultCardCubit, JiraResultCardState>(
              buildWhen: (previous, current) =>
                  previous.analysisExpanded != current.analysisExpanded,
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IrhTextButton(
                    key: const Key('jira-analysis-toggle'),
                    label: state.analysisExpanded
                        ? S.of(context).jiraCollapseAnalysis
                        : S.of(context).jiraShowAnalysis,
                    onPressed: () =>
                        context.read<JiraResultCardCubit>().toggleAnalysis(),
                  ),
                  if (state.analysisExpanded) ...[
                    if (composition.length > 1) ...[
                      8.height.heightBox,
                      _JiraCompositionSection(
                        values: composition,
                        total: total,
                      ),
                    ],
                    if (priorities.isNotEmpty) ...[
                      20.height.heightBox,
                      _JiraPrioritySection(values: priorities),
                    ],
                  ],
                ],
              ),
            ),
          ],
          20.height.heightBox,
          Divider(
            height: 1.height,
            thickness: 1.height,
            color: colors.borderTertiary,
          ),
          16.height.heightBox,
          IrhText.semibold(S.of(context).jiraTaskListTitle),
          12.height.heightBox,
          BlocBuilder<JiraResultCardCubit, JiraResultCardState>(
            buildWhen: (previous, current) =>
                previous.addingIssueKeys != current.addingIssueKeys ||
                previous.addedIssueKeys != current.addedIssueKeys ||
                previous.isAddingAll != current.isAddingAll,
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < visibleIssues.length; index++) ...[
                  JiraTaskCard(
                    issue: visibleIssues[index],
                    now: now,
                    onOpenJira: () => onOpenTask(visibleIssues[index]),
                    isAddingToCalendar: state.addingIssueKeys.contains(
                      visibleIssues[index].key,
                    ),
                    isAddedToCalendar: state.addedIssueKeys.contains(
                      visibleIssues[index].key,
                    ),
                    onAddToCalendar:
                        onAddToCalendar != null &&
                            JiraTaskRules.workflowGroup(visibleIssues[index]) !=
                                JiraWorkflowGroup.done
                        ? () =>
                              _addIssueToCalendar(context, visibleIssues[index])
                        : null,
                  ),
                  if (index < visibleIssues.length - 1) 12.height.heightBox,
                ],
                if (calendarIssues.isNotEmpty &&
                    onAddAllToCalendar != null) ...[
                  16.height.heightBox,
                  IrhIconTextButton(
                    key: const Key('jira-add-all-calendar'),
                    label: S
                        .of(context)
                        .jiraAddTasksToCalendar(
                          calendarIssues
                              .where(
                                (issue) =>
                                    !state.addedIssueKeys.contains(issue.key),
                              )
                              .length,
                        ),
                    icon: Assets.image.icCalendar.svg(
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
                    loading: state.isAddingAll,
                    onPressed:
                        calendarIssues.every(
                          (issue) => state.addedIssueKeys.contains(issue.key),
                        )
                        ? null
                        : () => _addAllToCalendar(context, calendarIssues),
                  ),
                ],
                if (onOpenOverview != null) ...[
                  12.height.heightBox,
                  IrhButton(
                    label: S.of(context).jiraViewAllWork(total),
                    onPressed: onOpenOverview,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addIssueToCalendar(
    BuildContext context,
    JiraIssue issue,
  ) async {
    final action = onAddToCalendar;
    if (action == null) return;
    await context.read<JiraResultCardCubit>().addIssue(issue.key, () async {
      try {
        return await action(issue);
      } catch (_) {
        if (context.mounted) {
          AppToast.failed(context, S.of(context).jiraCalendarFailed);
        }
        return false;
      }
    });
  }

  Future<void> _addAllToCalendar(
    BuildContext context,
    List<JiraIssue> issues,
  ) async {
    final action = onAddAllToCalendar;
    if (action == null) return;
    final cubit = context.read<JiraResultCardCubit>();
    final pendingIssues = issues
        .where((issue) => !cubit.state.addedIssueKeys.contains(issue.key))
        .toList(growable: false);
    await cubit.addAll(
      pendingIssues.map((issue) => issue.key).toList(growable: false),
      () async {
        try {
          return await action(pendingIssues);
        } catch (_) {
          if (context.mounted) {
            AppToast.failed(context, S.of(context).jiraCalendarFailed);
          }
          return const <String>{};
        }
      },
    );
  }
}

class _JiraResultStateCard extends StatelessWidget {
  const _JiraResultStateCard({
    this.isLoading = false,
    this.message,
    this.onRetry,
  });

  final bool isLoading;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        children: [
          if (isLoading) ...[
            CupertinoActivityIndicator(color: colors.iconBrand),
            12.height.heightBox,
          ],
          IrhText.smallMedium(
            isLoading
                ? S.of(context).jiraLoadingTasks
                : message ?? S.of(context).jiraLoadTasksFailed,
            color: isLoading ? colors.textSecondary : colors.textError,
            textAlign: TextAlign.center,
          ),
          if (!isLoading && onRetry != null) ...[
            12.height.heightBox,
            IrhButton(label: S.of(context).retry, onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}

class _JiraOverviewSection extends StatelessWidget {
  const _JiraOverviewSection({required this.data, required this.total});

  final JiraIssueList data;
  final int total;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Column(
      key: const Key('jira-overview-section'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.smallMedium(
          strings.jiraMatchingWork(total),
          color: context.appColorScheme.textPrimary,
        ),
        12.height.heightBox,
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: context.appColorScheme.surfaceSecondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appColorScheme.borderSecondary),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _JiraMetric(
                label: strings.jiraStatusTodo,
                value: data.stats.toDo,
              ).expanded(),
              const _JiraMetricDivider(),
              _JiraMetric(
                label: strings.jiraStatusInProgress,
                value: data.stats.inProgress,
              ).expanded(),
              const _JiraMetricDivider(),
              _JiraMetric(
                label: strings.jiraStatusCompletedShort,
                value: data.stats.done,
              ).expanded(),
            ],
          ),
        ),
      ],
    );
  }
}

class _JiraMetric extends StatelessWidget {
  const _JiraMetric({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        '$value',
        style: AppTextStyle.b24.copyWith(
          color: context.appColorScheme.textBrand,
        ),
      ),
      4.height.heightBox,
      IrhText.small(
        label,
        color: context.appColorScheme.textSecondary,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    ],
  );
}

class _JiraMetricDivider extends StatelessWidget {
  const _JiraMetricDivider();

  @override
  Widget build(BuildContext context) => Container(
    width: 1.width,
    height: 44.height,
    color: context.appColorScheme.borderTertiary,
  );
}

class _JiraStatusChartSection extends StatelessWidget {
  const _JiraStatusChartSection({required this.data, required this.total});

  final JiraIssueList data;
  final int total;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final items = [
      _JiraBarValue(
        strings.jiraStatusTodo,
        data.stats.toDo,
        colors.iconSecondary,
      ),
      _JiraBarValue(
        strings.jiraStatusInProgress,
        data.stats.inProgress,
        Color.lerp(colors.surfaceSecondary, colors.iconBrand, 0.48)!,
      ),
      _JiraBarValue(
        strings.jiraStatusCompletedShort,
        data.stats.done,
        colors.iconBrand,
      ),
    ];
    return _JiraSection(
      key: const Key('jira-status-chart'),
      title: strings.jiraChartByStatus,
      child: _JiraBarList(items: items, denominator: total),
    );
  }
}

class _JiraCompositionSection extends StatelessWidget {
  const _JiraCompositionSection({required this.values, required this.total});

  final Map<String, int> values;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final palette = [
      colors.iconBrand,
      colors.textSuccess,
      colors.iconSecondary,
      colors.textError,
    ];
    final items = values.entries.indexed
        .map(
          (entry) => _JiraBarValue(
            entry.$2.key,
            entry.$2.value,
            palette[entry.$1 % palette.length],
          ),
        )
        .toList(growable: false);
    return _JiraSection(
      key: const Key('jira-composition-chart'),
      title: S.of(context).jiraChartComposition,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final donut = SizedBox(
            width: 104.width,
            height: 104.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size.square(104.width),
                  painter: _JiraDonutPainter(
                    values: items,
                    trackColor: colors.surfaceTemary,
                    strokeWidth: 16.width,
                  ),
                ),
                Text(
                  '$total',
                  style: AppTextStyle.b24.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
          );
          final legend = Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                _JiraLegendRow(item: items[index]),
                if (index < items.length - 1) 8.height.heightBox,
              ],
            ],
          );
          if (constraints.maxWidth < 256.width) {
            return Column(children: [donut, 16.height.heightBox, legend]);
          }
          return Row(children: [donut, 16.width.widthBox, legend.expanded()]);
        },
      ),
    );
  }
}

class _JiraPrioritySection extends StatelessWidget {
  const _JiraPrioritySection({required this.values});

  final Map<JiraPriorityLevel, int> values;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final missingCount = values[JiraPriorityLevel.missing] ?? 0;
    final knownCount = values.entries
        .where((entry) => entry.key != JiraPriorityLevel.missing)
        .fold<int>(0, (sum, entry) => sum + entry.value);
    if (knownCount == 0) {
      return _JiraSection(
        key: const Key('jira-priority-chart'),
        title: strings.jiraChartByPriority,
        child: IrhText.smallMedium(
          strings.jiraPriorityUnavailable(missingCount),
          color: colors.textSecondary,
        ),
      );
    }
    final ordered = [
      JiraPriorityLevel.highest,
      JiraPriorityLevel.high,
      JiraPriorityLevel.medium,
      JiraPriorityLevel.low,
      JiraPriorityLevel.missing,
    ];
    final items = ordered
        .where((level) => (values[level] ?? 0) > 0)
        .map(
          (level) => _JiraBarValue(
            _priorityLabel(level, strings),
            values[level]!,
            _priorityColor(level, colors),
          ),
        )
        .toList(growable: false);
    final total = items.fold<int>(0, (sum, item) => sum + item.value);
    return _JiraSection(
      key: const Key('jira-priority-chart'),
      title: strings.jiraChartByPriority,
      child: _JiraBarList(items: items, denominator: total),
    );
  }

  static String _priorityLabel(JiraPriorityLevel level, S strings) =>
      switch (level) {
        JiraPriorityLevel.highest => strings.jiraPriorityHighest,
        JiraPriorityLevel.high => strings.jiraPriorityHigh,
        JiraPriorityLevel.medium => strings.jiraPriorityMedium,
        JiraPriorityLevel.low ||
        JiraPriorityLevel.lowest => strings.jiraPriorityLow,
        JiraPriorityLevel.missing => strings.jiraPriorityUnknown,
      };

  static Color _priorityColor(JiraPriorityLevel level, AppColorScheme colors) =>
      switch (level) {
        JiraPriorityLevel.highest => colors.textError,
        JiraPriorityLevel.high => Color.lerp(
          colors.textError,
          colors.textSecondary,
          0.32,
        )!,
        JiraPriorityLevel.medium => colors.iconBrand,
        JiraPriorityLevel.low ||
        JiraPriorityLevel.lowest => colors.iconSecondary,
        JiraPriorityLevel.missing => colors.textTertiary,
      };
}

class _JiraSection extends StatelessWidget {
  const _JiraSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [IrhText.semibold(title), 12.height.heightBox, child],
  );
}

class _JiraBarList extends StatelessWidget {
  const _JiraBarList({required this.items, required this.denominator});

  final List<_JiraBarValue> items;
  final int denominator;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var index = 0; index < items.length; index++) ...[
        _JiraBarRow(item: items[index], denominator: denominator),
        if (index < items.length - 1) 12.height.heightBox,
      ],
    ],
  );
}

class _JiraBarRow extends StatelessWidget {
  const _JiraBarRow({required this.item, required this.denominator});

  final _JiraBarValue item;
  final int denominator;

  @override
  Widget build(BuildContext context) {
    final progress = denominator <= 0
        ? 0.0
        : (item.value / denominator).clamp(0.0, 1.0);
    return Semantics(
      label: '${item.label}: ${item.value}',
      child: Column(
        children: [
          Row(
            children: [
              IrhText.smallMedium(
                item.label,
                color: context.appColorScheme.textPrimary,
                maxLines: 1,
              ).expanded(),
              8.width.widthBox,
              Text(
                '${item.value}',
                style: AppTextStyle.sm14.copyWith(
                  color: context.appColorScheme.textPrimary,
                ),
              ),
            ],
          ),
          8.height.heightBox,
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 8.height,
              value: progress,
              backgroundColor: context.appColorScheme.surfaceTemary,
              valueColor: AlwaysStoppedAnimation(item.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _JiraLegendRow extends StatelessWidget {
  const _JiraLegendRow({required this.item});

  final _JiraBarValue item;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 8.width,
        height: 8.width,
        decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
      ),
      8.width.widthBox,
      IrhText.small(item.label, maxLines: 1).expanded(),
      8.width.widthBox,
      Text(
        '${item.value}',
        style: AppTextStyle.sm12.copyWith(
          color: context.appColorScheme.textPrimary,
        ),
      ),
    ],
  );
}

class _JiraDonutPainter extends CustomPainter {
  const _JiraDonutPainter({
    required this.values,
    required this.trackColor,
    required this.strokeWidth,
  });

  final List<_JiraBarValue> values;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
    final sum = values.fold<int>(0, (total, item) => total + item.value);
    if (sum <= 0) return;
    var startAngle = -math.pi / 2;
    for (final item in values.where((item) => item.value > 0)) {
      final sweep = math.pi * 2 * item.value / sum;
      canvas.drawArc(
        rect,
        startAngle,
        sweep,
        false,
        Paint()
          ..color = item.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _JiraDonutPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.strokeWidth != strokeWidth;
}

class _JiraBarValue {
  const _JiraBarValue(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}

abstract final class _JiraChartData {
  static Map<String, int> issueTypes(JiraIssueList data) {
    if (data.stats.byIssueType.isNotEmpty) return data.stats.byIssueType;
    final values = <String, int>{};
    for (final issue in data.issues) {
      final label = issue.issueType.trim();
      if (label.isNotEmpty) {
        values.update(label, (count) => count + 1, ifAbsent: () => 1);
      }
    }
    return values;
  }

  static Map<JiraPriorityLevel, int> priorities(JiraIssueList data) {
    final values = <JiraPriorityLevel, int>{};
    if (data.stats.byPriority.isNotEmpty) {
      for (final entry in data.stats.byPriority.entries) {
        final level = JiraTaskRules.priorityLevel(entry.key);
        final normalized = level == JiraPriorityLevel.lowest
            ? JiraPriorityLevel.low
            : level;
        values.update(
          normalized,
          (count) => count + entry.value,
          ifAbsent: () => entry.value,
        );
      }
      return values;
    }
    for (final issue in data.issues) {
      final level = JiraTaskRules.priorityLevel(issue.priority);
      final normalized = level == JiraPriorityLevel.lowest
          ? JiraPriorityLevel.low
          : level;
      values.update(normalized, (count) => count + 1, ifAbsent: () => 1);
    }
    return values;
  }
}
