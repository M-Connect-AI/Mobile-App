import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/repository/api_chat_repository.dart';
import '../data/repository/auth/api_auth_repository.dart';
import '../data/repository/auth/secure_credential_repository.dart';
import '../data/repository/secure_server_config_repository.dart';
import '../data/repository/device_speech_to_text_repository.dart';
import '../data/repository/home/api_home_repository.dart';
import '../data/repository/hr/api_hr_request_repository.dart';
import '../data/source/remote/agent_chat_remote_data_source.dart';
import '../data/source/remote/client/dio_client_factory.dart';
import '../data/source/remote/auth_remote_data_source.dart';
import '../data/source/remote/home_remote_data_source.dart';
import '../data/source/remote/hr_request_remote_data_source.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/chat_thread_repository.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/credential_repository.dart';
import '../domain/repository/home_repository.dart';
import '../domain/repository/hr_request_repository.dart';
import '../domain/repository/speech_to_text_repository.dart';
import '../domain/model/server_config.dart';
import '../domain/repository/server_config_repository.dart';

class AppDependencies {
  const AppDependencies({
    required this.authRepository,
    required this.credentialRepository,
    required this.chatRepository,
    required this.chatThreadRepository,
    required this.homeRepository,
    required this.hrRequestRepository,
    required this.speechToTextRepository,
    required this.serverConfigRepository,
    required this.serverConfig,
  });

  final AuthRepository authRepository;
  final CredentialRepository credentialRepository;
  final ChatRepository chatRepository;
  final ChatThreadRepository chatThreadRepository;
  final HomeRepository homeRepository;
  final HrRequestRepository hrRequestRepository;
  final SpeechToTextRepository speechToTextRepository;
  final ServerConfigRepository serverConfigRepository;
  final ServerConfig serverConfig;

  static Future<AppDependencies> fromEnvironment({
    ServerConfigRepository? serverConfigRepository,
  }) async {
    final configuredHrBaseUrl =
        dotenv.maybeGet('HR_API_BASE_URL')?.trim() ?? '';
    final hrBaseUrl = configuredHrBaseUrl.isEmpty
        ? 'http://localhost:3002'
        : configuredHrBaseUrl;
    final configuredAgentBaseUrl =
        dotenv.maybeGet('AGENT_API_BASE_URL')?.trim() ?? '';
    final agentBaseUrl = configuredAgentBaseUrl.isEmpty
        ? 'http://localhost:3001'
        : configuredAgentBaseUrl;

    final configRepository =
        serverConfigRepository ??
        SecureServerConfigRepository(
          defaults: ServerConfig(
            hrApiBaseUrl: hrBaseUrl,
            agentApiBaseUrl: agentBaseUrl,
          ),
        );
    final serverConfig = await configRepository.read();

    final credentialRepository = SecureCredentialRepository();
    final chatRepository = ApiChatRepository(
      AgentChatRemoteDataSource(
        baseUrl: serverConfig.agentApiBaseUrl,
        dio: DioClientFactory.create(),
      ),
      credentialRepository,
    );
    return AppDependencies(
      authRepository: ApiAuthRepository(
        AuthRemoteDataSource(
          baseUrl: serverConfig.hrApiBaseUrl,
          dio: DioClientFactory.create(),
        ),
      ),
      credentialRepository: credentialRepository,
      chatRepository: chatRepository,
      chatThreadRepository: chatRepository,
      homeRepository: ApiHomeRepository(
        HomeRemoteDataSource(
          baseUrl: serverConfig.hrApiBaseUrl,
          dio: DioClientFactory.create(),
        ),
        credentialRepository,
      ),
      hrRequestRepository: ApiHrRequestRepository(
        HrRequestRemoteDataSource(
          baseUrl: serverConfig.hrApiBaseUrl,
          dio: DioClientFactory.create(),
        ),
        credentialRepository,
      ),
      speechToTextRepository: DeviceSpeechToTextRepository(),
      serverConfigRepository: configRepository,
      serverConfig: serverConfig,
    );
  }
}
