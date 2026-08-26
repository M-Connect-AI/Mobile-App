import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/chat/bloc/chat_bloc.dart';
import 'features/chat/data/mock_chat_repository.dart';
import 'features/chat/pages/chat_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AiAssistantApp());
}

class AiAssistantApp extends StatelessWidget {
  const AiAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B5CE2);
    return MaterialApp(
      title: 'AI Assistant',
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
      home: RepositoryProvider(
        create: (_) => MockChatRepository(),
        child: BlocProvider(
          create: (context) =>
              ChatBloc(context.read<MockChatRepository>())
                ..add(const ChatStarted()),
          child: const ChatPage(),
        ),
      ),
    );
  }
}
