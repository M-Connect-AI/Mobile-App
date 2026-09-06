import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/theme/app_theme.dart';
import 'di/app_dependencies.dart';
import 'domain/repository/chat_repository.dart';
import 'domain/repository/speech_to_text_repository.dart';
import 'generated/l10n.dart';
import 'presentation/pages/chat/bloc/chat_bloc.dart';
import 'resources/app_constants.dart';
import 'route/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(AiAssistantApp(dependencies: AppDependencies.fromEnvironment()));
}

class AiAssistantApp extends StatelessWidget {
  const AiAssistantApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (_) => dependencies.chatRepository,
          dispose: (repository) => repository.close(),
        ),
        RepositoryProvider<SpeechToTextRepository>(
          create: (_) => dependencies.speechToTextRepository,
          dispose: (repository) => unawaited(repository.close()),
        ),
      ],
      child: BlocProvider(
        create: (context) => ChatBloc(
          context.read<ChatRepository>(),
          context.read<SpeechToTextRepository>(),
        )..add(const ChatStarted()),
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp.router(
            title: AppConstants.chatbotName,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: appRouter,
            locale: const Locale('vi'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
