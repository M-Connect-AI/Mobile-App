import 'package:dio/dio.dart';

import '../../../domain/model/home_data.dart';
import '../../../domain/model/hr_request.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/hr_request_repository.dart';
import '../../model/hr/hr_request_dto.dart';
import '../../source/remote/hr_request_remote_data_source.dart';

class ApiHrRequestRepository implements HrRequestRepository {
  const ApiHrRequestRepository(this._remote, this._credentials);

  final HrRequestRemoteDataSource _remote;
  final CredentialRepository _credentials;

  Future<T> _authorized<T>(Future<T> Function(String) request) async {
    final session = await _credentials.read();
    if (session == null || session.accessToken.isEmpty) {
      throw const HrException(HrFailureType.sessionExpired);
    }
    try {
      return await request(session.accessToken);
    } on HrRemoteException catch (error) {
      if (error.statusCode == 401) await _credentials.clear();
      throw HrException(switch (error.statusCode) {
        401 => HrFailureType.sessionExpired,
        403 => HrFailureType.permissionDenied,
        404 => HrFailureType.notFound,
        _ => HrFailureType.server,
      });
    } on DioException catch (error) {
      throw HrException(switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError => HrFailureType.network,
        _ => HrFailureType.server,
      });
    } on HrException {
      rethrow;
    } on Object {
      throw const HrException(HrFailureType.invalidResponse);
    }
  }

  @override
  Future<List<LeaveRequest>> getLeaves() => _authorized(
    (token) async =>
        (await _remote.getLeaves(token)).map(_mapLeave).toList(growable: false),
  );

  @override
  Future<LeaveRequest> getLeave(String id) => _authorized(
    (token) async => _mapLeave(await _remote.getLeave(token, id)),
  );

  @override
  Future<List<TripRequest>> getTrips() => _authorized(
    (token) async =>
        (await _remote.getTrips(token)).map(_mapTrip).toList(growable: false),
  );

  LeaveRequest _mapLeave(LeaveRequestDto dto) => LeaveRequest(
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

  TripRequest _mapTrip(TripRequestDto dto) => TripRequest(
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

  String _id(String? id, String? mongoId) {
    final value = id ?? mongoId;
    if (value == null || value.isEmpty) {
      throw const FormatException('Missing ID');
    }
    return value;
  }

  DateTime _date(String value) {
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
      throw const FormatException('Invalid business date');
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null || parsed.toIso8601String().substring(0, 10) != value) {
      throw const FormatException('Invalid business date');
    }
    return parsed;
  }

  RequestStatus _status(String value) => switch (value) {
    'PENDING' => RequestStatus.pending,
    'APPROVED' => RequestStatus.approved,
    'REJECTED' => RequestStatus.rejected,
    'CANCELLED' => RequestStatus.cancelled,
    _ => throw const FormatException('Invalid request status'),
  };
}
