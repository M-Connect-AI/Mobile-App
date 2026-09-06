import '../../model/auth_session.dart';
import '../../repository/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}
