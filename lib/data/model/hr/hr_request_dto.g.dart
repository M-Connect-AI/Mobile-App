// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveRequestDto _$LeaveRequestDtoFromJson(Map<String, dynamic> json) =>
    _LeaveRequestDto(
      mongoId: json['_id'] as String?,
      id: json['id'] as String?,
      employeeCode: json['employeeCode'] as String,
      employeeName: json['employeeName'] as String?,
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      days: (json['days'] as num).toInt(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$LeaveRequestDtoToJson(_LeaveRequestDto instance) =>
    <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'employeeName': instance.employeeName,
      'type': instance.type,
      'from': instance.from,
      'to': instance.to,
      'days': instance.days,
      'reason': instance.reason,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

_TripRequestDto _$TripRequestDtoFromJson(Map<String, dynamic> json) =>
    _TripRequestDto(
      mongoId: json['_id'] as String?,
      id: json['id'] as String?,
      employeeCode: json['employeeCode'] as String,
      employeeName: json['employeeName'] as String?,
      destination: json['destination'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      purpose: json['purpose'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$TripRequestDtoToJson(_TripRequestDto instance) =>
    <String, dynamic>{
      '_id': instance.mongoId,
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'employeeName': instance.employeeName,
      'destination': instance.destination,
      'from': instance.from,
      'to': instance.to,
      'purpose': instance.purpose,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
