// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      id: json['id'] as String,
      employeeCode: json['employeeCode'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      department: json['department'] as String,
      managerEmployeeCode: json['managerEmployeeCode'] as String?,
      annualRemaining: (json['annualRemaining'] as num).toInt(),
      annualTotal: (json['annualTotal'] as num).toInt(),
      sickRemaining: (json['sickRemaining'] as num).toInt(),
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'email': instance.email,
      'fullName': instance.fullName,
      'role': _$UserRoleEnumMap[instance.role]!,
      'department': instance.department,
      'managerEmployeeCode': instance.managerEmployeeCode,
      'annualRemaining': instance.annualRemaining,
      'annualTotal': instance.annualTotal,
      'sickRemaining': instance.sickRemaining,
    };

const _$UserRoleEnumMap = {
  UserRole.staff: 'staff',
  UserRole.manager: 'manager',
};

_$AuthSessionImpl _$$AuthSessionImplFromJson(Map<String, dynamic> json) =>
    _$AuthSessionImpl(
      accessToken: json['accessToken'] as String,
      user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthSessionImplToJson(_$AuthSessionImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
    };
