import 'package:dio/dio.dart';

import '../../model/auth/login_models.dart';
import 'hr_api_url.dart';

enum AuthRemoteErrorType {
  unauthorized,
  validation,
  network,
  server,
  malformed,
}

class AuthRemoteException implements Exception {
  const AuthRemoteException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  final AuthRemoteErrorType type;
  final String message;
  final int? statusCode;
}

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required String baseUrl,
    Dio? dio,
    this.timeout = const Duration(seconds: 30),
  }) : _baseUrl = normalizeHrApiBaseUrl(baseUrl),
       _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;
  final Duration timeout;

  Future<AuthUserDto> getProfile(String accessToken) async {
    try {
      final response = await _dio.get<Object?>(
        '$_baseUrl/auth/me',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          sendTimeout: timeout,
          receiveTimeout: timeout,
          validateStatus: (_) => true,
        ),
      );

      final statusCode = response.statusCode ?? 0;
      final body = _asJsonMap(response.data);
      if (statusCode < 200 || statusCode >= 300) {
        throw AuthRemoteException(
          type: switch (statusCode) {
            401 => AuthRemoteErrorType.unauthorized,
            _ => AuthRemoteErrorType.server,
          },
          message: _errorMessage(body),
          statusCode: statusCode,
        );
      }
      if (body == null) {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.malformed,
          message: 'Phản hồi profile không đúng định dạng.',
        );
      }
      try {
        return AuthUserDto.fromJson(body);
      } on Object {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.malformed,
          message: 'Phản hồi profile thiếu dữ liệu bắt buộc.',
        );
      }
    } on AuthRemoteException {
      rethrow;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.network,
          message: 'Không thể kết nối tới máy chủ.',
        );
      }
      throw const AuthRemoteException(
        type: AuthRemoteErrorType.server,
        message: 'Máy chủ không thể xử lý yêu cầu tải profile.',
      );
    } on Object {
      throw const AuthRemoteException(
        type: AuthRemoteErrorType.malformed,
        message: 'Không thể xử lý phản hồi profile.',
      );
    }
  }

  Future<LoginResponseDto> login(LoginRequestDto request) async {
    try {
      final response = await _dio.post<Object?>(
        '$_baseUrl/auth/login',
        data: request.toJson(),
        options: Options(
          headers: const {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          sendTimeout: timeout,
          receiveTimeout: timeout,
          validateStatus: (_) => true,
        ),
      );

      final statusCode = response.statusCode ?? 0;
      final body = _asJsonMap(response.data);
      if (statusCode < 200 || statusCode >= 300) {
        throw AuthRemoteException(
          type: switch (statusCode) {
            400 => AuthRemoteErrorType.validation,
            401 => AuthRemoteErrorType.unauthorized,
            _ => AuthRemoteErrorType.server,
          },
          message: _errorMessage(body),
          statusCode: statusCode,
        );
      }

      if (body == null) {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.malformed,
          message: 'Phản hồi đăng nhập không đúng định dạng.',
        );
      }
      try {
        return LoginResponseDto.fromJson(body);
      } on Object {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.malformed,
          message: 'Phản hồi đăng nhập thiếu dữ liệu bắt buộc.',
        );
      }
    } on AuthRemoteException {
      rethrow;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const AuthRemoteException(
          type: AuthRemoteErrorType.network,
          message: 'Không thể kết nối tới máy chủ.',
        );
      }
      throw const AuthRemoteException(
        type: AuthRemoteErrorType.server,
        message: 'Máy chủ không thể xử lý yêu cầu đăng nhập.',
      );
    } on Object {
      throw const AuthRemoteException(
        type: AuthRemoteErrorType.malformed,
        message: 'Không thể xử lý phản hồi đăng nhập.',
      );
    }
  }

  Map<String, dynamic>? _asJsonMap(Object? data) {
    if (data is! Map) return null;
    return Map<String, dynamic>.from(data);
  }

  String _errorMessage(Map<String, dynamic>? body) {
    final message = body?['message'];
    if (message is String && message.trim().isNotEmpty) return message.trim();
    if (message is List) {
      final messages = message.whereType<String>().map((item) => item.trim());
      final nonEmpty = messages.where((item) => item.isNotEmpty).toList();
      if (nonEmpty.isNotEmpty) return nonEmpty.join('\n');
    }
    return 'Máy chủ không thể xử lý yêu cầu đăng nhập.';
  }
}
