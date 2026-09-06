import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/repository/api_chat_repository.dart';
import '../data/repository/auth/api_auth_repository.dart';
import '../data/repository/auth/secure_credential_repository.dart';
import '../data/repository/device_speech_to_text_repository.dart';
import '../data/repository/home/api_home_repository.dart';
import '../data/source/remote/agent_chat_remote_data_source.dart';
import '../data/source/remote/client/dio_client_factory.dart';
import '../data/source/remote/auth_remote_data_source.dart';
import '../data/source/remote/home_remote_data_source.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/chat_thread_repository.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/credential_repository.dart';
import '../domain/repository/home_repository.dart';
import '../domain/repository/speech_to_text_repository.dart';

class AppDependencies {
  const AppDependencies({
    required this.authRepository,
    required this.credentialRepository,
    required this.chatRepository,
    required this.chatThreadRepository,
    required this.homeRepository,
    required this.speechToTextRepository,
  });

  final AuthRepository authRepository;
  final CredentialRepository credentialRepository;
  final ChatRepository chatRepository;
  final ChatThreadRepository chatThreadRepository;
  final HomeRepository homeRepository;
  final SpeechToTextRepository speechToTextRepository;

  factory AppDependencies.fromEnvironment() {
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

    final credentialRepository = SecureCredentialRepository();
    final chatRepository = ApiChatRepository(
      AgentChatRemoteDataSource(
        baseUrl: agentBaseUrl,
        dio: DioClientFactory.create(),
      ),
      credentialRepository,
    );
    return AppDependencies(
      authRepository: ApiAuthRepository(
        AuthRemoteDataSource(
          baseUrl: hrBaseUrl,
          dio: DioClientFactory.create(),
        ),
      ),
      credentialRepository: credentialRepository,
      chatRepository: chatRepository,
      chatThreadRepository: chatRepository,
      homeRepository: ApiHomeRepository(
        HomeRemoteDataSource(baseUrl: hrBaseUrl),
        credentialRepository,
      ),
      speechToTextRepository: DeviceSpeechToTextRepository(),
    );
  }
}
