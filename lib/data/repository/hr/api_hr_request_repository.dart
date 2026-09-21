import 'package:dio/dio.dart';

import '../../../domain/model/hr_request.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/hr_request_repository.dart';
import '../../../domain/service/session_expiry.dart';
import '../../mapper/hr_request_mapper.dart';
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
      if (error.statusCode == 401) {
        await expireSessionForToken(_credentials, session.accessToken);
      }
      throw HrException(
        switch (error.statusCode) {
          401 => HrFailureType.sessionExpired,
          403 => HrFailureType.permissionDenied,
          404 => HrFailureType.notFound,
          _ => HrFailureType.server,
        },
        message: error.message,
        statusCode: error.statusCode,
      );
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
  Future<List<LeaveRequest>> getLeaves({bool team = false}) => _authorized(
    (token) async => (await _remote.getLeaves(
      token,
      team: team,
    )).map(HrRequestMapper.mapLeave).toList(growable: false),
  );

  @override
  Future<LeaveRequest> getLeave(String id) => _authorized(
    (token) async =>
        HrRequestMapper.mapLeave(await _remote.getLeave(token, id)),
  );

  @override
  Future<List<TripRequest>> getTrips({bool team = false}) => _authorized(
    (token) async => (await _remote.getTrips(
      token,
      team: team,
    )).map(HrRequestMapper.mapTrip).toList(growable: false),
  );

  @override
  Future<LeaveRequest> setLeaveStatus(String id, RequestStatus status) =>
      _authorized(
        (token) async => HrRequestMapper.mapLeave(
          await _remote.setLeaveStatus(token, id, _actionStatus(status)),
        ),
      );

  @override
  Future<TripRequest> setTripStatus(String id, RequestStatus status) =>
      _authorized(
        (token) async => HrRequestMapper.mapTrip(
          await _remote.setTripStatus(token, id, _actionStatus(status)),
        ),
      );

  @override
  Future<void> approveLeaves(List<String> ids) =>
      _authorized((token) => _remote.approveLeaves(token, ids));

  String _actionStatus(RequestStatus status) => switch (status) {
    RequestStatus.approved => 'APPROVED',
    RequestStatus.rejected => 'REJECTED',
    _ => throw const HrException(HrFailureType.invalidResponse),
  };
}
