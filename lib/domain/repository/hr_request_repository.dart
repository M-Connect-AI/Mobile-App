import '../model/hr_request.dart';
import '../model/home_data.dart';

enum HrFailureType {
  sessionExpired,
  permissionDenied,
  notFound,
  network,
  server,
  invalidResponse,
}

class HrException implements Exception {
  const HrException(this.type, {this.message, this.statusCode});

  final HrFailureType type;
  final String? message;
  final int? statusCode;
}

abstract interface class HrRequestRepository {
  Future<List<LeaveRequest>> getLeaves({bool team = false});
  Future<LeaveRequest> getLeave(String id);
  Future<List<TripRequest>> getTrips({bool team = false});
  Future<LeaveRequest> setLeaveStatus(String id, RequestStatus status);
  Future<TripRequest> setTripStatus(String id, RequestStatus status);
  Future<void> approveLeaves(List<String> ids);
}
