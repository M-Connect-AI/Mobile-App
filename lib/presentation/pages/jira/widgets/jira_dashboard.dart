import 'dart:math' as math;

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/components/app_text_style.dart';
import '../../../../../common/components/irh_text.dart';
import '../../../../../common/extensions/responsive_extension.dart';
import '../../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../../domain/model/chat_result.dart';
import '../../../../../generated/l10n.dart';

class JiraDashboard extends StatelessWidget {
  const JiraDashboard({super.key, required this.data});

  final JiraIssueList data;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final statusItems = [
      _ChartItem(strings.jiraStatusTodo, data.stats.toDo, colors.iconSecondary),
      _ChartItem(
        strings.jiraStatusInProgress,
        data.stats.inProgress,
        colors.iconBrand,
      ),
      _ChartItem(strings.jiraStatusDone, data.stats.done, colors.textSuccess),
    ];
    final compositionItems = _toChartItems(
      data.stats.byIssueType.isEmpty
          ? _countValues(data.issues.map((issue) => issue.issueType))
          : data.stats.byIssueType,
      [colors.iconBrand, colors.textSuccess, colors.iconSecondary],
    );
    final priorityItems = _toChartItems(
      data.stats.byPriority.isEmpty
          ? _countValues(data.issues.map((issue) => issue.priority))
          : data.stats.byPriority,
      [colors.textError, colors.iconBrand, colors.iconSecondary],
    );
    final riskItems = [
      _ChartItem(
        strings.jiraFilterOverdue,
        data.stats.overdue,
        colors.textError,
      ),
      _ChartItem(
        strings.jiraFilterWithoutDueDate,
        data.stats.withoutDueDate,
        colors.iconBrand,
      ),
      _ChartItem(
        strings.jiraRiskStaleLabel,
        data.stats.stale,
        colors.iconSecondary,
      ),
    ];

    return Column(
      key: const Key('jira-dashboard'),
      children: [
        _JiraBarChartCard(
          key: const Key('jira-status-chart'),
          title: strings.jiraChartByStatus,
          items: statusItems,
        ),
        12.height.heightBox,
        _JiraDonutChartCard(
          key: const Key('jira-composition-chart'),
          title: strings.jiraChartComposition,
          items: compositionItems.isEmpty ? statusItems : compositionItems,
          total: data.stats.total,
        ),
        12.height.heightBox,
        _JiraBarChartCard(
          key: const Key('jira-priority-chart'),
          title: strings.jiraChartByPriority,
          items: priorityItems,
        ),
        12.height.heightBox,
        _JiraBarChartCard(
          key: const Key('jira-risk-chart'),
          title: strings.jiraChartBacklogRisk,
          items: riskItems,
        ),
      ],
    );
  }

  static Map<String, int> _countValues(Iterable<String> values) {
    final result = <String, int>{};
    for (final rawValue in values) {
      final value = rawValue.trim();
      if (value.isNotEmpty) {
        result.update(value, (count) => count + 1, ifAbsent: () => 1);
      }
    }
    return result;
  }

  static List<_ChartItem> _toChartItems(
    Map<String, int> values,
    List<Color> colors,
  ) => values.entries
      .where((entry) => entry.key.trim().isNotEmpty)
      .map(
        (entry) => _ChartItem(
          entry.key,
          entry.value,
          colors[values.keys.toList().indexOf(entry.key) % colors.length],
        ),
      )
      .toList(growable: false);
}

class _JiraBarChartCard extends StatelessWidget {
  const _JiraBarChartCard({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<_ChartItem> items;

  @override
  Widget build(BuildContext context) {
    final maximum = items.fold<int>(
      0,
      (value, item) => math.max(value, item.value),
    );
    return _JiraChartCard(
      title: title,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _JiraBarRow(item: items[index], maximum: maximum),
            if (index < items.length - 1) 12.height.heightBox,
          ],
          if (items.isEmpty)
            IrhText.small('—').paddingSymmetric(vertical: 8.height),
        ],
      ),
    );
  }
}

class _JiraBarRow extends StatelessWidget {
  const _JiraBarRow({required this.item, required this.maximum});

  final _ChartItem item;
  final int maximum;

  @override
  Widget build(BuildContext context) {
    final progress = maximum == 0 ? 0.0 : item.value / maximum;
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

class _JiraDonutChartCard extends StatelessWidget {
  const _JiraDonutChartCard({
    super.key,
    required this.title,
    required this.items,
    required this.total,
  });

  final String title;
  final List<_ChartItem> items;
  final int total;

  @override
  Widget build(BuildContext context) {
    return _JiraChartCard(
      title: title,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chart = Semantics(
            label: '$title: $total',
            child: SizedBox(
              width: 112.width,
              height: 112.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size.square(112.width),
                    painter: _DonutPainter(
                      items: items,
                      trackColor: context.appColorScheme.surfaceTemary,
                      strokeWidth: 16.width,
                    ),
                  ),
                  Text(
                    '$total',
                    style: AppTextStyle.b24.copyWith(
                      color: context.appColorScheme.textPrimary,
                    ),
                  ),
                ],
              ),
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
          if (constraints.maxWidth < 280.width) {
            return Column(children: [chart, 16.height.heightBox, legend]);
          }
          return Row(children: [chart, 20.width.widthBox, legend.expanded()]);
        },
      ),
    );
  }
}

class _JiraLegendRow extends StatelessWidget {
  const _JiraLegendRow({required this.item});

  final _ChartItem item;

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

class _JiraChartCard extends StatelessWidget {
  const _JiraChartCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),
    decoration: BoxDecoration(
      color: context.appColorScheme.surfaceSecondary,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: context.appColorScheme.borderSecondary),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [IrhText.semibold(title), 16.height.heightBox, child],
    ),
  );
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({
    required this.items,
    required this.trackColor,
    required this.strokeWidth,
  });

  final List<_ChartItem> items;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    final sum = items.fold<int>(0, (value, item) => value + item.value);
    if (sum <= 0) return;
    var startAngle = -math.pi / 2;
    for (final item in items.where((item) => item.value > 0)) {
      final sweepAngle = math.pi * 2 * item.value / sum;
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.items != items ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.strokeWidth != strokeWidth;
}

class _ChartItem {
  const _ChartItem(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}
