abstract interface class AuthPreferenceRepository {
  Future<String?> readLastEmail();

  Future<void> saveLastEmail(String email);

  Future<bool> readAutoLoginEnabled();

  Future<void> setAutoLoginEnabled(bool enabled);

  Future<bool> readAliceBubbleEnabled();

  Future<void> setAliceBubbleEnabled(bool enabled);
}
