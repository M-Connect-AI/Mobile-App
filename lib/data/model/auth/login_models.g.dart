// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestDtoImpl _$$LoginRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$LoginRequestDtoImplToJson(
  _$LoginRequestDtoImpl instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password};

_$LoginResponseDtoImpl _$$LoginResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseDtoImpl(
  accessToken: json['accessToken'] as String,
  user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LoginResponseDtoImplToJson(
  _$LoginResponseDtoImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'user': instance.user,
};

_$AuthUserDtoImpl _$$AuthUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserDtoImpl(
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

Map<String, dynamic> _$$AuthUserDtoImplToJson(_$AuthUserDtoImpl instance) =>
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
