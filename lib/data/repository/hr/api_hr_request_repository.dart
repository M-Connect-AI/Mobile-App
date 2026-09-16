import 'package:dio/dio.dart';

import '../../../domain/model/hr_request.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/hr_request_repository.dart';
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
    (token) async => (await _remote.getLeaves(
      token,
    )).map(HrRequestMapper.mapLeave).toList(growable: false),
  );

  @override
  Future<LeaveRequest> getLeave(String id) => _authorized(
    (token) async =>
        HrRequestMapper.mapLeave(await _remote.getLeave(token, id)),
  );

  @override
  Future<List<TripRequest>> getTrips() => _authorized(
    (token) async => (await _remote.getTrips(
      token,
    )).map(HrRequestMapper.mapTrip).toList(growable: false),
  );
}
