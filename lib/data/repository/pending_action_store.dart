import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/model/pending_action.dart';

class PendingActionStore {
  PendingActionStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'pending_external_action';
  final FlutterSecureStorage _storage;

  Future<void> save(PendingAction action) => _storage.write(
    key: _key,
    value: jsonEncode({
      'type': action.type.name,
      'parameters': action.parameters,
    }),
  );

  Future<PendingAction?> peek() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final type = PendingActionType.values
          .where((item) => item.name == json['type'])
          .firstOrNull;
      if (type == null) return null;
      final parameters = json['parameters'];
      return PendingAction(
        type: type,
        parameters: parameters is Map<String, dynamic> ? parameters : const {},
      );
    } on Object {
      return null;
    }
  }

  Future<PendingAction?> consume() async {
    final action = await peek();
    await clear();
    return action;
  }

  Future<void> clear() => _storage.delete(key: _key);
}
