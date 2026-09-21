import 'package:chatbot_project/common/navigation/external_action_handler.dart';
import 'package:chatbot_project/data/repository/pending_action_store.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/pending_action.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class _LoggedOutCredentials implements CredentialRepository {
  @override
  Future<AuthSession?> read() async => null;
  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
  @override
  Future<void> clear() async {}
}

class _UnusedAuth implements AuthRepository {
  @override
  Future<AuthUser> getProfile(String accessToken) => throw UnimplementedError();
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) => throw UnimplementedError();
  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) => throw UnimplementedError();
}

class _PendingSpy extends PendingActionStore {
  int saves = 0;
  PendingAction? action;

  @override
  Future<void> save(PendingAction value) async {
    saves++;
    action = value;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('duplicate link is saved once for login', () async {
    final pending = _PendingSpy();
    final handler = ExternalActionHandler(
      credentials: _LoggedOutCredentials(),
      auth: _UnusedAuth(),
      pending: pending,
    );
    const url = 'mconnect://app/chatbot?action=create_leave';
    await handler.handle(url);
    await handler.handle(url);
    expect(pending.saves, 1);
    expect(pending.action?.type, PendingActionType.createLeave);
  });
}
