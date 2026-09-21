import '../repository/credential_repository.dart';

/// Optional support for invalidating the session that made a failed request.
abstract interface class SessionExpiry {
  Stream<void> get onSessionExpired;

  Future<void> expireSession(String accessToken);
}

Future<void> expireSessionForToken(
  CredentialRepository credentials,
  String accessToken,
) async {
  if (credentials case SessionExpiry expiry) {
    await expiry.expireSession(accessToken);
  } else {
    await credentials.clear();
  }
}
