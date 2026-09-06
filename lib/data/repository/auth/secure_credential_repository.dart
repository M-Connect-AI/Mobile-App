import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/model/auth_session.dart';
import '../../../domain/repository/credential_repository.dart';

class SecureCredentialRepository implements CredentialRepository {
  SecureCredentialRepository({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static const _sessionKey = 'auth_session';
  static const _legacyEmailKey = 'login_email';
  static const _legacyPasswordKey = 'login_password';

  final FlutterSecureStorage _storage;
  AuthSession? _currentSession;

  @override
  Future<AuthSession?> read() async {
    if (_currentSession case final session?) return session;
    final value = await _storage.read(key: _sessionKey);
    await _clearLegacyCredentials();
    if (value == null || value.isEmpty) return null;
    try {
      final session = AuthSession.fromJson(
        Map<String, dynamic>.from(jsonDecode(value) as Map),
      );
      _currentSession = session;
      return session;
    } on Object {
      await clear();
      return null;
    }
  }

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {
    _currentSession = session;
    if (persist) {
      await _storage.write(
        key: _sessionKey,
        value: jsonEncode(session.toJson()),
      );
    } else {
      await _storage.delete(key: _sessionKey);
    }
    await _clearLegacyCredentials();
  }

  @override
  Future<void> clear() async {
    _currentSession = null;
    await _storage.delete(key: _sessionKey);
    await _clearLegacyCredentials();
  }

  Future<void> _clearLegacyCredentials() async {
    await _storage.delete(key: _legacyEmailKey);
    await _storage.delete(key: _legacyPasswordKey);
  }
}
