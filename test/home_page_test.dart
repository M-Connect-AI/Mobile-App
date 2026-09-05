import 'package:chatbot_project/data/repository/mock_chat_repository.dart';
import 'package:chatbot_project/domain/repository/speech_to_text_repository.dart';
import 'package:chatbot_project/presentation/pages/chat/bloc/chat_bloc.dart';
import 'package:chatbot_project/presentation/pages/page2/home_page.dart';
import 'package:chatbot_project/resources/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('assistant bubble opens and closes the chat screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) =>
              ChatBloc(MockChatRepository(), _FakeSpeechRepository())
                ..add(const ChatStarted()),
          child: const HomePage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
    expect(find.byKey(const Key('assistant-bubble')), findsOneWidget);

    await tester.tap(find.byKey(const Key('assistant-bubble')));
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.chatbotName), findsOneWidget);
    expect(find.byKey(const Key('close-assistant')), findsOneWidget);

    await tester.tap(find.byKey(const Key('close-assistant')));
    await tester.pumpAndSettle();

    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
  });
}

class _FakeSpeechRepository implements SpeechToTextRepository {
  @override
  Stream<String> get errors => const Stream.empty();

  @override
  Stream<SpeechSessionStatus> get statuses => const Stream.empty();

  @override
  Stream<SpeechTranscript> get transcripts => const Stream.empty();

  @override
  Future<void> cancelListening() async {}

  @override
  Future<void> close() async {}

  @override
  Future<bool> initialize() async => true;

  @override
  Future<void> startListening() async {}

  @override
  Future<String> stopListening() async => '';
}
