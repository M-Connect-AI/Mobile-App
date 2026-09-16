import 'dart:async';

import '../model/chat_result.dart';

class DataRefreshCoordinator {
  final StreamController<Set<DataRefreshScope>> _controller =
      StreamController<Set<DataRefreshScope>>.broadcast();

  Stream<Set<DataRefreshScope>> get changes => _controller.stream;

  void notify(Set<DataRefreshScope> scopes) {
    if (scopes.isNotEmpty && !_controller.isClosed) {
      _controller.add(Set.unmodifiable(scopes));
    }
  }

  Future<void> close() => _controller.close();
}
