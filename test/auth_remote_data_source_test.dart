import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/data/model/auth/login_models.dart';
import 'package:chatbot_project/data/source/remote/auth_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GET /auth/me sends bearer token and decodes profile', () async {
    RequestOptions? capturedRequest;
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test/',
      dio: _mockDio((request) {
        capturedRequest = request;
        return _jsonResponse(
          200,
          _successBody['user']! as Map<String, dynamic>,
        );
      }),
    );

    final profile = await source.getProfile('jwt-token');

    expect(capturedRequest?.method, 'GET');
    expect(capturedRequest?.uri.toString(), 'http://hr.test/api/hr/auth/me');
    expect(capturedRequest?.headers['Authorization'], 'Bearer jwt-token');
    expect(profile.employeeCode, 'EMP001');
  });

  test('POST /auth/login decodes nullable managerEmployeeCode', () async {
    RequestOptions? capturedRequest;
    final dio = _mockDio((request) {
      capturedRequest = request;
      return _jsonResponse(201, _successBody);
    });
    final source = AuthRemoteDataSource(baseUrl: 'http://hr.test/', dio: dio);

    final response = await source.login(
      const LoginRequestDto(email: 'a.nguyen@msb.vn', password: 'password123'),
    );

    expect(capturedRequest?.method, 'POST');
    expect(capturedRequest?.uri.toString(), 'http://hr.test/api/hr/auth/login');
    expect(capturedRequest?.data, {
      'email': 'a.nguyen@msb.vn',
      'password': 'password123',
    });
    expect(response.accessToken, 'jwt-token');
    expect(response.user.managerEmployeeCode, isNull);
  });

  test('maps backend message array from 400', () async {
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: _mockDio(
        (_) => _jsonResponse(400, {
          'message': ['email must be an email', 'password is too short'],
          'statusCode': 400,
        }),
      ),
    );

    await expectLater(
      source.login(const LoginRequestDto(email: 'bad', password: 'x')),
      throwsA(
        isA<AuthRemoteException>()
            .having(
              (error) => error.type,
              'type',
              AuthRemoteErrorType.validation,
            )
            .having(
              (error) => error.message,
              'message',
              'email must be an email\npassword is too short',
            ),
      ),
    );
  });

  test('POST /auth/register sends role and decodes session', () async {
    RequestOptions? capturedRequest;
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: _mockDio((request) {
        capturedRequest = request;
        return _jsonResponse(201, _successBody);
      }),
    );

    final response = await source.register(
      const RegisterRequestDto(
        email: 'manager@msb.vn',
        password: 'pass123',
        fullName: 'Manager A',
        role: 'MANAGER',
      ),
    );

    expect(
      capturedRequest?.uri.toString(),
      'http://hr.test/api/hr/auth/register',
    );
    expect(capturedRequest?.data, {
      'email': 'manager@msb.vn',
      'password': 'pass123',
      'fullName': 'Manager A',
      'role': 'MANAGER',
    });
    expect(response.accessToken, 'jwt-token');
  });

  test('maps duplicate registration email from 409', () async {
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: _mockDio((_) => _jsonResponse(409, {'message': 'Email đã tồn tại'})),
    );

    await expectLater(
      source.register(
        const RegisterRequestDto(
          email: 'a@msb.vn',
          password: 'pass123',
          fullName: 'User A',
          role: 'STAFF',
        ),
      ),
      throwsA(
        isA<AuthRemoteException>().having(
          (error) => error.type,
          'type',
          AuthRemoteErrorType.conflict,
        ),
      ),
    );
  });

  test('maps 401 backend error separately', () async {
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: _mockDio(
        (_) => _jsonResponse(401, {'message': 'Sai email hoặc mật khẩu'}),
      ),
    );

    await expectLater(
      source.login(const LoginRequestDto(email: 'a@msb.vn', password: 'wrong')),
      throwsA(
        isA<AuthRemoteException>().having(
          (error) => error.type,
          'type',
          AuthRemoteErrorType.unauthorized,
        ),
      ),
    );
  });

  test('rejects an empty successful response', () async {
    final source = AuthRemoteDataSource(
      baseUrl: 'http://hr.test',
      dio: _mockDio((_) => _jsonResponse(201, {})),
    );

    await expectLater(
      source.login(
        const LoginRequestDto(email: 'a@msb.vn', password: 'password'),
      ),
      throwsA(
        isA<AuthRemoteException>().having(
          (error) => error.type,
          'type',
          AuthRemoteErrorType.malformed,
        ),
      ),
    );
  });
}

Dio _mockDio(FutureOr<ResponseBody> Function(RequestOptions) handler) {
  return Dio()..httpClientAdapter = _MockAdapter(handler);
}

ResponseBody _jsonResponse(int statusCode, Map<String, dynamic> body) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: ['application/json'],
    },
  );
}

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

const _successBody = <String, dynamic>{
  'accessToken': 'jwt-token',
  'user': {
    'id': 'user-id',
    'employeeCode': 'EMP001',
    'email': 'a.nguyen@msb.vn',
    'fullName': 'Nguyễn Văn A',
    'role': 'STAFF',
    'department': 'Khối bán lẻ',
    'annualRemaining': 9,
    'annualTotal': 12,
    'sickRemaining': 30,
  },
};
