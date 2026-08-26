import 'package:chatbot_project/features/chat/bloc/chat_bloc.dart';
import 'package:chatbot_project/features/chat/data/mock_chat_repository.dart';
import 'package:chatbot_project/features/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sends text and shows mock AI response', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) =>
              ChatBloc(MockChatRepository())..add(const ChatStarted()),
          child: const ChatPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('AI Assistant'), findsOneWidget);
    expect(find.textContaining('Xin chào'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('chat-text-field')),
      'Xin chào AI',
    );
    await tester.pump();
    expect(find.byKey(const ValueKey('send-icon')), findsOneWidget);

    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    expect(find.text('Thinking...'), findsWidgets);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Tôi đã hiểu yêu cầu'), findsOneWidget);
  });

  testWidgets('failed request offers retry and succeeds', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) =>
              ChatBloc(MockChatRepository())..add(const ChatStarted()),
          child: const ChatPage(),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byKey(const Key('chat-text-field')), '#fail');
    await tester.pump();
    await tester.tap(find.byKey(const Key('chat-action-button')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Tôi đã hiểu yêu cầu'), findsOneWidget);
  });
}
