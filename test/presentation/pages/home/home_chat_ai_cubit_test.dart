import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_chat_ai_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tải lại lịch sử khi một lượt chat hoàn tất', () async {
    final repository = _ChatThreadRepository();
    final coordinator = DataRefreshCoordinator();
    final cubit = HomeChatAiCubit(
      repository,
      _CredentialRepository(),
      refreshCoordinator: coordinator,
    );
    addTearDown(cubit.close);
    addTearDown(coordinator.close);

    await cubit.loadThreads();
    coordinator.notify(const {DataRefreshScope.jira});
    await Future<void>.delayed(Duration.zero);
    expect(repository.calls, 1);

    coordinator.notify(const {DataRefreshScope.chatHistory});
    await Future<void>.delayed(Duration.zero);

    expect(repository.calls, 2);
    expect(cubit.state.status, ChatThreadStatus.success);
    expect(cubit.state.threads, _threads);
  });
}

final _threads = [
  ChatThread(
    threadId: 'thread-1',
    title: 'Lịch sử mới nhất',
    preview: 'Nội dung vừa cập nhật',
    updatedAt: DateTime.utc(2026, 9, 17, 10),
  ),
];

class _ChatThreadRepository implements ChatThreadRepository {
  int calls = 0;

  @override
  Future<List<ChatThread>> getThreads() async {
    calls++;
    return _threads;
  }
}

class _CredentialRepository implements CredentialRepository {
  @override
  Future<void> clear() async {}

  @override
  Future<AuthSession?> read() async => null;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
}
