import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/chat_text_size_repository.dart';

class ChatTextSizeCubit extends Cubit<int> {
  ChatTextSizeCubit(this._repository) : super(defaultSize);

  static const minSize = 12;
  static const maxSize = 24;
  static const defaultSize = 16;

  final ChatTextSizeRepository _repository;
  int _revision = 0;
  Future<void> _lastWrite = Future<void>.value();

  Future<void> load() async {
    final revision = _revision;
    try {
      final saved = await _repository.read();
      if (!isClosed && revision == _revision && saved != null) {
        emit(saved.clamp(minSize, maxSize));
      }
    } on Object {
      // Keep the readable default when local storage is unavailable.
    }
  }

  void update(int size) {
    _revision++;
    emit(size.clamp(minSize, maxSize));
  }

  Future<bool> save() async {
    final size = state;
    final write = _lastWrite.then((_) => _repository.save(size));
    _lastWrite = write.catchError((Object _) {});
    try {
      await write;
      return true;
    } on Object {
      return false;
    }
  }
}
