import 'dart:async';

import '../model/chat_result.dart';

class DataRefreshCoordinator {
  final StreamController<Set<DataRefreshScope>> _controller =
      StreamController<Set<DataRefreshScope>>.broadcast();

  Stream<Set<DataRefreshScope>> get changes => _controller.stream;

  final Set<DataRefreshScope> _pendingScopes = {};
  Timer? _flushTimer;

  void notify(Set<DataRefreshScope> scopes) {
    if (scopes.isEmpty || _controller.isClosed) return;
    _pendingScopes.addAll(scopes);
    _flushTimer ??= Timer(Duration.zero, _flush);
  }

  void _flush() {
    _flushTimer = null;
    if (_pendingScopes.isEmpty || _controller.isClosed) return;
    final scopes = Set<DataRefreshScope>.unmodifiable(_pendingScopes);
    _pendingScopes.clear();
    _controller.add(scopes);
  }

  Future<void> close() async {
    _flushTimer?.cancel();
    _flushTimer = null;
    _pendingScopes.clear();
    await _controller.close();
  }
}
