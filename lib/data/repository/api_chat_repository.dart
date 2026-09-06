import '../../domain/model/chat_message.dart';
import '../../domain/model/chat_stream_event.dart';
import '../../domain/model/chat_thread.dart';
import '../../domain/repository/chat_repository.dart';
import '../../domain/repository/chat_thread_repository.dart';
import '../../domain/repository/credential_repository.dart';
import '../model/chat/chat_api_models.dart';
import '../source/remote/agent_chat_remote_data_source.dart';

class ApiChatRepository implements ChatRepository, ChatThreadRepository {
  const ApiChatRepository(this._remote, this._sessions);

  final AgentChatRemoteDataSource _remote;
  final CredentialRepository _sessions;

  @override
  Stream<ChatStreamEvent> sendMessage({
    required String message,
    String? threadId,
    bool confirm = false,
  }) async* {
    final token = await _accessToken();
    try {
      await for (final event in _remote.streamTurn(
        token,
        ChatTurnRequestDto(
          message: message,
          threadId: threadId,
          confirm: confirm ? true : null,
        ),
      )) {
        yield switch (event) {
          AgentTokenEvent() => ChatStreamToken(event.text),
          AgentConfirmationEvent() => ChatStreamConfirmation(
            _mapConfirmation(event.confirmation),
          ),
          AgentResultEvent() => ChatStreamResult(event.executed),
          AgentDoneEvent() => ChatStreamDone(
            threadId: event.threadId,
            citations: event.citations,
          ),
          AgentErrorEvent() => ChatStreamFailure(event.message),
          AgentInterruptedEvent() => const ChatStreamFailure(
            'Kết nối bị gián đoạn. Hãy tải lại hội thoại trước khi thử lại.',
            interrupted: true,
          ),
        };
      }
    } on AgentRemoteException catch (error) {
      await _handleRemoteError(error);
    }
  }

  @override
  Future<List<ChatThread>> getThreads() async {
    final token = await _accessToken();
    try {
      final items = await _remote.getThreads(token);
      return items
          .map((item) {
            final updatedAt = DateTime.tryParse(item.updatedAt);
            if (updatedAt == null) {
              throw const ChatRepositoryException(
                'Thời gian cập nhật hội thoại không hợp lệ.',
              );
            }
            return ChatThread(
              threadId: item.threadId,
              title: item.title,
              preview: item.preview,
              updatedAt: updatedAt,
            );
          })
          .toList(growable: false);
    } on AgentRemoteException catch (error) {
      await _handleRemoteError(error);
    } catch (error) {
      throw const ChatRepositoryException(
        'Đã xảy ra lỗi khi lấy danh sách hội thoại.',
      );
    }
  }

  @override
  Future<ChatThreadDetail> getThread(String threadId) async {
    final token = await _accessToken();
    try {
      final detail = await _remote.getThread(token, threadId);
      final restoredAt = DateTime.now();
      final messages = <ChatMessage>[
        for (var index = 0; index < detail.messages.length; index++)
          ChatMessage(
            id: 'persisted-$index',
            type: MessageType.text,
            sender: switch (detail.messages[index].role) {
              'user' => MessageSender.user,
              'assistant' => MessageSender.assistant,
              _ => throw const ChatRepositoryException(
                'Vai trò tin nhắn không hợp lệ.',
              ),
            },
            content: detail.messages[index].content,
            createdAt: restoredAt,
            status: MessageStatus.success,
          ),
      ];
      final pending = detail.pendingAction;
      if (pending != null) {
        final lastAssistant = messages.lastIndexWhere(
          (message) => message.sender == MessageSender.assistant,
        );
        if (lastAssistant >= 0) {
          messages[lastAssistant] = messages[lastAssistant].copyWith(
            confirmation: _mapConfirmation(pending),
          );
        }
      }
      return ChatThreadDetail(
        threadId: detail.threadId,
        messages: messages,
        pendingAction: pending == null ? null : _mapConfirmation(pending),
      );
    } on AgentRemoteException catch (error) {
      await _handleRemoteError(error);
    }
  }

  Future<String> _accessToken() async {
    final session = await _sessions.read();
    if (session == null || session.accessToken.isEmpty) {
      throw const ChatRepositoryException(
        'Phiên đăng nhập đã hết hạn.',
        sessionExpired: true,
      );
    }
    return session.accessToken;
  }

  Never _throwMapped(AgentRemoteException error) {
    throw ChatRepositoryException(
      error.message,
      sessionExpired: error.type == AgentRemoteErrorType.unauthorized,
    );
  }

  Future<Never> _handleRemoteError(AgentRemoteException error) async {
    if (error.type == AgentRemoteErrorType.unauthorized) {
      await _sessions.clear();
    }
    _throwMapped(error);
  }

  ChatConfirmAction _mapConfirmation(ChatConfirmationDto dto) =>
      ChatConfirmAction(
        tool: switch (dto.tool) {
          'create_leave' => ChatConfirmationTool.createLeave,
          'create_trip' => ChatConfirmationTool.createTrip,
          'cancel_leave' => ChatConfirmationTool.cancelLeave,
          'approve_leaves' => ChatConfirmationTool.approveLeaves,
          _ => ChatConfirmationTool.unknown,
        },
        args: Map<String, dynamic>.unmodifiable(dto.args),
        summary: dto.summary,
      );

  @override
  void close() => _remote.close();
}
