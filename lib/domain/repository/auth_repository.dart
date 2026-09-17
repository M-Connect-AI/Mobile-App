import '../model/auth_session.dart';

abstract interface class AuthRepository {
  Future<AuthSession> login({required String email, required String password});

  Future<AuthSession> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  });

  Future<AuthUser> getProfile(String accessToken);
}

class AuthException implements Exception {
  const AuthException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  final AuthFailureType type;
  final String message;
  final int? statusCode;
}

enum AuthFailureType {
  invalidCredentials,
  conflict,
  validation,
  network,
  server,
  invalidResponse,
}
