abstract interface class AuthPreferenceRepository {
  Future<String?> readLastEmail();

  Future<void> saveLastEmail(String email);

  Future<bool> readAutoLoginEnabled();

  Future<void> setAutoLoginEnabled(bool enabled);
}
