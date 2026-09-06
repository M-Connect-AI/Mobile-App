import 'package:chatbot_project/data/model/chat/chat_api_models.dart';
import 'package:chatbot_project/data/repository/api_chat_repository.dart';
import 'package:chatbot_project/data/source/remote/agent_chat_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_stream_event.dart';
import 'package:chatbot_project/domain/repository/chat_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps thread list and detail with pending confirmation', () async {
    final repository = ApiChatRepository(_FakeAgentRemote(), _SessionStore());

    final threads = await repository.getThreads();
    final detail = await repository.getThread('thread-1');

    expect(threads.single.threadId, 'thread-1');
    expect(detail.messages, hasLength(2));
    expect(
      detail.messages.last.confirmation?.tool,
      ChatConfirmationTool.createLeave,
    );
  });

  test('maps all SSE event types and keeps server thread id', () async {
    final repository = ApiChatRepository(_FakeAgentRemote(), _SessionStore());

    final events = await repository
        .sendMessage(message: 'Tạo đơn', threadId: 'thread-1')
        .toList();

    expect(events[0], const ChatStreamToken('Xin chào'));
    expect(events[1], isA<ChatStreamConfirmation>());
    expect(events[2], isA<ChatStreamResult>());
    expect(
      events[3],
      const ChatStreamDone(
        threadId: 'server-thread',
        citations: ['Quy định nghỉ phép'],
      ),
    );
  });

  test('clears session when Agent returns 401', () async {
    final sessions = _SessionStore();
    final repository = ApiChatRepository(
      _FakeAgentRemote(
        error: const AgentRemoteException(
          type: AgentRemoteErrorType.unauthorized,
          message: 'expired',
        ),
      ),
      sessions,
    );

    await expectLater(
      repository.getThreads(),
      throwsA(
        isA<ChatRepositoryException>().having(
          (error) => error.sessionExpired,
          'sessionExpired',
          isTrue,
        ),
      ),
    );
    expect(sessions.cleared, isTrue);
  });
}

class _FakeAgentRemote extends AgentChatRemoteDataSource {
  _FakeAgentRemote({this.error}) : super(baseUrl: 'http://unused');

  final AgentRemoteException? error;

  void _throwIfNeeded() {
    final failure = error;
    if (failure != null) throw failure;
  }

  @override
  Future<List<ChatThreadSummaryDto>> getThreads(String accessToken) async {
    _throwIfNeeded();
    return const [
      ChatThreadSummaryDto(
        threadId: 'thread-1',
        title: 'Đơn nghỉ phép',
        preview: 'Tạo đơn nghỉ phép',
        updatedAt: '2026-09-06T01:00:00.000Z',
      ),
    ];
  }

  @override
  Future<ChatThreadDetailDto> getThread(
    String accessToken,
    String threadId,
  ) async {
    _throwIfNeeded();
    return const ChatThreadDetailDto(
      threadId: 'thread-1',
      messages: [
        PersistedChatMessageDto(role: 'user', content: 'Tạo đơn'),
        PersistedChatMessageDto(role: 'assistant', content: 'Xác nhận?'),
      ],
      pendingAction: ChatConfirmationDto(
        tool: 'create_leave',
        args: {'type': 'ANNUAL'},
        summary: 'Gửi đơn nghỉ phép',
      ),
    );
  }

  @override
  Stream<AgentSseEvent> streamTurn(
    String accessToken,
    ChatTurnRequestDto request,
  ) async* {
    _throwIfNeeded();
    yield const AgentTokenEvent('Xin chào');
    yield const AgentConfirmationEvent(
      ChatConfirmationDto(
        tool: 'create_leave',
        args: {'type': 'ANNUAL'},
        summary: 'Gửi đơn nghỉ phép',
      ),
    );
    yield const AgentResultEvent({'_id': 'leave-id'});
    yield const AgentDoneEvent(
      threadId: 'server-thread',
      citations: ['Quy định nghỉ phép'],
    );
  }
}

class _SessionStore implements CredentialRepository {
  _SessionStore();

  bool cleared = false;
  AuthSession? session = _session;

  @override
  Future<void> clear() async {
    cleared = true;
    session = null;
  }

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async =>
      session = value;
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'id',
    employeeCode: 'EMP001',
    email: 'a@msb.vn',
    fullName: 'A',
    role: UserRole.staff,
    department: 'D',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
