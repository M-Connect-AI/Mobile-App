import 'package:chatbot_project/features/chat/prompts/business_trip_prompt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('injects business entities and current date into prompt', () {
    final builder = BusinessTripPromptBuilder(
      now: () => DateTime(2026, 8, 31),
      transactionId: '11111111-2222-4333-8444-555555555555',
      data: const BusinessTripPromptData(
        locations: ['Đà Nẵng'],
        employees: [BusinessEntity(id: 'employee-1', name: 'Nguyễn Văn A')],
        customers: [BusinessEntity(id: 'customer-1', name: 'Công ty ABC')],
        transportationOptions: ['Máy bay'],
      ),
    );

    final prompt = builder.build();

    expect(prompt, contains('2026-08-31'));
    expect(
      prompt,
      contains('"transaction_id": "11111111-2222-4333-8444-555555555555"'),
    );
    expect(prompt, contains('Đà Nẵng'));
    expect(prompt, contains('employee-1'));
    expect(prompt, contains('Nguyễn Văn A'));
    expect(prompt, contains('customer-1'));
    expect(prompt, contains('Công ty ABC'));
    expect(prompt, contains('Máy bay'));
    expect(prompt, contains('Output JSON only'));
    expect(prompt, contains('Return minified JSON'));
    expect(
      prompt,
      contains('confirmation_question is REQUIRED and must never be null'),
    );
    expect(
      prompt.indexOf('"confirmation_question"'),
      lessThan(prompt.indexOf('"intent"')),
    );
    expect(
      prompt.indexOf('"transaction_id"'),
      lessThan(prompt.indexOf('"intent"')),
    );
  });

  test('generates transaction ID once per app-session builder', () {
    var generatedCount = 0;
    String generateId() => 'transaction-${++generatedCount}';

    final firstSession = BusinessTripPromptBuilder(
      transactionIdGenerator: generateId,
    );
    final firstPrompt = firstSession.build();
    final repeatedPrompt = firstSession.build();
    final secondSession = BusinessTripPromptBuilder(
      transactionIdGenerator: generateId,
    );

    expect(firstSession.transactionId, 'transaction-1');
    expect(firstPrompt, contains('transaction-1'));
    expect(repeatedPrompt, contains('transaction-1'));
    expect(secondSession.transactionId, 'transaction-2');
    expect(generatedCount, 2);
  });

  test('uses a random UUID by default', () {
    final first = BusinessTripPromptBuilder();
    final second = BusinessTripPromptBuilder();
    final uuidV4 = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    );

    expect(first.transactionId, matches(uuidV4));
    expect(second.transactionId, matches(uuidV4));
    expect(second.transactionId, isNot(first.transactionId));
  });
}
