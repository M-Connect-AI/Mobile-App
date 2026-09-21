import '../../domain/model/pending_action.dart';

PendingAction? parseDeepLink(String raw) {
  final uri = Uri.tryParse(raw);
  if (uri == null) return null;
  final local = uri.scheme == 'mconnect' && uri.host == 'app';
  final universal = uri.scheme == 'https' && uri.host.isNotEmpty;
  if ((!local && !universal) ||
      uri.path != (local ? '/chatbot' : '/app/chatbot')) {
    return null;
  }
  if (uri.queryParametersAll['action']?.length != 1) return null;
  return switch (uri.queryParameters['action']) {
    'create_leave' => const PendingAction(type: PendingActionType.createLeave),
    'open_assistant' => const PendingAction(
      type: PendingActionType.openAssistant,
    ),
    _ => null,
  };
}

PendingAction? parseNativeAction(Object? entry) {
  if (entry is! Map) return null;
  final action = entry['action'];
  if (action == 'open_assistant') {
    return const PendingAction(type: PendingActionType.openAssistant);
  }
  if (action == 'ask_assistant') {
    final rawParameters = entry['parameters'];
    if (rawParameters is! Map || rawParameters['message'] is! String) {
      return null;
    }
    final message = (rawParameters['message'] as String).trim();
    if (message.isEmpty || message.length > 1000) return null;
    return PendingAction(
      type: PendingActionType.askAssistant,
      parameters: {'message': message},
    );
  }
  if (action != 'create_leave') return null;
  final rawParameters = entry['parameters'];
  if (rawParameters != null && rawParameters is! Map) return null;
  final values = rawParameters is Map
      ? rawParameters
      : const <String, String>{};
  final parameters = <String, dynamic>{};
  for (final name in ['startDate', 'endDate']) {
    final value = values[name];
    if (value is String && _validDate(value)) parameters[name] = value;
  }
  final reason = values['reason'];
  if (reason is String && reason.trim().isNotEmpty) {
    parameters['reason'] = reason.trim().length > 300
        ? reason.trim().substring(0, 300)
        : reason.trim();
  }
  return PendingAction(
    type: PendingActionType.createLeave,
    parameters: parameters,
  );
}

bool _validDate(String value) {
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) return false;
  final year = int.parse(value.substring(0, 4));
  final month = int.parse(value.substring(5, 7));
  final day = int.parse(value.substring(8, 10));
  final parsed = DateTime.utc(year, month, day);
  return parsed.year == year && parsed.month == month && parsed.day == day;
}
