import 'package:chatbot_project/data/model/auth/login_models.dart';
import 'package:chatbot_project/data/repository/auth/api_auth_repository.dart';
import 'package:chatbot_project/data/source/remote/auth_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps profile response into domain user', () async {
    final source = _FakeAuthRemoteDataSource(profile: _response.user);
    final repository = ApiAuthRepository(source);

    final profile = await repository.getProfile('jwt-token');

    expect(source.accessToken, 'jwt-token');
    expect(profile.fullName, 'Nguyễn Văn A');
    expect(profile.role, UserRole.staff);
  });

  test('normalizes email and maps backend user into domain session', () async {
    final source = _FakeAuthRemoteDataSource(response: _response);
    final repository = ApiAuthRepository(source);

    final session = await repository.login(
      email: '  A.NGUYEN@MSB.VN ',
      password: 'password123',
    );

    expect(source.request?.email, 'a.nguyen@msb.vn');
    expect(session.accessToken, 'jwt-token');
    expect(session.user.role, UserRole.staff);
    expect(session.user.managerEmployeeCode, isNull);
  });

  test('maps network datasource failure into domain auth failure', () async {
    final repository = ApiAuthRepository(
      _FakeAuthRemoteDataSource(
        error: const AuthRemoteException(
          type: AuthRemoteErrorType.network,
          message: 'offline',
        ),
      ),
    );

    await expectLater(
      repository.login(email: 'a@msb.vn', password: 'password'),
      throwsA(
        isA<AuthException>().having(
          (error) => error.type,
          'type',
          AuthFailureType.network,
        ),
      ),
    );
  });
}

class _FakeAuthRemoteDataSource extends AuthRemoteDataSource {
  _FakeAuthRemoteDataSource({this.response, this.profile, this.error})
    : super(baseUrl: 'http://unused');

  final LoginResponseDto? response;
  final AuthUserDto? profile;
  final AuthRemoteException? error;
  LoginRequestDto? request;
  String? accessToken;

  @override
  Future<AuthUserDto> getProfile(String accessToken) async {
    this.accessToken = accessToken;
    final failure = error;
    if (failure != null) throw failure;
    return profile!;
  }

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    this.request = request;
    final failure = error;
    if (failure != null) throw failure;
    return response!;
  }
}

const _response = LoginResponseDto(
  accessToken: 'jwt-token',
  user: AuthUserDto(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a.nguyen@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: 'STAFF',
    department: 'Khối bán lẻ',
    managerEmployeeCode: null,
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
