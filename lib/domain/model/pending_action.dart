enum PendingActionType { createLeave, openAssistant, askAssistant }

class PendingAction {
  const PendingAction({required this.type, this.parameters = const {}});

  final PendingActionType type;
  final Map<String, dynamic> parameters;
}
