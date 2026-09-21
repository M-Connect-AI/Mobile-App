import 'dart:ui';

import 'package:chatbot_project/domain/model/pending_action.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/chat/create_leave_prompt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('prompt includes Siri-provided dates and reason for chatbot', () async {
    final strings = await S.load(const Locale('vi'));
    final prompt = createLeavePrompt(
      const PendingAction(
        type: PendingActionType.createLeave,
        parameters: {
          'startDate': '2026-09-21',
          'endDate': '2026-09-22',
          'reason': 'Việc gia đình',
        },
      ),
      strings,
    );
    expect(prompt, contains('2026-09-21'));
    expect(prompt, contains('2026-09-22'));
    expect(prompt, contains('Việc gia đình'));
  });
}
