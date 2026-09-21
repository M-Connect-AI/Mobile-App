import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/model/auth_session.dart';
import '../../../domain/repository/auth_preference_repository.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/service/session_expiry.dart';
import '../../source/remote/client/dio_client_factory.dart';

class SecureCredentialRepository
    implements CredentialRepository, AuthPreferenceRepository, SessionExpiry {
  SecureCredentialRepository({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static const _sessionKey = 'auth_session';
  static const _lastEmailKey = 'last_login_email';
  static const _autoLoginEnabledKey = 'auto_login_enabled';
  static const _aliceBubbleEnabledKey = 'alice_bubble_enabled';
  static const _legacyEmailKey = 'login_email';
  static const _legacyPasswordKey = 'login_password';

  final FlutterSecureStorage _storage;
  AuthSession? _currentSession;
  final _expired = StreamController<void>.broadcast();

  @override
  Stream<void> get onSessionExpired => _expired.stream;

  @override
  Future<void> expireSession(String accessToken) async {
    final current = await read();
    if (current == null || current.accessToken != accessToken) return;
    await clear();
    _expired.add(null);
  }

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

  @override
  Future<String?> readLastEmail() async {
    final email = (await _storage.read(key: _lastEmailKey))?.trim();
    return email == null || email.isEmpty ? null : email;
  }

  @override
  Future<void> saveLastEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return;
    await _storage.write(key: _lastEmailKey, value: normalizedEmail);
  }

  @override
  Future<bool> readAutoLoginEnabled() async =>
      await _storage.read(key: _autoLoginEnabledKey) == 'true';

  @override
  Future<void> setAutoLoginEnabled(bool enabled) =>
      _storage.write(key: _autoLoginEnabledKey, value: enabled.toString());

  @override
  Future<bool> readAliceBubbleEnabled() async =>
      await _storage.read(key: _aliceBubbleEnabledKey) == 'true';

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async {
    await _storage.write(
      key: _aliceBubbleEnabledKey,
      value: enabled.toString(),
    );
    DioClientFactory.setBubbleEnabled(enabled);
  }

  Future<void> _clearLegacyCredentials() async {
    await _storage.delete(key: _legacyEmailKey);
    await _storage.delete(key: _legacyPasswordKey);
  }
}
