import 'package:chatbot_project/data/repository/preview_voice_assistant_chat_repository.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns a local preview reply without a chat API dependency', () async {
    await S.load(const Locale('vi'));
    const repository = PreviewVoiceAssistantChatRepository();

    final events = await repository
        .sendMessage(message: 'Nội dung thử')
        .toList();

    expect(events, hasLength(2));
    expect(events.first, isA<ChatStreamToken>());
    final done = events.last as ChatStreamDone;
    expect(done.reply, isNotEmpty);
    expect(done.threadId, isEmpty);
  });
}
