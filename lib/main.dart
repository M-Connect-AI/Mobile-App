import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/theme/app_theme.dart';
import 'common/server_config/server_config_scope.dart';
import 'di/app_dependencies.dart';
import 'domain/model/server_config.dart';
import 'domain/repository/chat_repository.dart';
import 'domain/repository/chat_thread_repository.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/credential_repository.dart';
import 'domain/repository/home_repository.dart';
import 'domain/repository/speech_to_text_repository.dart';
import 'domain/repository/server_config_repository.dart';
import 'generated/l10n.dart';
import 'resources/app_constants.dart';
import 'route/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  final dependencies = await AppDependencies.fromEnvironment();
  runApp(AiAssistantApp(dependencies: dependencies));
}

class AiAssistantApp extends StatefulWidget {
  const AiAssistantApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<AiAssistantApp> createState() => _AiAssistantAppState();
}

class _AiAssistantAppState extends State<AiAssistantApp> {
  late AppDependencies _dependencies = widget.dependencies;
  var _configurationRevision = 0;

  Future<void> _applyServerConfig(ServerConfig config) async {
    final configRepository = _dependencies.serverConfigRepository;
    final normalized = config.normalized();
    final defaults = configRepository.defaults.normalized();
    final usesDefaults =
        normalized.hrApiBaseUrl == defaults.hrApiBaseUrl &&
        normalized.agentApiBaseUrl == defaults.agentApiBaseUrl;
    if (usesDefaults) {
      await configRepository.clear();
    } else {
      await configRepository.save(normalized);
    }
    await _dependencies.credentialRepository.clear();
    final replacement = await AppDependencies.fromEnvironment(
      serverConfigRepository: configRepository,
    );
    if (!mounted) return;
    appRouter.go(const LoginRoute().location);
    setState(() {
      _dependencies = replacement;
      _configurationRevision++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = _dependencies;
    return ServerConfigScope(
      apply: _applyServerConfig,
      child: MultiRepositoryProvider(
        key: ValueKey(_configurationRevision),
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (_) => dependencies.authRepository,
          ),
          RepositoryProvider<CredentialRepository>(
            create: (_) => dependencies.credentialRepository,
          ),
          RepositoryProvider<ChatRepository>(
            create: (_) => dependencies.chatRepository,
            dispose: (repository) => repository.close(),
          ),
          RepositoryProvider<ChatThreadRepository>(
            create: (_) => dependencies.chatThreadRepository,
          ),
          RepositoryProvider<HomeRepository>(
            create: (_) => dependencies.homeRepository,
          ),
          RepositoryProvider<SpeechToTextRepository>(
            create: (_) => dependencies.speechToTextRepository,
            dispose: (repository) => unawaited(repository.close()),
          ),
          RepositoryProvider<ServerConfigRepository>.value(
            value: dependencies.serverConfigRepository,
          ),
        ],
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
