// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceDtoImpl _$$LeaveBalanceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LeaveBalanceDtoImpl(
  employeeCode: json['employeeCode'] as String,
  annualRemaining: (json['annualRemaining'] as num).toInt(),
  annualTotal: (json['annualTotal'] as num).toInt(),
  sickRemaining: (json['sickRemaining'] as num).toInt(),
);

Map<String, dynamic> _$$LeaveBalanceDtoImplToJson(
  _$LeaveBalanceDtoImpl instance,
) => <String, dynamic>{
  'employeeCode': instance.employeeCode,
  'annualRemaining': instance.annualRemaining,
  'annualTotal': instance.annualTotal,
  'sickRemaining': instance.sickRemaining,
};

_$BusinessTripDtoImpl _$$BusinessTripDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessTripDtoImpl(
  mongoId: json['_id'] as String?,
  id: json['id'] as String?,
  employeeCode: json['employeeCode'] as String,
  destination: json['destination'] as String,
  from: json['from'] as String,
  to: json['to'] as String,
  purpose: json['purpose'] as String,
  status: json['status'] as String,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$BusinessTripDtoImplToJson(
  _$BusinessTripDtoImpl instance,
) => <String, dynamic>{
  '_id': instance.mongoId,
  'id': instance.id,
  'employeeCode': instance.employeeCode,
  'destination': instance.destination,
  'from': instance.from,
  'to': instance.to,
  'purpose': instance.purpose,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
