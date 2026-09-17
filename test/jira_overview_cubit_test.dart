import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/presentation/pages/jira/bloc/jira_overview_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('filters workflow and risk categories', () async {
    final cubit = JiraOverviewCubit([
      _issue('TODO', dueDate: '2026-09-20'),
      _issue(
        'PROGRESS',
        status: 'In Progress',
        statusCategory: 'IN_PROGRESS',
        dueDate: '2026-09-10',
      ),
      _issue(
        'DONE',
        status: 'Closed',
        statusCategory: 'DONE',
        dueDate: '2020-01-01',
      ),
      _issue('NO-DUE'),
    ], now: DateTime(2026, 9, 17));
    addTearDown(cubit.close);

    cubit.selectFilter(JiraTaskFilter.inProgress);
    expect(cubit.state.visibleIssues.map((issue) => issue.key), ['PROGRESS']);

    cubit.selectFilter(JiraTaskFilter.overdue);
    expect(cubit.state.visibleIssues.map((issue) => issue.key), ['PROGRESS']);

    cubit.selectFilter(JiraTaskFilter.withoutDueDate);
    expect(cubit.state.visibleIssues.map((issue) => issue.key), ['NO-DUE']);

    cubit.selectFilter(JiraTaskFilter.done);
    expect(cubit.state.visibleIssues.map((issue) => issue.key), ['DONE']);
  });
}

JiraIssue _issue(
  String key, {
  String status = 'To Do',
  String statusCategory = 'TO_DO',
  String? dueDate,
}) => JiraIssue(
  key: key,
  summary: key,
  status: status,
  statusCategory: statusCategory,
  priority: '',
  issueType: 'Task',
  projectKey: 'SCRUM',
  assignee: '',
  dueDate: dueDate,
);
