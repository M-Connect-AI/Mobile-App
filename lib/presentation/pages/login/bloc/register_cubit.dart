import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/auth_session.dart';
import '../../../../domain/repository/auth_preference_repository.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/usecase/login/register_use_case.dart';

enum RegisterStatus { idle, loading, success, failure }

class RegisterState extends Equatable {
  const RegisterState({
    this.role = UserRole.staff,
    this.obscurePassword = true,
    this.status = RegisterStatus.idle,
    this.session,
    this.failureType,
    this.failureMessage,
  });

  final UserRole role;
  final bool obscurePassword;
  final RegisterStatus status;
  final AuthSession? session;
  final AuthFailureType? failureType;
  final String? failureMessage;

  RegisterState copyWith({
    UserRole? role,
    bool? obscurePassword,
    RegisterStatus? status,
    AuthSession? session,
    AuthFailureType? failureType,
    String? failureMessage,
    bool clearFailure = false,
  }) => RegisterState(
    role: role ?? this.role,
    obscurePassword: obscurePassword ?? this.obscurePassword,
    status: status ?? this.status,
    session: session ?? this.session,
    failureType: clearFailure ? null : failureType ?? this.failureType,
    failureMessage: clearFailure ? null : failureMessage ?? this.failureMessage,
  );

  @override
  List<Object?> get props => [
    role,
    obscurePassword,
    status,
    session,
    failureType,
    failureMessage,
  ];
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._register, this._credentials, this._preferences)
    : super(const RegisterState());

  final RegisterUseCase _register;
  final CredentialRepository _credentials;
  final AuthPreferenceRepository _preferences;

  void selectRole(UserRole role) => emit(state.copyWith(role: role));

  void togglePasswordVisibility() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  Future<void> submit({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading, clearFailure: true));
    try {
      final session = await _register(
        email: email,
        password: password,
        fullName: fullName,
        role: state.role,
      );
      var autoLoginEnabled = false;
      try {
        autoLoginEnabled = await _preferences.readAutoLoginEnabled();
      } on Object {
        // Registration remains successful when the preference cannot be read.
      }
      try {
        await _credentials.save(session, persist: autoLoginEnabled);
      } on Object {
        // Credential persistence must not block successful registration.
      }
      try {
        await _preferences.saveLastEmail(session.user.email);
      } on Object {
        // Remembering the email must not block successful registration.
      }
      emit(state.copyWith(status: RegisterStatus.success, session: session));
    } on AuthException catch (error) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          failureType: error.type,
          failureMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          failureType: AuthFailureType.invalidResponse,
        ),
      );
    }
  }
}
