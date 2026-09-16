import '../../domain/model/home_data.dart';
import '../../domain/model/hr_request.dart';
import '../model/home/home_models.dart';
import '../model/hr/hr_request_dto.dart';

class HrRequestMapper {
  const HrRequestMapper._();

  static LeaveBalance mapBalance(LeaveBalanceDto dto) => LeaveBalance(
    employeeCode: dto.employeeCode,
    annualRemaining: dto.annualRemaining,
    annualTotal: dto.annualTotal,
    sickRemaining: dto.sickRemaining,
  );

  static LeaveRequest mapLeave(LeaveRequestDto dto) => LeaveRequest(
    id: _id(dto.id, dto.mongoId),
    employeeCode: dto.employeeCode,
    employeeName: dto.employeeName,
    type: switch (dto.type) {
      'ANNUAL' => LeaveType.annual,
      'SICK' => LeaveType.sick,
      'UNPAID' => LeaveType.unpaid,
      _ => throw const FormatException('Invalid leave type'),
    },
    from: _date(dto.from),
    to: _date(dto.to),
    days: dto.days,
    reason: dto.reason,
    status: _status(dto.status),
    createdAt: DateTime.tryParse(dto.createdAt ?? ''),
  );

  static TripRequest mapTrip(TripRequestDto dto) => TripRequest(
    id: _id(dto.id, dto.mongoId),
    employeeCode: dto.employeeCode,
    employeeName: dto.employeeName,
    destination: dto.destination,
    from: _date(dto.from),
    to: _date(dto.to),
    purpose: dto.purpose,
    status: _status(dto.status),
    createdAt: DateTime.tryParse(dto.createdAt ?? ''),
  );

  static String _id(String? id, String? mongoId) {
    final value = id ?? mongoId;
    if (value == null || value.isEmpty) {
      throw const FormatException('Missing ID');
    }
    return value;
  }

  static DateTime _date(String value) {
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
      throw const FormatException('Invalid business date');
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null || parsed.toIso8601String().substring(0, 10) != value) {
      throw const FormatException('Invalid business date');
    }
    return parsed;
  }

  static RequestStatus _status(String value) => switch (value) {
    'PENDING' => RequestStatus.pending,
    'APPROVED' => RequestStatus.approved,
    'REJECTED' => RequestStatus.rejected,
    'CANCELLED' => RequestStatus.cancelled,
    _ => throw const FormatException('Invalid request status'),
  };
}
