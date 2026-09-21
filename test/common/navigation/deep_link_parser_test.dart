import 'package:chatbot_project/common/navigation/deep_link_parser.dart';
import 'package:chatbot_project/domain/model/pending_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('custom URL starts leave request', () {
    expect(
      parseDeepLink('mconnect://app/chatbot?action=create_leave')?.type,
      PendingActionType.createLeave,
    );
  });
  test('HTTPS URL starts same action', () {
    expect(
      parseDeepLink(
        'https://example.com/app/chatbot?action=create_leave',
      )?.type,
      PendingActionType.createLeave,
    );
  });
  test('assistant action', () {
    expect(
      parseDeepLink('mconnect://app/chatbot?action=open_assistant')?.type,
      PendingActionType.openAssistant,
    );
  });
  test('invalid URLs are ignored', () {
    for (final url in [
      'mconnect://app/chatbot?action=unknown',
      'mconnect://app/chatbot',
      'mconnect://app/wrong?action=create_leave',
      'not a url',
      'mconnect://app/chatbot?action=create_leave&action=create_leave',
    ]) {
      expect(parseDeepLink(url), isNull, reason: url);
    }
  });

  test('native leave intent keeps validated date and reason', () {
    final action = parseNativeAction({
      'action': 'create_leave',
      'parameters': {
        'startDate': '2026-09-21',
        'endDate': '2026-09-22',
        'reason': '  Việc gia đình  ',
      },
    });
    expect(action?.type, PendingActionType.createLeave);
    expect(action?.parameters, {
      'startDate': '2026-09-21',
      'endDate': '2026-09-22',
      'reason': 'Việc gia đình',
    });
  });

  test('native intent drops invalid fields and rejects unknown action', () {
    final action = parseNativeAction({
      'action': 'create_leave',
      'parameters': {'startDate': '2026-02-30', 'reason': '  '},
    });
    expect(action?.parameters, isEmpty);
    expect(parseNativeAction({'action': 'submit_leave'}), isNull);
  });

  test('native assistant question becomes a semantic action', () {
    final action = parseNativeAction({
      'action': 'ask_assistant',
      'parameters': {'message': '  Tôi còn bao nhiêu ngày phép?  '},
    });
    expect(action?.type, PendingActionType.askAssistant);
    expect(action?.parameters, {'message': 'Tôi còn bao nhiêu ngày phép?'});
  });

  test('native assistant question rejects empty and oversized text', () {
    for (final message in ['', '   ', List.filled(1001, 'x').join()]) {
      expect(
        parseNativeAction({
          'action': 'ask_assistant',
          'parameters': {'message': message},
        }),
        isNull,
      );
    }
    expect(parseNativeAction({'action': 'ask_assistant'}), isNull);
  });
}
