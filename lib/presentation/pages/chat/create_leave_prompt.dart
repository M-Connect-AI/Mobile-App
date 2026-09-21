import '../../../domain/model/pending_action.dart';
import '../../../generated/l10n.dart';

String createLeavePrompt(PendingAction action, S strings) {
  final parts = <String>[strings.createLeaveIntentPrompt];
  final startDate = action.parameters['startDate'];
  final endDate = action.parameters['endDate'];
  if (startDate is String && endDate is String) {
    parts.add(strings.createLeaveIntentDateRange(startDate, endDate));
  } else if (startDate is String) {
    parts.add(strings.createLeaveIntentStartDate(startDate));
  } else if (endDate is String) {
    parts.add(strings.createLeaveIntentEndDate(endDate));
  }
  final reason = action.parameters['reason'];
  if (reason is String && reason.isNotEmpty) {
    parts.add(strings.createLeaveIntentReason(reason));
  }
  return '${parts.join('. ')}.';
}
