import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/repository/api_chat_repository.dart';
import 'data/repository/device_speech_to_text_repository.dart';
import 'data/repository/mock_chat_repository.dart';
import 'data/source/remote/client/api_chat_client.dart';
import 'domain/repository/chat_repository.dart';
import 'domain/repository/speech_to_text_repository.dart';
import 'domain/usecase/business_trip_prompt.dart';
import 'presentation/pages/chat/bloc/chat_bloc.dart';
import 'presentation/pages/page2/home_page.dart';
import 'resources/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final apiKey = dotenv.maybeGet('AI_PLATFORM_API_KEY')?.trim() ?? '';
  final promptBuilder = BusinessTripPromptBuilder(
    data: const BusinessTripPromptData(),
  );
  final ChatRepository chatRepository = apiKey.isEmpty
      ? MockChatRepository()
      : ApiChatRepository(
          client: ApiChatClient(
            baseUrl: dotenv.get('AI_PLATFORM_BASE_URL'),
            apiKey: apiKey,
            model: dotenv.get('AI_PLATFORM_MODEL'),
            systemPromptBuilder: promptBuilder.build,
          ),
        );
  runApp(AiAssistantApp(chatRepository: chatRepository));
}

class AiAssistantApp extends StatelessWidget {
  const AiAssistantApp({super.key, required this.chatRepository});

  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B5CE2);
    return MaterialApp(
      title: AppConstants.chatbotName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: const Color(0xFFF8F8FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F8FC),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B9CFF),
          brightness: Brightness.dark,
          surface: const Color(0xFF111216),
        ),
        scaffoldBackgroundColor: const Color(0xFF111216),
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ChatRepository>(
            create: (_) => chatRepository,
            dispose: (repository) => repository.close(),
          ),
          RepositoryProvider<SpeechToTextRepository>(
            create: (_) => DeviceSpeechToTextRepository(),
            dispose: (repository) => unawaited(repository.close()),
          ),
        ],
        child: BlocProvider(
          create: (context) => ChatBloc(
            context.read<ChatRepository>(),
            context.read<SpeechToTextRepository>(),
          )..add(const ChatStarted()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
