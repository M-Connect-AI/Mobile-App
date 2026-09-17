import 'package:chatbot_project/presentation/pages/chat/bloc/jira_result_card_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toggles the analysis visibility for one Jira message', () async {
    final cubit = JiraResultCardCubit();
    addTearDown(cubit.close);

    expect(cubit.state.analysisExpanded, isFalse);
    cubit.toggleAnalysis();
    expect(cubit.state.analysisExpanded, isTrue);
    cubit.toggleAnalysis();
    expect(cubit.state.analysisExpanded, isFalse);
  });

  test('marks a Jira issue as added only after a successful action', () async {
    final cubit = JiraResultCardCubit();
    addTearDown(cubit.close);

    await cubit.addIssue('SCRUM-6', () async => true);
    expect(cubit.state.addedIssueKeys, contains('SCRUM-6'));

    await cubit.addIssue('SCRUM-7', () async => false);
    expect(cubit.state.addedIssueKeys, isNot(contains('SCRUM-7')));
  });
}
