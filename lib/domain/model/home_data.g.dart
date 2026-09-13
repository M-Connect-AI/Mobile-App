// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveBalance _$LeaveBalanceFromJson(Map<String, dynamic> json) =>
    _LeaveBalance(
      employeeCode: json['employeeCode'] as String,
      annualRemaining: (json['annualRemaining'] as num).toInt(),
      annualTotal: (json['annualTotal'] as num).toInt(),
      sickRemaining: (json['sickRemaining'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveBalanceToJson(_LeaveBalance instance) =>
    <String, dynamic>{
      'employeeCode': instance.employeeCode,
      'annualRemaining': instance.annualRemaining,
      'annualTotal': instance.annualTotal,
      'sickRemaining': instance.sickRemaining,
    };

_BusinessTrip _$BusinessTripFromJson(Map<String, dynamic> json) =>
    _BusinessTrip(
      id: json['id'] as String,
      employeeCode: json['employeeCode'] as String,
      destination: json['destination'] as String,
      from: DateTime.parse(json['from'] as String),
      to: DateTime.parse(json['to'] as String),
      purpose: json['purpose'] as String,
      status: $enumDecode(_$RequestStatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BusinessTripToJson(_BusinessTrip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeCode': instance.employeeCode,
      'destination': instance.destination,
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
      'purpose': instance.purpose,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RequestStatusEnumMap = {
  RequestStatus.pending: 'pending',
  RequestStatus.approved: 'approved',
  RequestStatus.rejected: 'rejected',
  RequestStatus.cancelled: 'cancelled',
};

_HomeData _$HomeDataFromJson(Map<String, dynamic> json) => _HomeData(
  user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
  leaveBalance: LeaveBalance.fromJson(
    json['leaveBalance'] as Map<String, dynamic>,
  ),
  upcomingTrips: (json['upcomingTrips'] as List<dynamic>)
      .map((e) => BusinessTrip.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HomeDataToJson(_HomeData instance) => <String, dynamic>{
  'user': instance.user,
  'leaveBalance': instance.leaveBalance,
  'upcomingTrips': instance.upcomingTrips,
};
