import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_result.dart';
import '../../../../domain/service/jira_task_rules.dart';

enum JiraTaskFilter { all, todo, inProgress, done, overdue, withoutDueDate }

class JiraOverviewState extends Equatable {
  const JiraOverviewState({required this.filter, required this.visibleIssues});

  final JiraTaskFilter filter;
  final List<JiraIssue> visibleIssues;

  @override
  List<Object?> get props => [filter, visibleIssues];
}

class JiraOverviewCubit extends Cubit<JiraOverviewState> {
  JiraOverviewCubit(this._issues, {DateTime? now})
    : _now = now,
      super(
        JiraOverviewState(
          filter: JiraTaskFilter.all,
          visibleIssues: JiraTaskRules.rankedIssues(_issues, now: now),
        ),
      );

  final List<JiraIssue> _issues;
  final DateTime? _now;

  void selectFilter(JiraTaskFilter filter) {
    final visible = _issues.where((issue) {
      final group = JiraTaskRules.workflowGroup(issue);
      final due = JiraDueInfo.fromIssue(issue, now: _now);
      return switch (filter) {
        JiraTaskFilter.all => true,
        JiraTaskFilter.todo => group == JiraWorkflowGroup.todo,
        JiraTaskFilter.inProgress => group == JiraWorkflowGroup.inProgress,
        JiraTaskFilter.done => group == JiraWorkflowGroup.done,
        JiraTaskFilter.overdue => due.isOverdue,
        JiraTaskFilter.withoutDueDate => !due.done && due.isMissing,
      };
    });
    emit(
      JiraOverviewState(
        filter: filter,
        visibleIssues: JiraTaskRules.rankedIssues(visible, now: _now),
      ),
    );
  }
}
