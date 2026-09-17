import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../common/components/app_text_style.dart';
import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/calendar_event.dart';
import '../../../domain/model/chat_result.dart';
import '../../../domain/service/device_calendar_service.dart';
import '../../../domain/service/jira_task_rules.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import 'bloc/jira_calendar_draft_cubit.dart';
import 'bloc/jira_overview_cubit.dart';
import 'widgets/jira_dashboard.dart';
import 'widgets/jira_task_components.dart';

typedef JiraUrlOpener = Future<bool> Function(Uri uri);

Future<bool> _launchJiraUrl(Uri uri) =>
    launchUrl(uri, mode: LaunchMode.externalApplication);

class JiraTaskOverviewPage extends StatelessWidget {
  const JiraTaskOverviewPage({
    super.key,
    required this.data,
    required this.calendarService,
    this.openExternalUrl = _launchJiraUrl,
  });

  final JiraIssueList data;
  final DeviceCalendarService calendarService;
  final JiraUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JiraOverviewCubit(data.issues),
      child: _JiraTaskOverviewView(
        data: data,
        calendarService: calendarService,
        openExternalUrl: openExternalUrl,
      ),
    );
  }
}

class _JiraTaskOverviewView extends StatelessWidget {
  const _JiraTaskOverviewView({
    required this.data,
    required this.calendarService,
    required this.openExternalUrl,
  });

  final JiraIssueList data;
  final DeviceCalendarService calendarService;
  final JiraUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: colors.surfaceSecondary,
        surfaceTintColor: colors.surfaceSecondary,
        leading: _JiraBackButton(onPressed: context.pop),
        title: IrhText.semibold(S.of(context).jiraOverviewTitle),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<JiraOverviewCubit, JiraOverviewState>(
          builder: (context, state) => Column(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 16.height,
                ),
                children: [
                  JiraCompactSummary(data: data),
                  16.height.heightBox,
                  _JiraFilterBar(selected: state.filter),
                  16.height.heightBox,
                  if (state.filter == JiraTaskFilter.all) ...[
                    JiraDashboard(data: data),
                    20.height.heightBox,
                  ],
                  IrhText.semibold(S.of(context).jiraTaskListTitle),
                  12.height.heightBox,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.width),
                    decoration: BoxDecoration(
                      color: colors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.borderSecondary),
                    ),
                    child: state.visibleIssues.isEmpty
                        ? IrhText.small(
                            S.of(context).jiraEmptyResult,
                          ).paddingSymmetric(vertical: 20.height)
                        : Column(
                            children: [
                              for (
                                var index = 0;
                                index < state.visibleIssues.length;
                                index++
                              ) ...[
                                JiraTaskItem(
                                  issue: state.visibleIssues[index],
                                  onTap: () => _openDetails(
                                    context,
                                    state.visibleIssues[index],
                                  ),
                                  onMore: () => _showTaskActions(
                                    context,
                                    state.visibleIssues[index],
                                  ),
                                ),
                                if (index < state.visibleIssues.length - 1)
                                  Divider(
                                    height: 1.height,
                                    thickness: 1.height,
                                    color: colors.borderTertiary,
                                  ),
                              ],
                            ],
                          ),
                  ),
                ],
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, JiraIssue issue) {
    JiraTaskDetailRoute(issue).push(context);
  }

  Future<void> _showTaskActions(BuildContext context, JiraIssue issue) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.appColorScheme.surfaceSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => _JiraTaskActionsSheet(
        issue: issue,
        onDetails: () {
          sheetContext.pop();
          _openDetails(context, issue);
        },
        onOpenJira: JiraTaskRules.issueUri(issue) == null
            ? null
            : () async {
                sheetContext.pop();
                await _openJira(context, issue, openExternalUrl);
              },
        onAddToCalendar:
            JiraTaskRules.workflowGroup(issue) == JiraWorkflowGroup.done
            ? null
            : () async {
                sheetContext.pop();
                await JiraCalendarCoordinator.add(
                  context,
                  issue: issue,
                  service: calendarService,
                );
              },
      ),
    );
  }
}

class JiraTaskDetailPage extends StatelessWidget {
  const JiraTaskDetailPage({
    super.key,
    required this.issue,
    required this.calendarService,
    this.openExternalUrl = _launchJiraUrl,
  });

