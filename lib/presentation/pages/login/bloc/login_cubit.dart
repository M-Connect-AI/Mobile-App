import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/auth_session.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/usecase/login/login_use_case.dart';
import '../../../../domain/usecase/login/restore_session_use_case.dart';

enum LoginStatus { idle, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.obscurePassword = true,
    this.rememberSession = false,
    this.status = LoginStatus.idle,
    this.savedEmail,
    this.credentialsLoaded = false,
    this.session,
    this.failureType,
    this.failureMessage,
  });

  final bool obscurePassword;
  final bool rememberSession;
  final LoginStatus status;
  final String? savedEmail;
  final bool credentialsLoaded;
  final AuthSession? session;
  final AuthFailureType? failureType;
  final String? failureMessage;

  LoginState copyWith({
    bool? obscurePassword,
    bool? rememberSession,
    LoginStatus? status,
    String? savedEmail,
    bool? credentialsLoaded,
    AuthSession? session,
    AuthFailureType? failureType,
    String? failureMessage,
    bool clearFailure = false,
  }) => LoginState(
    obscurePassword: obscurePassword ?? this.obscurePassword,
    rememberSession: rememberSession ?? this.rememberSession,
    status: status ?? this.status,
    savedEmail: savedEmail ?? this.savedEmail,
    credentialsLoaded: credentialsLoaded ?? this.credentialsLoaded,
    session: session ?? this.session,
    failureType: clearFailure ? null : failureType ?? this.failureType,
    failureMessage: clearFailure ? null : failureMessage ?? this.failureMessage,
  );

  @override
  List<Object?> get props => [
    obscurePassword,
    rememberSession,
    status,
    savedEmail,
    credentialsLoaded,
    session,
    failureType,
    failureMessage,
  ];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._login, this._restoreSession, this._credentials)
    : super(const LoginState()) {
    _restoreSavedSession();
  }

  final LoginUseCase _login;
  final RestoreSessionUseCase _restoreSession;
  final CredentialRepository _credentials;

  Future<void> _restoreSavedSession() async {
    try {
      final session = await _restoreSession();
      emit(
        state.copyWith(
          savedEmail: session?.user.email,
          rememberSession: session != null,
          credentialsLoaded: true,
          status: session == null ? LoginStatus.idle : LoginStatus.success,
          session: session,
        ),
      );
    } on AuthException catch (error) {
      emit(
        state.copyWith(
          credentialsLoaded: true,
          failureType: error.type,
          failureMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          credentialsLoaded: true,
          failureType: AuthFailureType.invalidResponse,
        ),
      );
    }
  }

  void togglePasswordVisibility() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  void toggleRememberSession() =>
      emit(state.copyWith(rememberSession: !state.rememberSession));

  Future<void> submit({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading, clearFailure: true));
    try {
      final session = await _login(email: email, password: password);
      try {
        await _credentials.save(session, persist: state.rememberSession);
      } on Object {
        // Credential persistence must not block a successful authentication.
      }
      emit(state.copyWith(status: LoginStatus.success, session: session));
    } on AuthException catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          failureType: error.type,
          failureMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          failureType: AuthFailureType.invalidResponse,
        ),
      );
    }
  }
}
