import '../../model/auth_session.dart';
import '../../repository/auth_repository.dart';
import '../../repository/credential_repository.dart';
import '../../service/session_expiry.dart';

class RestoreSessionUseCase {
  const RestoreSessionUseCase(this._authRepository, this._credentials);

  final AuthRepository _authRepository;
  final CredentialRepository _credentials;

  Future<AuthSession?> call() async {
    final savedSession = await _credentials.read();
    if (savedSession == null || savedSession.accessToken.trim().isEmpty) {
      return null;
    }

    try {
      final user = await _authRepository.getProfile(savedSession.accessToken);
      final refreshedSession = AuthSession(
        accessToken: savedSession.accessToken,
        user: user,
      );
      return refreshedSession;
    } on AuthException catch (error) {
      if (error.type == AuthFailureType.invalidCredentials) {
        await expireSessionForToken(_credentials, savedSession.accessToken);
      }
      rethrow;
    }
  }
}
