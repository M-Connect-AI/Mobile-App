import '../../../domain/model/auth_session.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../model/auth/login_models.dart';
import '../../source/remote/auth_remote_data_source.dart';

class ApiAuthRepository implements AuthRepository {
  const ApiAuthRepository(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthUser> getProfile(String accessToken) async {
    try {
      return _mapUser(await _remoteDataSource.getProfile(accessToken));
    } on AuthRemoteException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestDto(email: email.trim().toLowerCase(), password: password),
      );
      if (response.accessToken.trim().isEmpty) {
        throw const AuthException(
          type: AuthFailureType.invalidResponse,
          message: 'Máy chủ không trả về access token.',
        );
      }
      return AuthSession(
        accessToken: response.accessToken,
        user: _mapUser(response.user),
      );
    } on AuthRemoteException catch (error) {
      throw _mapException(error);
    }
  }

  AuthException _mapException(AuthRemoteException error) => AuthException(
    type: switch (error.type) {
      AuthRemoteErrorType.unauthorized => AuthFailureType.invalidCredentials,
      AuthRemoteErrorType.validation => AuthFailureType.validation,
      AuthRemoteErrorType.network => AuthFailureType.network,
      AuthRemoteErrorType.server => AuthFailureType.server,
      AuthRemoteErrorType.malformed => AuthFailureType.invalidResponse,
    },
    message: error.message,
    statusCode: error.statusCode,
  );

  AuthUser _mapUser(AuthUserDto dto) {
    final role = switch (dto.role) {
      'STAFF' => UserRole.staff,
      'MANAGER' => UserRole.manager,
      _ => throw AuthException(
        type: AuthFailureType.invalidResponse,
        message: 'Vai trò người dùng không được hỗ trợ: ${dto.role}.',
      ),
    };
    return AuthUser(
      id: dto.id,
      employeeCode: dto.employeeCode,
      email: dto.email,
      fullName: dto.fullName,
      role: role,
      department: dto.department,
      managerEmployeeCode: dto.managerEmployeeCode,
      annualRemaining: dto.annualRemaining,
      annualTotal: dto.annualTotal,
      sickRemaining: dto.sickRemaining,
    );
  }
}
