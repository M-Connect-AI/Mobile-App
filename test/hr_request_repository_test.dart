import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/data/repository/hr/api_hr_request_repository.dart';
import 'package:chatbot_project/data/source/remote/hr_request_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/hr_request_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads self lists and leave detail with runtime Mongo IDs', () async {
    final requests = <RequestOptions>[];
    final dio = Dio()
      ..httpClientAdapter = _MockAdapter((request) {
      requests.add(request);
      if (request.path.endsWith('/leaves/leave-1')) {
        return _jsonResponse(200, {..._leave}..remove('employeeName'));
        }
        if (request.path.endsWith('/leaves')) {
          return _jsonResponse(200, [_leave]);
        }
        return _jsonResponse(200, [_trip]);
      });
    final repository = ApiHrRequestRepository(
      HrRequestRemoteDataSource(baseUrl: 'http://hr.test', dio: dio),
      _Sessions(),
    );

    final leaves = await repository.getLeaves();
    final detail = await repository.getLeave('leave-1');
    final trips = await repository.getTrips();

    expect(leaves.single.id, 'leave-1');
    expect(leaves.single.type, LeaveType.annual);
    expect(leaves.single.days, 3);
    expect(detail.employeeName, isNull);
    expect(trips.single.id, 'trip-1');
    expect(trips.single.status, RequestStatus.pending);
    expect(requests, hasLength(3));
    expect(
      requests.every(
        (request) => request.headers['Authorization'] == 'Bearer jwt',
      ),
      isTrue,
    );
    expect(requests.first.queryParameters, {'scope': 'me'});
    expect(requests.last.queryParameters, {'scope': 'me'});
  });

  test('clears session on 401', () async {
    final sessions = _Sessions();
    final repository = ApiHrRequestRepository(
      HrRequestRemoteDataSource(
        baseUrl: 'http://hr.test',
        dio: Dio()
          ..httpClientAdapter = _MockAdapter((_) => _jsonResponse(401, {})),
      ),
      sessions,
    );

    await expectLater(
      repository.getLeaves(),
      throwsA(
        isA<HrException>().having(
          (error) => error.type,
          'type',
          HrFailureType.sessionExpired,
        ),
      ),
    );
    expect(sessions.cleared, isTrue);
  });

  test('fails closed for unknown status', () async {
    final repository = ApiHrRequestRepository(
      HrRequestRemoteDataSource(
        baseUrl: 'http://hr.test',
        dio: Dio()
          ..httpClientAdapter = _MockAdapter(
            (_) => _jsonResponse(200, [
              {..._trip, 'status': 'UNKNOWN'},
            ]),
          ),
      ),
      _Sessions(),
    );

    await expectLater(
      repository.getTrips(),
      throwsA(
        isA<HrException>().having(
          (error) => error.type,
          'type',
          HrFailureType.invalidResponse,
        ),
      ),
    );
  });
}

ResponseBody _jsonResponse(int statusCode, Object body) =>
    ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this.handler);

  final FutureOr<ResponseBody> Function(RequestOptions) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => handler(options);

  @override
  void close({bool force = false}) {}
}

class _Sessions implements CredentialRepository {
  bool cleared = false;

  @override
  Future<AuthSession?> read() async => const AuthSession(
    accessToken: 'jwt',
    user: AuthUser(
      id: 'employee-1',
      employeeCode: 'EMP001',
      email: 'a@example.com',
      fullName: 'Employee A',
      role: UserRole.staff,
      department: 'HR',
      annualRemaining: 9,
      annualTotal: 12,
      sickRemaining: 30,
    ),
  );

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}

  @override
  Future<void> clear() async {
    cleared = true;
  }
}

final _leave = <String, Object?>{
  '_id': 'leave-1',
  'employeeCode': 'EMP001',
  'employeeName': 'Employee A',
  'type': 'ANNUAL',
  'from': '2026-09-08',
  'to': '2026-09-10',
  'days': 3,
  'reason': 'Family event',
  'status': 'APPROVED',
};

const _trip = <String, Object?>{
  '_id': 'trip-1',
  'employeeCode': 'EMP001',
  'employeeName': 'Employee A',
  'destination': 'Ha Noi',
  'from': '2026-09-08',
  'to': '2026-09-10',
  'purpose': 'Visit project partner',
  'status': 'PENDING',
};
