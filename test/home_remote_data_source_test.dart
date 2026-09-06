import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/data/source/remote/home_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads profile, balance and my trips with bearer token', () async {
    final requests = <RequestOptions>[];
    final dio = Dio()
      ..httpClientAdapter = _MockAdapter((request) {
        requests.add(request);
        return switch (request.path) {
          'http://hr.test/api/hr/auth/me' => _jsonResponse(200, _user),
          'http://hr.test/api/hr/leaves/balance' => _jsonResponse(
            200,
            _balance,
          ),
          'http://hr.test/api/hr/trips' => _jsonResponse(200, [_trip]),
          _ => _jsonResponse(404, {'message': 'not found'}),
        };
      });
    final source = HomeRemoteDataSource(baseUrl: 'http://hr.test/', dio: dio);

    final results = await Future.wait<Object>([
      source.getProfile('jwt'),
      source.getLeaveBalance('jwt'),
      source.getMyTrips('jwt'),
    ]);

    expect(requests, hasLength(3));
    expect(
      requests.every(
        (request) => request.headers['Authorization'] == 'Bearer jwt',
      ),
      isTrue,
    );
    final trips = results[2] as List;
    expect(trips, hasLength(1));
    expect(requests.last.queryParameters, {'scope': 'me'});
  });

  test('accepts an empty trip list', () async {
    final source = HomeRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: Dio()
        ..httpClientAdapter = _MockAdapter(
          (_) => _jsonResponse(200, <Object>[]),
        ),
    );

    expect(await source.getMyTrips('jwt'), isEmpty);
  });

  test('maps 401 to unauthorized', () async {
    final source = HomeRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: Dio()
        ..httpClientAdapter = _MockAdapter(
          (_) => _jsonResponse(401, {'message': 'Unauthorized'}),
        ),
    );

    await expectLater(
      source.getProfile('expired'),
      throwsA(
        isA<HomeRemoteException>().having(
          (error) => error.type,
          'type',
          HomeRemoteErrorType.unauthorized,
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

const _user = <String, dynamic>{
  'id': 'user-id',
  'employeeCode': 'EMP001',
  'email': 'a.nguyen@msb.vn',
  'fullName': 'Nguyễn Văn A',
  'role': 'STAFF',
  'department': 'Khối bán lẻ',
  'annualRemaining': 9,
  'annualTotal': 12,
  'sickRemaining': 30,
};

const _balance = <String, dynamic>{
  'employeeCode': 'EMP001',
  'annualRemaining': 9,
  'annualTotal': 12,
  'sickRemaining': 30,
};

const _trip = <String, dynamic>{
  '_id': 'trip-id',
  'employeeCode': 'EMP001',
  'destination': 'Hà Nội',
  'from': '2026-09-08',
  'to': '2026-09-10',
  'purpose': 'Gặp đối tác dự án',
  'status': 'PENDING',
};
