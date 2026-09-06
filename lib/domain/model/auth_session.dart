import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

enum UserRole { staff, manager }

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String employeeCode,
    required String email,
    required String fullName,
    required UserRole role,
    required String department,
    String? managerEmployeeCode,
    required int annualRemaining,
    required int annualTotal,
    required int sickRemaining,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required AuthUser user,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}
