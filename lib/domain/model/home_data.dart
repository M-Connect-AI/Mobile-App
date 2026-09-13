import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_session.dart';

part 'home_data.freezed.dart';
part 'home_data.g.dart';

enum RequestStatus { pending, approved, rejected, cancelled }

@freezed
abstract class LeaveBalance with _$LeaveBalance {
  const factory LeaveBalance({
    required String employeeCode,
    required int annualRemaining,
    required int annualTotal,
    required int sickRemaining,
  }) = _LeaveBalance;

  factory LeaveBalance.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceFromJson(json);
}

@freezed
abstract class BusinessTrip with _$BusinessTrip {
  const factory BusinessTrip({
    required String id,
    required String employeeCode,
    required String destination,
    required DateTime from,
    required DateTime to,
    required String purpose,
    required RequestStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BusinessTrip;

  factory BusinessTrip.fromJson(Map<String, dynamic> json) =>
      _$BusinessTripFromJson(json);
}

@freezed
abstract class HomeData with _$HomeData {
  const factory HomeData({
    required AuthUser user,
    required LeaveBalance leaveBalance,
    required List<BusinessTrip> upcomingTrips,
  }) = _HomeData;

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);
}
