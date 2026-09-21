import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/auth_preference_repository.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/usecase/login/register_use_case.dart';
import 'package:chatbot_project/presentation/pages/login/bloc/register_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('đăng ký với role được chọn và lưu session/email', () async {
    final auth = _AuthRepository();
    final storage = _Storage();
    final cubit = RegisterCubit(RegisterUseCase(auth), storage, storage);
    addTearDown(cubit.close);

    cubit.selectRole(UserRole.manager);
    await cubit.submit(
      email: 'manager@msb.vn',
      password: 'pass123',
      fullName: 'Manager A',
    );

    expect(auth.role, UserRole.manager);
    expect(storage.session, _session);
    expect(storage.lastEmail, _session.user.email);
    expect(cubit.state.status, RegisterStatus.success);
  });

  test('giữ conflict để UI báo email đã tồn tại', () async {
    final auth = _AuthRepository(
      error: const AuthException(
        type: AuthFailureType.conflict,
        message: 'duplicate',
      ),
    );
    final storage = _Storage();
    final cubit = RegisterCubit(RegisterUseCase(auth), storage, storage);
    addTearDown(cubit.close);

    await cubit.submit(
      email: 'a@msb.vn',
      password: 'pass123',
      fullName: 'User A',
    );

    expect(cubit.state.status, RegisterStatus.failure);
    expect(cubit.state.failureType, AuthFailureType.conflict);
  });
}

class _AuthRepository implements AuthRepository {
  _AuthRepository({this.error});

  final AuthException? error;
  UserRole? role;

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    this.role = role;
    final failure = error;
    if (failure != null) throw failure;
    return _session;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async => _session;

  @override
  Future<AuthUser> getProfile(String accessToken) async => _session.user;
}

class _Storage implements CredentialRepository, AuthPreferenceRepository {
  AuthSession? session;
  String? lastEmail;

  @override
  Future<void> clear() async => session = null;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async =>
      session = value;

  @override
  Future<bool> readAutoLoginEnabled() async => false;

  @override
  Future<String?> readLastEmail() async => lastEmail;

  @override
  Future<void> saveLastEmail(String email) async => lastEmail = email;

  @override
  Future<void> setAutoLoginEnabled(bool enabled) async {}
  @override
  Future<bool> readAliceBubbleEnabled() async => false;

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async {}
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'id',
    employeeCode: 'EMP001',
    email: 'manager@msb.vn',
    fullName: 'Manager A',
    role: UserRole.manager,
    department: 'D',
    annualRemaining: 12,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