  final JiraIssue issue;
  final DeviceCalendarService calendarService;
  final JiraUrlOpener openExternalUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final isDone = JiraTaskRules.workflowGroup(issue) == JiraWorkflowGroup.done;
    final jiraUri = JiraTaskRules.issueUri(issue);
    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: colors.surfaceSecondary,
        surfaceTintColor: colors.surfaceSecondary,
        leading: _JiraBackButton(onPressed: context.pop),
        title: IrhText.semibold(strings.jiraTaskDetails),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 16.height,
          ),
          children: [
            Container(
              padding: EdgeInsets.all(16.width),
              decoration: BoxDecoration(
                color: colors.surfaceSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.borderSecondary),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  JiraStatusBadge(issue: issue),
                  16.height.heightBox,
                  _JiraDetailField(
                    label: strings.jiraIssueKeyLabel,
                    value: issue.key,
                  ),
                  _JiraDetailField(
                    label: strings.jiraSummaryLabel,
                    value: issue.summary,
                  ),
                  _JiraDetailField(
                    label: strings.jiraDueDateLabel,
                    value: jiraDueLabel(context, issue),
                  ),
                  _JiraDetailField(
                    label: strings.jiraPriorityLabel,
                    value: jiraPriorityLabel(context, issue),
                  ),
                  if (issue.assignee.trim().isNotEmpty)
                    _JiraDetailField(
                      label: strings.jiraAssigneeLabel,
                      value: issue.assignee.trim(),
                    ),
                  if (issue.projectKey.trim().isNotEmpty)
                    _JiraDetailField(
                      label: strings.jiraProjectLabel,
                      value: issue.projectKey.trim(),
                    ),
                ],
              ),
            ),
            16.height.heightBox,
            if (jiraUri != null) ...[
              IrhButton(
                label: strings.jiraOpenExternal,
                secondary: true,
                onPressed: () => _openJira(context, issue, openExternalUrl),
              ),
              12.height.heightBox,
            ],
            IrhButton(
              label: strings.jiraAddToCalendar,
              onPressed: isDone
                  ? null
                  : () => JiraCalendarCoordinator.add(
                      context,
                      issue: issue,
                      service: calendarService,
                    ),
            ),
            if (isDone) ...[
              8.height.heightBox,
              IrhText.small(
                strings.jiraCompletedCalendarUnavailable,
                color: colors.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _JiraFilterBar extends StatelessWidget {
  const _JiraFilterBar({required this.selected});

  final JiraTaskFilter selected;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final filters = <(JiraTaskFilter, String)>[
      (JiraTaskFilter.all, strings.jiraFilterAll),
      (JiraTaskFilter.todo, strings.jiraStatusTodo),
      (JiraTaskFilter.inProgress, strings.jiraStatusInProgress),
      (JiraTaskFilter.done, strings.jiraStatusDone),
      (JiraTaskFilter.overdue, strings.jiraFilterOverdue),
      (JiraTaskFilter.withoutDueDate, strings.jiraFilterWithoutDueDate),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < filters.length; index++) ...[
            IrhOptionChip(
              label: filters[index].$2,
              selected: selected == filters[index].$1,
              onPressed: () => context.read<JiraOverviewCubit>().selectFilter(
                filters[index].$1,
              ),
            ),
            if (index < filters.length - 1) 8.width.widthBox,
          ],
        ],
      ),
    );
  }
}

class _JiraTaskActionsSheet extends StatelessWidget {
  const _JiraTaskActionsSheet({
    required this.issue,
    required this.onDetails,
    required this.onOpenJira,
    required this.onAddToCalendar,
  });

  final JiraIssue issue;
  final VoidCallback onDetails;
  final VoidCallback? onOpenJira;
  final VoidCallback? onAddToCalendar;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IrhText.semibold(issue.key),
          16.height.heightBox,
          IrhButton(label: strings.jiraTaskDetails, onPressed: onDetails),
          if (onOpenJira != null) ...[
            12.height.heightBox,
            IrhButton(
              label: strings.jiraOpenExternal,
              secondary: true,
              onPressed: onOpenJira,
            ),
          ],
          if (onAddToCalendar != null) ...[
            12.height.heightBox,
            IrhButton(
              label: strings.jiraAddToCalendar,
              secondary: true,
              onPressed: onAddToCalendar,
            ),
          ],
        ],
      ).paddingAll(16.width),
    );
  }
}

class _JiraDetailField extends StatelessWidget {
  const _JiraDetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IrhText.small(label, color: context.appColorScheme.textSecondary),
      4.height.heightBox,
      IrhText.smallMedium(value, color: context.appColorScheme.textPrimary),
      16.height.heightBox,
    ],
  );
}

class _JiraBackButton extends StatelessWidget {
  const _JiraBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CupertinoButton(
    key: const Key('jira-back-button'),
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Text(
      '‹',
      style: AppTextStyle.b28.copyWith(
        color: context.appColorScheme.iconPrimary,
      ),
    ),
  );
}

