// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceImpl _$$LeaveBalanceImplFromJson(Map<String, dynamic> json) =>
    _$LeaveBalanceImpl(
      employeeCode: json['employeeCode'] as String,
      annualRemaining: (json['annualRemaining'] as num).toInt(),
      annualTotal: (json['annualTotal'] as num).toInt(),
      sickRemaining: (json['sickRemaining'] as num).toInt(),
    );

Map<String, dynamic> _$$LeaveBalanceImplToJson(_$LeaveBalanceImpl instance) =>
    <String, dynamic>{
      'employeeCode': instance.employeeCode,
      'annualRemaining': instance.annualRemaining,
      'annualTotal': instance.annualTotal,
      'sickRemaining': instance.sickRemaining,
    };

_$BusinessTripImpl _$$BusinessTripImplFromJson(Map<String, dynamic> json) =>
    _$BusinessTripImpl(
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

Map<String, dynamic> _$$BusinessTripImplToJson(_$BusinessTripImpl instance) =>
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

_$HomeDataImpl _$$HomeDataImplFromJson(Map<String, dynamic> json) =>
    _$HomeDataImpl(
      user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
      leaveBalance: LeaveBalance.fromJson(
        json['leaveBalance'] as Map<String, dynamic>,
      ),
      upcomingTrips: (json['upcomingTrips'] as List<dynamic>)
          .map((e) => BusinessTrip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeDataImplToJson(_$HomeDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'leaveBalance': instance.leaveBalance,
      'upcomingTrips': instance.upcomingTrips,
    };
