import '../model/auth_session.dart';

abstract interface class CredentialRepository {
  Future<AuthSession?> read();

  Future<void> save(AuthSession session, {required bool persist});

  Future<void> clear();
}
