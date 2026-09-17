import '../../model/auth_session.dart';
import '../../repository/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) => _repository.register(
    email: email,
    password: password,
    fullName: fullName,
    role: role,
  );
}
