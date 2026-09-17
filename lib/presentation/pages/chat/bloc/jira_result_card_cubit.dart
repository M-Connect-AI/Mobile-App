import 'package:flutter_bloc/flutter_bloc.dart';

class JiraResultCardState {
  const JiraResultCardState({
    this.analysisExpanded = false,
    this.addingIssueKeys = const {},
    this.addedIssueKeys = const {},
    this.isAddingAll = false,
  });

  final bool analysisExpanded;
  final Set<String> addingIssueKeys;
  final Set<String> addedIssueKeys;
  final bool isAddingAll;

  JiraResultCardState copyWith({
    bool? analysisExpanded,
    Set<String>? addingIssueKeys,
    Set<String>? addedIssueKeys,
    bool? isAddingAll,
  }) => JiraResultCardState(
    analysisExpanded: analysisExpanded ?? this.analysisExpanded,
    addingIssueKeys: addingIssueKeys ?? this.addingIssueKeys,
    addedIssueKeys: addedIssueKeys ?? this.addedIssueKeys,
    isAddingAll: isAddingAll ?? this.isAddingAll,
  );
}

class JiraResultCardCubit extends Cubit<JiraResultCardState> {
  JiraResultCardCubit() : super(const JiraResultCardState());

  void toggleAnalysis() =>
      emit(state.copyWith(analysisExpanded: !state.analysisExpanded));

  Future<void> addIssue(String issueKey, Future<bool> Function() action) async {
    if (state.addedIssueKeys.contains(issueKey) ||
        state.addingIssueKeys.contains(issueKey)) {
      return;
    }
    emit(state.copyWith(addingIssueKeys: {...state.addingIssueKeys, issueKey}));
    var added = false;
    try {
      added = await action();
    } finally {
      if (!isClosed) {
        final addingKeys = {...state.addingIssueKeys}..remove(issueKey);
        emit(
          state.copyWith(
            addingIssueKeys: addingKeys,
            addedIssueKeys: added
                ? {...state.addedIssueKeys, issueKey}
                : state.addedIssueKeys,
          ),
        );
      }
    }
  }

  Future<void> addAll(
    List<String> issueKeys,
    Future<Set<String>> Function() action,
  ) async {
    if (state.isAddingAll) return;
    final pendingKeys = issueKeys
        .where((key) => !state.addedIssueKeys.contains(key))
        .toSet();
    if (pendingKeys.isEmpty) return;
    emit(
      state.copyWith(
        isAddingAll: true,
        addingIssueKeys: {...state.addingIssueKeys, ...pendingKeys},
      ),
    );
    var addedKeys = <String>{};
    try {
      addedKeys = await action();
    } finally {
      if (!isClosed) {
        final addingKeys = {...state.addingIssueKeys}..removeAll(pendingKeys);
        emit(
          state.copyWith(
            isAddingAll: false,
            addingIssueKeys: addingKeys,
            addedIssueKeys: {...state.addedIssueKeys, ...addedKeys},
          ),
        );
      }
    }
  }
}
