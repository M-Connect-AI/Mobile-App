import 'dart:async';

import 'package:flutter/services.dart';

import '../../data/repository/pending_action_store.dart';
import '../../domain/model/pending_action.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/credential_repository.dart';
import '../../generated/l10n.dart';
import '../../presentation/pages/chat/create_leave_prompt.dart';
import '../../route/go_router.dart';
import 'deep_link_parser.dart';
import 'external_chat_launch.dart';

class ExternalActionHandler {
  ExternalActionHandler({
    required this.credentials,
    required this.auth,
    required this.pending,
    MethodChannel? channel,
  }) : _channel =
           channel ?? const MethodChannel('com.mconnect/external_action');

  final CredentialRepository credentials;
  final AuthRepository auth;
  final PendingActionStore pending;
  final MethodChannel _channel;
  bool _handling = false;
  String? _lastRaw;
  DateTime? _lastReceivedAt;

  Future<void> start() async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'externalActionAvailable') await drain();
    });
    await drain();
  }

  Future<void> drain() async {
    if (_handling) return;
    _handling = true;
    try {
      while (true) {
        final entries =
            await _channel.invokeListMethod<dynamic>('takePendingEntries') ??
            [];
        if (entries.isEmpty) break;
        for (final entry in entries) {
          if (entry is String) {
            await handle(entry);
          } else if (entry is Map) {
            final url = entry['url'];
            if (url is String) {
              await handle(url);
            } else {
              final action = parseNativeAction(entry);
              if (action != null) await _handleAction(action);
            }
          }
        }
      }
    } on MissingPluginException {
      // Other platforms do not have the iOS entry point.
    } finally {
      _handling = false;
    }
  }

  Future<void> handle(String raw) async {
    final now = DateTime.now();
    if (raw == _lastRaw &&
        _lastReceivedAt != null &&
        now.difference(_lastReceivedAt!) < const Duration(seconds: 1)) {
      return;
    }
    _lastRaw = raw;
    _lastReceivedAt = now;
    final action = parseDeepLink(raw);
    if (action != null) await _handleAction(action);
  }

  Future<void> _handleAction(PendingAction action) async {
    await pending.save(action);
    try {
      final session = await credentials.read();
      if (session == null || session.accessToken.trim().isEmpty) {
        appRouter.go(const LoginRoute().location);
        return;
      }
      await auth.getProfile(session.accessToken);
      await resumePending();
    } on Object {
      appRouter.go(const LoginRoute().location);
    }
  }

  Future<void> resumePending() async {
    final action = await pending.consume();
    if (action == null) return;
    final uri = switch (action.type) {
      PendingActionType.createLeave => Uri(path: ChatRoute.path),
      PendingActionType.openAssistant => Uri(path: HomeChatAiRoute.path),
      PendingActionType.askAssistant => Uri(path: ChatRoute.path),
    };
    appRouter.go(
      uri.toString(),
      extra: switch (action.type) {
        PendingActionType.createLeave => ExternalChatLaunch(
          createLeavePrompt(action, S.current),
        ),
        PendingActionType.askAssistant => ExternalChatLaunch(
          action.parameters['message'] as String,
        ),
        PendingActionType.openAssistant => null,
      },
    );
  }
}
