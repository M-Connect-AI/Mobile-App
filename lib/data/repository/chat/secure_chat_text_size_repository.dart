import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/repository/chat_text_size_repository.dart';

class SecureChatTextSizeRepository implements ChatTextSizeRepository {
  SecureChatTextSizeRepository({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static const _key = 'chat_text_size';

  final FlutterSecureStorage _storage;

  @override
  Future<int?> read() async =>
      int.tryParse(await _storage.read(key: _key) ?? '');

  @override
  Future<void> save(int size) =>
      _storage.write(key: _key, value: size.toString());
}
