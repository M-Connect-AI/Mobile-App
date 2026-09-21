import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/auth_preference_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/usecase/login/login_use_case.dart';
import 'package:chatbot_project/domain/usecase/login/restore_session_use_case.dart';
import 'package:chatbot_project/presentation/pages/login/bloc/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('gọi profile và khôi phục phiên khi đã có access token', () async {
    final authRepository = _AuthRepository();
    final credentialRepository = _CredentialRepository(initial: _session);
    final cubit = LoginCubit(
      LoginUseCase(authRepository),
      RestoreSessionUseCase(authRepository, credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);

    await Future<void>.delayed(Duration.zero);

    expect(authRepository.profileAccessToken, 'jwt');
    expect(cubit.state.status, LoginStatus.success);
    expect(cubit.state.session, _session);
  });

  test('xóa phiên khi access token không còn hợp lệ', () async {
    final authRepository = _AuthRepository(
      error: const AuthException(
        type: AuthFailureType.invalidCredentials,
        message: 'expired',
      ),
    );
    final credentialRepository = _CredentialRepository(initial: _session);
    final cubit = LoginCubit(
      LoginUseCase(authRepository),
      RestoreSessionUseCase(authRepository, credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);

    await Future<void>.delayed(Duration.zero);

    expect(credentialRepository.wasCleared, isTrue);
    expect(cubit.state.status, LoginStatus.idle);
    expect(cubit.state.failureType, AuthFailureType.invalidCredentials);
  });

  test('gửi email/password và lưu session khi tự động đăng nhập bật', () async {
    final authRepository = _AuthRepository();
    final credentialRepository = _CredentialRepository(autoLoginEnabled: true);
    final cubit = LoginCubit(
      LoginUseCase(authRepository),
      RestoreSessionUseCase(authRepository, credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    await cubit.submit(email: 'A.NGUYEN@MSB.VN', password: 'password123');

    expect(authRepository.email, 'A.NGUYEN@MSB.VN');
    expect(authRepository.password, 'password123');
    expect(credentialRepository.savedSession, _session);
    expect(credentialRepository.lastEmail, _session.user.email);
    expect(credentialRepository.persist, isTrue);
    expect(cubit.state.session, _session);
    expect(cubit.state.status, LoginStatus.success);
  });

  test('giữ session trong RAM nhưng không persist khi tắt duy trì', () async {
    final credentialRepository = _CredentialRepository(
      initial: _session,
      autoLoginEnabled: false,
    );
    final cubit = LoginCubit(
      LoginUseCase(_AuthRepository()),
      RestoreSessionUseCase(_AuthRepository(), credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    await cubit.submit(email: 'b.tran@msb.vn', password: 'new-password');

    expect(credentialRepository.savedSession, _session);
    expect(credentialRepository.persist, isFalse);
    expect(cubit.state.status, LoginStatus.success);
  });

  test('giữ loại lỗi mạng để UI hiển thị đúng thông báo', () async {
    final authRepository = _AuthRepository(
      error: const AuthException(
        type: AuthFailureType.network,
        message: 'offline',
      ),
    );
    final credentialRepository = _CredentialRepository();
    final cubit = LoginCubit(
      LoginUseCase(authRepository),
      RestoreSessionUseCase(authRepository, credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    await cubit.submit(email: 'a.nguyen@msb.vn', password: 'password123');

    expect(cubit.state.status, LoginStatus.failure);
    expect(cubit.state.failureType, AuthFailureType.network);
  });

  test('đọc email gần nhất dù tự động đăng nhập đang tắt', () async {
    final authRepository = _AuthRepository();
    final credentialRepository = _CredentialRepository(
      lastEmail: 'previous@msb.vn',
      autoLoginEnabled: false,
    );
    final cubit = LoginCubit(
      LoginUseCase(authRepository),
      RestoreSessionUseCase(authRepository, credentialRepository),
      credentialRepository,
      credentialRepository,
    );
    addTearDown(cubit.close);

    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.savedEmail, 'previous@msb.vn');
    expect(cubit.state.status, LoginStatus.idle);
    expect(authRepository.profileAccessToken, isNull);
  });
}

class _AuthRepository implements AuthRepository {
  _AuthRepository({this.error});

  final AuthException? error;
  String? email;
  String? password;
  String? profileAccessToken;

  @override
  Future<AuthUser> getProfile(String accessToken) async {
    profileAccessToken = accessToken;
    final failure = error;
    if (failure != null) throw failure;
    return _session.user;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    this.email = email;
    this.password = password;
    final failure = error;
    if (failure != null) throw failure;
    return _session;
  }

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async => _session;
}

class _CredentialRepository
    implements CredentialRepository, AuthPreferenceRepository {
  _CredentialRepository({this.initial, this.lastEmail, bool? autoLoginEnabled})
    : autoLoginEnabled = autoLoginEnabled ?? initial != null;

  final AuthSession? initial;
  AuthSession? savedSession;
  bool wasCleared = false;
  bool? persist;
  bool autoLoginEnabled;
  String? lastEmail;

  @override
  Future<void> clear() async {
    wasCleared = true;
    savedSession = null;
  }

  @override
  Future<AuthSession?> read() async => initial;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {
    savedSession = session;
    this.persist = persist;
  }

  @override
  Future<bool> readAutoLoginEnabled() async => autoLoginEnabled;

  @override
  Future<String?> readLastEmail() async => lastEmail;

  @override
  Future<void> saveLastEmail(String email) async => lastEmail = email;

  @override
  Future<void> setAutoLoginEnabled(bool enabled) async =>
      autoLoginEnabled = enabled;
  @override
  Future<bool> readAliceBubbleEnabled() async => false;

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async {}
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a.nguyen@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
