// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveBalanceDto _$LeaveBalanceDtoFromJson(Map<String, dynamic> json) =>
    _LeaveBalanceDto(
      employeeCode: json['employeeCode'] as String,
      annualRemaining: (json['annualRemaining'] as num).toInt(),
      annualTotal: (json['annualTotal'] as num).toInt(),
      sickRemaining: (json['sickRemaining'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveBalanceDtoToJson(_LeaveBalanceDto instance) =>
    <String, dynamic>{
      'employeeCode': instance.employeeCode,
      'annualRemaining': instance.annualRemaining,
      'annualTotal': instance.annualTotal,
      'sickRemaining': instance.sickRemaining,
    };

_BusinessTripDto _$BusinessTripDtoFromJson(Map<String, dynamic> json) =>
    _BusinessTripDto(
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

Map<String, dynamic> _$BusinessTripDtoToJson(_BusinessTripDto instance) =>
    <String, dynamic>{
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
