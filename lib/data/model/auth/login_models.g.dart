// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestDto _$LoginRequestDtoFromJson(Map<String, dynamic> json) =>
    _LoginRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDtoToJson(_LoginRequestDto instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RegisterRequestDto _$RegisterRequestDtoFromJson(Map<String, dynamic> json) =>
    _RegisterRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$RegisterRequestDtoToJson(_RegisterRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fullName': instance.fullName,
      'role': instance.role,
    };

_LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    _LoginResponseDto(
      accessToken: json['accessToken'] as String,
      user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDtoToJson(_LoginResponseDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
    };

_AuthUserDto _$AuthUserDtoFromJson(Map<String, dynamic> json) => _AuthUserDto(
  id: json['id'] as String,
  employeeCode: json['employeeCode'] as String,
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  role: json['role'] as String,
  department: json['department'] as String,
  managerEmployeeCode: json['managerEmployeeCode'] as String?,
  annualRemaining: (json['annualRemaining'] as num).toInt(),
  annualTotal: (json['annualTotal'] as num).toInt(),
  sickRemaining: (json['sickRemaining'] as num).toInt(),
);

Map<String, dynamic> _$AuthUserDtoToJson(_AuthUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'email': instance.email,
      'fullName': instance.fullName,
      'role': instance.role,
      'department': instance.department,
      'managerEmployeeCode': instance.managerEmployeeCode,
      'annualRemaining': instance.annualRemaining,
      'annualTotal': instance.annualTotal,
      'sickRemaining': instance.sickRemaining,
    };