abstract final class JiraCalendarCoordinator {
  static Future<bool> add(
    BuildContext context, {
    required JiraIssue issue,
    required DeviceCalendarService service,
  }) async {
    final rawDue = issue.dueDate?.trim() ?? '';
    final parsedDue = DateTime.tryParse(rawDue)?.toLocal();
    final hasJiraDate = parsedDue != null;
    var date = parsedDue;
    var isAllDay = !_containsTime(rawDue);
    var reminderEnabled = true;
    if (date == null) {
      final selection = await showModalBottomSheet<JiraCalendarDraftState>(
        context: context,
        isScrollControlled: true,
        backgroundColor: context.appColorScheme.surfaceSecondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const _JiraCalendarDateSheet(),
      );
      if (selection == null || !context.mounted) return false;
      date = selection.date;
      isAllDay = selection.isAllDay;
      reminderEnabled = selection.reminderEnabled;
    }
    final start = isAllDay
        ? DateTime(date.year, date.month, date.day)
        : hasJiraDate
        ? date
        : DateTime(date.year, date.month, date.day, 9);
    final strings = S.of(context);
    final draft = JiraCalendarDraftMapper.fromIssue(
      issue: issue,
      start: start,
      isAllDay: isAllDay,
      statusLabel: jiraStatusLabel(context, issue),
      priorityLabel: jiraPriorityLabel(context, issue),
      statusPrefix: strings.jiraCalendarStatusPrefix,
      priorityPrefix: strings.jiraCalendarPriorityPrefix,
      assigneePrefix: strings.jiraCalendarAssigneePrefix,
      jiraPrefix: strings.jiraCalendarLinkPrefix,
      reminderBefore: reminderEnabled ? const Duration(days: 1) : null,
    );
    final result = await service.openCreateEvent(draft);
    if (!context.mounted) return false;
    switch (result) {
      case CalendarEventResult.saved:
        AppToast.success(context, strings.jiraCalendarSaved);
        return true;
      case CalendarEventResult.opened:
        AppToast.warning(context, strings.jiraCalendarOpened);
        return false;
      case CalendarEventResult.cancelled:
        return false;
      case CalendarEventResult.permissionDenied:
        AppToast.failed(context, strings.jiraCalendarPermissionDenied);
        return false;
      case CalendarEventResult.unavailable:
        AppToast.failed(context, strings.jiraCalendarUnavailable);
        return false;
      case CalendarEventResult.failed:
        AppToast.failed(context, strings.jiraCalendarFailed);
        return false;
    }
  }
}

class _JiraCalendarDateSheet extends StatelessWidget {
  const _JiraCalendarDateSheet();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JiraCalendarDraftCubit(),
      child: const _JiraCalendarDateSheetView(),
    );
  }
}

class _JiraCalendarDateSheetView extends StatelessWidget {
  const _JiraCalendarDateSheetView();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<JiraCalendarDraftCubit, JiraCalendarDraftState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IrhText.semibold(strings.jiraTaskWithoutDeadline),
            8.height.heightBox,
            IrhText.small(strings.jiraChooseDateDescription),
            16.height.heightBox,
            IrhButton(
              label: intl.DateFormat('dd/MM/yyyy').format(state.date),
              secondary: true,
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: state.date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                  helpText: strings.jiraChooseDate,
                );
                if (selected != null && context.mounted) {
                  context.read<JiraCalendarDraftCubit>().selectDate(selected);
                }
              },
            ),
            12.height.heightBox,
            Row(
              children: [
                IrhOptionChip(
                  label: strings.jiraAllDay,
                  selected: state.isAllDay,
                  onPressed: () =>
                      context.read<JiraCalendarDraftCubit>().selectAllDay(true),
                ).expanded(),
                8.width.widthBox,
                IrhOptionChip(
                  label: strings.jiraTimedEvent,
                  selected: !state.isAllDay,
                  onPressed: () => context
                      .read<JiraCalendarDraftCubit>()
                      .selectAllDay(false),
                ).expanded(),
              ],
            ),
            12.height.heightBox,
            Row(
              children: [
                IrhOptionChip(
                  label: strings.jiraReminderOneDay,
                  selected: state.reminderEnabled,
                  onPressed: () =>
                      context.read<JiraCalendarDraftCubit>().setReminder(true),
                ).expanded(),
                8.width.widthBox,
                IrhOptionChip(
                  label: strings.jiraNoReminder,
                  selected: !state.reminderEnabled,
                  onPressed: () =>
                      context.read<JiraCalendarDraftCubit>().setReminder(false),
                ).expanded(),
              ],
            ),
            16.height.heightBox,
            IrhButton(
              label: strings.jiraContinueToCalendar,
              onPressed: () =>
                  context.pop(context.read<JiraCalendarDraftCubit>().state),
            ),
            8.height.heightBox,
            IrhTextButton(label: strings.cancelAction, onPressed: context.pop),
          ],
        ).paddingAll(16.width),
      ),
    );
  }
}

bool _containsTime(String value) =>
    RegExp(r'^\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}').hasMatch(value);

Future<void> _openJira(
  BuildContext context,
  JiraIssue issue,
  JiraUrlOpener opener,
) async {
  final uri = JiraTaskRules.issueUri(issue);
  if (uri == null || await opener(uri)) return;
  if (context.mounted) AppToast.failed(context, S.of(context).linkOpenFailed);
}
