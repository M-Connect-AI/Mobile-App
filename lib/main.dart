import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

import 'common/theme/app_theme.dart';
import 'common/navigation/external_action_handler.dart';
import 'data/repository/pending_action_store.dart';
import 'data/source/remote/client/dio_client_factory.dart';
import 'common/server_config/server_config_scope.dart';
import 'di/app_dependencies.dart';
import 'domain/model/server_config.dart';
import 'domain/repository/chat_repository.dart';
import 'domain/repository/chat_thread_repository.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/repository/auth_preference_repository.dart';
import 'domain/repository/credential_repository.dart';
import 'domain/repository/home_repository.dart';
import 'domain/repository/hr_request_repository.dart';
import 'domain/repository/outlook_repository.dart';
import 'domain/repository/speech_to_text_repository.dart';
import 'domain/repository/text_to_speech_repository.dart';
import 'domain/repository/voice_assistant_chat_repository.dart';
import 'domain/repository/server_config_repository.dart';
import 'domain/service/data_refresh_coordinator.dart';
import 'domain/service/device_calendar_service.dart';
import 'domain/service/session_expiry.dart';
import 'generated/l10n.dart';
import 'resources/app_constants.dart';
import 'route/go_router.dart';
import 'presentation/pages/chat/bloc/chat_text_size_cubit.dart';

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

class _AiAssistantAppState extends State<AiAssistantApp>
    with WidgetsBindingObserver {
  late AppDependencies _dependencies = widget.dependencies;
  late ExternalActionHandler _externalActions = _makeExternalActions(
    _dependencies,
  );
  var _configurationRevision = 0;
  StreamSubscription<void>? _sessionExpirySubscription;

  void _listenForSessionExpiry(CredentialRepository credentials) {
    _sessionExpirySubscription?.cancel();
    if (credentials case SessionExpiry expiry) {
      _sessionExpirySubscription = expiry.onSessionExpired.listen((_) {
        if (!mounted) return;
        if (appRouter.routeInformationProvider.value.uri.path !=
            const LoginRoute().location) {
          appRouter.go(const LoginRoute().location);
        }
      });
    }
  }

  ExternalActionHandler _makeExternalActions(AppDependencies dependencies) =>
      ExternalActionHandler(
        credentials: dependencies.credentialRepository,
        auth: dependencies.authRepository,
        pending: PendingActionStore(),
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenForSessionExpiry(_dependencies.credentialRepository);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        DioClientFactory.showBubbleIfEnabled();
        unawaited(_externalActions.start());
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_externalActions.drain());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sessionExpirySubscription?.cancel();
    super.dispose();
  }

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
      _externalActions = _makeExternalActions(replacement);
      _configurationRevision++;
    });
    _listenForSessionExpiry(replacement.credentialRepository);
    unawaited(_externalActions.start());
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = _dependencies;
    return ServerConfigScope(
      apply: _applyServerConfig,
      child: MultiRepositoryProvider(
        key: ValueKey(_configurationRevision),
        providers: [
          RepositoryProvider<ExternalActionHandler>.value(
            value: _externalActions,
          ),
          RepositoryProvider<AuthRepository>(
            create: (_) => dependencies.authRepository,
          ),
          RepositoryProvider<AuthPreferenceRepository>(
            create: (_) => dependencies.authPreferenceRepository,
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
          RepositoryProvider<HrRequestRepository>(
            create: (_) => dependencies.hrRequestRepository,
          ),
          RepositoryProvider<OutlookRepository>(
            create: (_) => dependencies.outlookRepository,
          ),
          RepositoryProvider<SpeechToTextRepository>(
            create: (_) => dependencies.speechToTextRepository,
            dispose: (repository) => unawaited(repository.close()),
          ),
          RepositoryProvider<TextToSpeechRepository>.value(
            value: dependencies.textToSpeechRepository,
          ),
          RepositoryProvider<VoiceAssistantChatRepository>.value(
            value: dependencies.voiceAssistantChatRepository,
          ),
          RepositoryProvider<ServerConfigRepository>.value(
            value: dependencies.serverConfigRepository,
          ),
          RepositoryProvider<DataRefreshCoordinator>(
            create: (_) => dependencies.dataRefreshCoordinator,
            dispose: (coordinator) => unawaited(coordinator.close()),
          ),
          RepositoryProvider<DeviceCalendarService>.value(
            value: dependencies.deviceCalendarService,
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => BlocProvider(
            create: (_) =>
                ChatTextSizeCubit(dependencies.chatTextSizeRepository)..load(),
            child: OverlaySupport(
              child: MaterialApp.router(
                title: AppConstants.chatbotName,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.light,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                routerConfig: appRouter,
                builder: (context, child) =>
                    child ?? const SizedBox.shrink(),
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
        ),
      ),
    );
  }
}
