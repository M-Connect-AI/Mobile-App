import '../model/hr_request.dart';

enum HrFailureType {
  sessionExpired,
  permissionDenied,
  notFound,
  network,
  server,
  invalidResponse,
}

class HrException implements Exception {
  const HrException(this.type);

  final HrFailureType type;
}

abstract interface class HrRequestRepository {
  Future<List<LeaveRequest>> getLeaves();
  Future<LeaveRequest> getLeave(String id);
  Future<List<TripRequest>> getTrips();
}
