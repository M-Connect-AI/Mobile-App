import 'package:chatbot_project/data/model/chat/chat_api_models.dart';
import 'package:chatbot_project/data/repository/api_chat_repository.dart';
import 'package:chatbot_project/data/source/remote/agent_chat_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
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

  test(
    'restores every supported pending action with its exact summary',
    () async {
      final cases =
          <
            ({
              String wireName,
              ChatConfirmationTool tool,
              Map<String, dynamic> args,
              String summary,
            })
          >[
            (
              wireName: 'create_leave',
              tool: ChatConfirmationTool.createLeave,
              args: {
                'type': 'ANNUAL',
                'from': '2026-09-20',
                'to': '2026-09-21',
                'reason': 'Nghỉ phép',
              },
              summary: 'Tạo đơn nghỉ phép',
            ),
            (
              wireName: 'create_trip',
              tool: ChatConfirmationTool.createTrip,
              args: {
                'destination': 'Đà Nẵng',
                'from': '2026-09-20',
                'to': '2026-09-21',
                'purpose': 'Gặp khách hàng',
              },
              summary: 'Tạo đơn công tác',
            ),
            (
              wireName: 'cancel_leave',
              tool: ChatConfirmationTool.cancelLeave,
              args: {'id': 'leave-1'},
              summary: 'Hủy đơn nghỉ phép',
            ),
            (
              wireName: 'update_leave',
              tool: ChatConfirmationTool.updateLeave,
              args: {'id': 'leave-1', 'reason': 'Lý do mới'},
              summary: 'Sửa đơn nghỉ phép',
            ),
            (
              wireName: 'approve_leaves',
              tool: ChatConfirmationTool.approveLeaves,
              args: {
                'ids': ['leave-1'],
              },
              summary: 'Phê duyệt đơn nghỉ phép',
            ),
            (
              wireName: 'reject_leaves',
              tool: ChatConfirmationTool.rejectLeaves,
              args: {
                'ids': ['leave-1'],
              },
              summary: 'Từ chối đơn nghỉ phép',
            ),
            (
              wireName: 'approve_trips',
              tool: ChatConfirmationTool.approveTrips,
              args: {
                'ids': ['trip-1'],
              },
              summary: 'Phê duyệt đơn công tác',
            ),
            (
              wireName: 'reject_trips',
              tool: ChatConfirmationTool.rejectTrips,
              args: {
                'ids': ['trip-1'],
              },
              summary: 'Từ chối đơn công tác',
            ),
            (
              wireName: 'create_jira_task',
              tool: ChatConfirmationTool.createJiraTask,
              args: {
                'projectKey': 'SCRUM',
                'summary': 'Hoàn thiện SSE',
                'issueType': 'Task',
                'priority': 'High',
                'dueDate': '2026-09-30',
                'description': 'Khôi phục compatibility',
                'labels': ['mobile'],
                'assignToSprint': false,
              },
              summary: 'Tạo Jira task',
            ),
          ];

      for (final item in cases) {
        final repository = ApiChatRepository(
          _FakeAgentRemote(
            pendingAction: ChatConfirmationDto(
              tool: item.wireName,
              args: item.args,
              summary: item.summary,
            ),
          ),
          _SessionStore(),
        );

        final detail = await repository.getThread('thread-1');
        final action = detail.pendingAction!;

        expect(action.tool, item.tool, reason: item.wireName);
        expect(action.args, item.args, reason: item.wireName);
        expect(action.summary, item.summary, reason: item.wireName);
        expect(action.canExecute, isTrue, reason: item.wireName);
        expect(detail.messages.last.confirmation, action);
      }
    },
  );

  test('fails closed for future tools and malformed known arguments', () async {
    final cases = [
      const ChatConfirmationDto(
        tool: 'future_privileged_tool',
        args: {'id': 'resource-1'},
        summary: 'Future action',
      ),
      const ChatConfirmationDto(
        tool: 'approve_trips',
        args: {'ids': <String>[]},
        summary: 'Malformed current action',
      ),
    ];

    for (final pendingAction in cases) {
      final repository = ApiChatRepository(
        _FakeAgentRemote(pendingAction: pendingAction),
        _SessionStore(),
      );
      final detail = await repository.getThread('thread-1');

      expect(detail.pendingAction?.tool, ChatConfirmationTool.unknown);
      expect(detail.pendingAction?.canExecute, isFalse);
    }
  });

  test('maps all SSE event types and keeps server thread id', () async {
    final repository = ApiChatRepository(_FakeAgentRemote(), _SessionStore());

    final events = await repository
        .sendMessage(message: 'Tạo đơn', threadId: 'thread-1')
        .toList();

    expect(events[0], const ChatStreamStatus('Đang xử lý…'));
    expect(events[1], const ChatStreamToken('Xin chào'));
    expect(events[2], isA<ChatStreamConfirmation>());
    expect(events[3], isA<ChatStreamResult>());
    expect(
      events[4],
      const ChatStreamDone(
        threadId: 'server-thread',
        citations: ['Quy định nghỉ phép'],
      ),
    );
  });

  test('uses confirmed tool context to mark a typed mutation', () async {
    final repository = ApiChatRepository(
      _FakeAgentRemote(executed: _leaveResult),
      _SessionStore(),
    );

    final events = await repository
        .sendMessage(
          message: 'Xác nhận',
          threadId: 'thread-1',
          confirm: true,
          confirmedTool: ChatConfirmationTool.createLeave,
        )
        .toList();
    final result = events.whereType<ChatStreamResult>().single.result;

    expect(result, isA<ChatLeaveMutationResult>());
    expect(result.isMutation, isTrue);
  });

  test('uses Jira runtime status to type an empty Jira preview', () async {
    final repository = ApiChatRepository(
      _FakeAgentRemote(
        statusLabel: 'Đang tra cứu task Jira…',
        executed: const <Object>[],
      ),
      _SessionStore(),
    );

    final events = await repository
        .sendMessage(message: 'Task của tôi')
        .toList();
    final result = events.whereType<ChatStreamResult>().single.result;

    expect(result, isA<ChatJiraIssuesResult>());
    expect((result as ChatJiraIssuesResult).data.issues, isEmpty);
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
  _FakeAgentRemote({
    this.error,
    this.pendingAction,
    this.executed,
    this.statusLabel = 'Đang xử lý…',
  }) : super(baseUrl: 'http://unused');

  final AgentRemoteException? error;
  final ChatConfirmationDto? pendingAction;
  final Object? executed;
  final String statusLabel;

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
    return ChatThreadDetailDto(
      threadId: 'thread-1',
      messages: [
        PersistedChatMessageDto(role: 'user', content: 'Tạo đơn'),
        PersistedChatMessageDto(role: 'assistant', content: 'Xác nhận?'),
      ],
      pendingAction:
          pendingAction ??
          const ChatConfirmationDto(
            tool: 'create_leave',
            args: {
              'type': 'ANNUAL',
              'from': '2026-09-20',
              'to': '2026-09-21',
              'reason': 'Nghỉ phép',
            },
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
    yield AgentStatusEvent(statusLabel);
    yield const AgentTokenEvent('Xin chào');
    yield const AgentConfirmationEvent(
      ChatConfirmationDto(
        tool: 'create_leave',
        args: {
          'type': 'ANNUAL',
          'from': '2026-09-20',
          'to': '2026-09-21',
          'reason': 'Nghỉ phép',
        },
        summary: 'Gửi đơn nghỉ phép',
      ),
    );
    yield AgentResultEvent(executed ?? const {'_id': 'leave-id'});
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

const _leaveResult = <String, dynamic>{
  '_id': 'leave-id',
  'employeeCode': 'EMP001',
  'type': 'ANNUAL',
  'from': '2026-09-20',
  'to': '2026-09-20',
  'days': 1,
  'reason': 'Nghỉ phép',
  'status': 'PENDING',
};
