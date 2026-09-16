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
          AgentStatusEvent() => ChatStreamStatus(event.label),
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
        tool: _mapConfirmationTool(dto.tool, dto.args),
        args: Map<String, dynamic>.unmodifiable(dto.args),
        summary: dto.summary,
      );

  ChatConfirmationTool _mapConfirmationTool(
    String tool,
    Map<String, dynamic> args,
  ) {
    final mapped = switch (tool) {
      'create_leave'
          when _matchesArgs(
            args,
            requiredStrings: const {'type', 'from', 'to', 'reason'},
          ) =>
        ChatConfirmationTool.createLeave,
      'create_trip'
          when _matchesArgs(
            args,
            requiredStrings: const {'destination', 'from', 'to', 'purpose'},
          ) =>
        ChatConfirmationTool.createTrip,
      'cancel_leave' when _matchesArgs(args, requiredStrings: const {'id'}) =>
        ChatConfirmationTool.cancelLeave,
      'update_leave'
          when _matchesArgs(
            args,
            requiredStrings: const {'id'},
            optionalStrings: const {'type', 'from', 'to', 'reason'},
            requireOptionalValue: true,
          ) =>
        ChatConfirmationTool.updateLeave,
      'approve_leaves' when _matchesIdListArgs(args) =>
        ChatConfirmationTool.approveLeaves,
      'reject_leaves' when _matchesIdListArgs(args) =>
        ChatConfirmationTool.rejectLeaves,
      'approve_trips' when _matchesIdListArgs(args) =>
        ChatConfirmationTool.approveTrips,
      'reject_trips' when _matchesIdListArgs(args) =>
        ChatConfirmationTool.rejectTrips,
      'create_jira_task' when _matchesJiraArgs(args) =>
        ChatConfirmationTool.createJiraTask,
      _ => ChatConfirmationTool.unknown,
    };
    return mapped;
  }

  bool _matchesArgs(
    Map<String, dynamic> args, {
    required Set<String> requiredStrings,
    Set<String> optionalStrings = const {},
    bool requireOptionalValue = false,
  }) {
    final allowedKeys = {...requiredStrings, ...optionalStrings};
    if (args.keys.any((key) => !allowedKeys.contains(key))) return false;
    if (requiredStrings.any((key) => !_isNonEmptyString(args[key]))) {
      return false;
    }
    final suppliedOptionalKeys = optionalStrings.where(args.containsKey);
    if (suppliedOptionalKeys.any((key) => !_isNonEmptyString(args[key]))) {
      return false;
    }
    return !requireOptionalValue || suppliedOptionalKeys.isNotEmpty;
  }

  bool _matchesIdListArgs(Map<String, dynamic> args) {
    if (args.length != 1 || !args.containsKey('ids')) return false;
    final ids = args['ids'];
    return ids is List && ids.isNotEmpty && ids.every(_isNonEmptyString);
  }

  bool _matchesJiraArgs(Map<String, dynamic> args) {
    const stringKeys = {
      'projectKey',
      'summary',
      'description',
      'issueType',
      'priority',
      'dueDate',
    };
    const allowedKeys = {...stringKeys, 'labels', 'assignToSprint'};
    if (args.keys.any((key) => !allowedKeys.contains(key)) ||
        !_isNonEmptyString(args['projectKey']) ||
        !_isNonEmptyString(args['summary'])) {
      return false;
    }
    for (final key in stringKeys.difference(const {'projectKey', 'summary'})) {
      if (args.containsKey(key) && !_isNonEmptyString(args[key])) return false;
    }
    if (args.containsKey('labels')) {
      final labels = args['labels'];
      if (labels is! List || !labels.every(_isNonEmptyString)) return false;
    }
    return !args.containsKey('assignToSprint') ||
        args['assignToSprint'] is bool;
  }

  bool _isNonEmptyString(Object? value) =>
      value is String && value.trim().isNotEmpty;

  @override
  void close() => _remote.close();
}
