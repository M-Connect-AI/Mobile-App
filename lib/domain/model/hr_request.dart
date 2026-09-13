import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_data.dart';

part 'hr_request.freezed.dart';

enum LeaveType { annual, sick, unpaid }

@freezed
abstract class LeaveRequest with _$LeaveRequest {
  const factory LeaveRequest({
    required String id,
    required String employeeCode,
    String? employeeName,
    required LeaveType type,
    required DateTime from,
    required DateTime to,
    required int days,
    required String reason,
    required RequestStatus status,
    DateTime? createdAt,
  }) = _LeaveRequest;
}

@freezed
abstract class TripRequest with _$TripRequest {
  const factory TripRequest({
    required String id,
    required String employeeCode,
    String? employeeName,
    required String destination,
    required DateTime from,
    required DateTime to,
    required String purpose,
    required RequestStatus status,
    DateTime? createdAt,
  }) = _TripRequest;
}
