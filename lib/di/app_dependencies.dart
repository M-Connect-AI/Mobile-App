import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/repository/api_chat_repository.dart';
import '../data/repository/device_speech_to_text_repository.dart';
import '../data/repository/mock_chat_repository.dart';
import '../data/source/remote/client/api_chat_client.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/speech_to_text_repository.dart';
import '../domain/usecase/business_trip_prompt.dart';

class AppDependencies {
  const AppDependencies({
    required this.chatRepository,
    required this.speechToTextRepository,
  });

  final ChatRepository chatRepository;
  final SpeechToTextRepository speechToTextRepository;

  factory AppDependencies.fromEnvironment() {
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

    return AppDependencies(
      chatRepository: chatRepository,
      speechToTextRepository: DeviceSpeechToTextRepository(),
    );
  }
}
