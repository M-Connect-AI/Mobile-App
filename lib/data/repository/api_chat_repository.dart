import '../../domain/model/chat_message.dart';
import '../../domain/model/chat_stream_event.dart';
import '../../domain/model/chat_thread.dart';
import '../../domain/repository/chat_repository.dart';
import '../../domain/repository/chat_thread_repository.dart';
import '../../domain/repository/credential_repository.dart';
import '../../domain/service/session_expiry.dart';
import '../mapper/chat_result_mapper.dart';
import '../mapper/chat_rich_content_mapper.dart';
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
    ChatConfirmationTool? confirmedTool,
  }) async* {
    final token = await _accessToken();
    ChatResultPreviewHint? previewHint;
    try {
      await for (final event in _remote.streamTurn(
        token,
        ChatTurnRequestDto(
          message: message,
          threadId: threadId,
          confirm: confirm ? true : null,
        ),
      )) {
        if (event is AgentStatusEvent) {
          previewHint ??= _previewHint(event.label);
        }
        yield switch (event) {
          AgentStatusEvent() => ChatStreamStatus(event.label),
          AgentTokenEvent() => ChatStreamToken(event.text),
          AgentConfirmationEvent() => ChatStreamConfirmation(
            _mapConfirmation(event.confirmation),
          ),
          AgentResultEvent() => ChatStreamResult(
            ChatResultMapper.map(
              event.executed,
              confirmedTool: confirm ? confirmedTool : null,
              previewHint: previewHint,
            ),
          ),
          AgentDoneEvent() => _mapDone(event.done),
          AgentErrorEvent() => ChatStreamFailure(event.message),
          AgentInterruptedEvent() => const ChatStreamFailure(
            'Kết nối bị gián đoạn. Hãy tải lại hội thoại trước khi thử lại.',
            interrupted: true,
          ),
        };
      }
    } on AgentRemoteException catch (error) {
      await _handleRemoteError(error, token);
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
      await _handleRemoteError(error, token);
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
            uiAction: ChatRichContentMapper.mapAction(
              detail.messages[index].uiAction,
            ),
            blocks: ChatRichContentMapper.mapBlocks(
              detail.messages[index].blocks,
            ),
            highlights: ChatRichContentMapper.mapHighlights(
              detail.messages[index].highlights,
              detail.messages[index].content,
            ),
            suggestions: ChatRichContentMapper.mapSuggestions(
              detail.messages[index].suggestions,
            ),
            executedResult: ChatResultMapper.mapJiraBlocks(
              ChatRichContentMapper.mapBlocks(detail.messages[index].blocks),
            ),
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
      await _handleRemoteError(error, token);
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
      network: error.type == AgentRemoteErrorType.network,
    );
  }

  Future<Never> _handleRemoteError(
    AgentRemoteException error,
    String accessToken,
  ) async {
    if (error.type == AgentRemoteErrorType.unauthorized) {
      await expireSessionForToken(_sessions, accessToken);
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
      'create_outlook_event' when _matchesOutlookEventArgs(args) =>
        ChatConfirmationTool.createOutlookEvent,
      'reply_outlook_mail'
          when _matchesArgs(
            args,
            requiredStrings: const {'messageId', 'comment'},
          ) =>
        ChatConfirmationTool.replyOutlookMail,
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

  bool _matchesOutlookEventArgs(Map<String, dynamic> args) {
    const stringKeys = {
      'subject',
      'start',
      'end',
      'timeZone',
      'location',
      'body',
    };
    const allowedKeys = {...stringKeys, 'isAllDay', 'attendees'};
    if (args.keys.any((key) => !allowedKeys.contains(key)) ||
        !_isNonEmptyString(args['subject']) ||
        !_isNonEmptyString(args['start'])) {
      return false;
    }
    for (final key in stringKeys.difference(const {'subject', 'start'})) {
      if (args.containsKey(key) && !_isNonEmptyString(args[key])) return false;
    }
    if (args.containsKey('isAllDay') && args['isAllDay'] is! bool) {
      return false;
    }
    final attendees = args['attendees'];
    return attendees == null ||
        (attendees is List && attendees.every(_isNonEmptyString));
  }

  bool _isNonEmptyString(Object? value) =>
      value is String && value.trim().isNotEmpty;

  ChatStreamDone _mapDone(ChatDoneDto done) {
    final blocks = ChatRichContentMapper.mapBlocks(done.blocks);
    return ChatStreamDone(
      threadId: done.threadId,
      reply: done.reply,
      confirmation: done.confirm == null
          ? null
          : _mapConfirmation(done.confirm!),
      uiAction: ChatRichContentMapper.mapAction(done.uiAction),
      blocks: blocks,
      highlights: ChatRichContentMapper.mapHighlights(
        done.highlights,
        done.reply,
      ),
      suggestions: ChatRichContentMapper.mapSuggestions(done.suggestions),
      previewResult: ChatResultMapper.mapJiraBlocks(blocks),
      didMutate: done.didMutate,
      citations: done.citations,
    );
  }

  ChatResultPreviewHint? _previewHint(String label) => switch (label.trim()) {
    'Đang tra cứu đơn nghỉ phép…' => ChatResultPreviewHint.leaveList,
    'Đang tra cứu công tác…' => ChatResultPreviewHint.tripList,
    'Đang tổng hợp công việc Jira…' ||
    'Đang tra cứu task Jira…' ||
    'Đang phân tích backlog Jira…' => ChatResultPreviewHint.jiraIssues,
    _ => null,
  };

  @override
  void close() => _remote.close();
}
