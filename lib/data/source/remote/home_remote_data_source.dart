import 'package:dio/dio.dart';

import '../../model/auth/login_models.dart';
import '../../model/home/home_models.dart';
import 'hr_api_url.dart';

enum HomeRemoteErrorType { unauthorized, forbidden, network, server, malformed }

class HomeRemoteException implements Exception {
  const HomeRemoteException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  final HomeRemoteErrorType type;
  final String message;
  final int? statusCode;
}

class HomeRemoteDataSource {
  HomeRemoteDataSource({
    required String baseUrl,
    Dio? dio,
    this.timeout = const Duration(seconds: 30),
  }) : _baseUrl = normalizeHrApiBaseUrl(baseUrl),
       _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;
  final Duration timeout;

  Future<AuthUserDto> getProfile(String accessToken) async {
    final data = await _get('/auth/me', accessToken);
    if (data is! Map) throw _malformed();
    try {
      return AuthUserDto.fromJson(Map<String, dynamic>.from(data));
    } on Object {
      throw _malformed();
    }
  }

  Future<LeaveBalanceDto> getLeaveBalance(String accessToken) async {
    final data = await _get('/leaves/balance', accessToken);
    if (data is! Map) throw _malformed();
    try {
      return LeaveBalanceDto.fromJson(Map<String, dynamic>.from(data));
    } on Object {
      throw _malformed();
    }
  }

  Future<List<BusinessTripDto>> getMyTrips(String accessToken) async {
    final data = await _get(
      '/trips',
      accessToken,
      query: const {'scope': 'me'},
    );
    if (data is! List) throw _malformed();
    try {
      return data
          .map(
            (item) => BusinessTripDto.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false);
    } on Object {
      throw _malformed();
    }
  }

  Future<Object?> _get(
    String path,
    String accessToken, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get<Object?>(
        '$_baseUrl$path',
        queryParameters: query,
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
      if (statusCode >= 200 && statusCode < 300) return response.data;
      throw HomeRemoteException(
        type: switch (statusCode) {
          401 => HomeRemoteErrorType.unauthorized,
          403 => HomeRemoteErrorType.forbidden,
          _ => HomeRemoteErrorType.server,
        },
        message: _errorMessage(response.data),
        statusCode: statusCode,
      );
    } on HomeRemoteException {
      rethrow;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const HomeRemoteException(
          type: HomeRemoteErrorType.network,
          message: 'Không thể kết nối tới máy chủ.',
        );
      }
      throw const HomeRemoteException(
        type: HomeRemoteErrorType.server,
        message: 'Máy chủ không thể xử lý yêu cầu.',
      );
    }
  }

  HomeRemoteException _malformed() => const HomeRemoteException(
    type: HomeRemoteErrorType.malformed,
    message: 'Phản hồi Home không đúng định dạng.',
  );

  String _errorMessage(Object? data) {
    if (data is! Map) return 'Máy chủ không thể xử lý yêu cầu.';
    final message = data['message'];
    if (message is String && message.trim().isNotEmpty) return message.trim();
    if (message is List) {
      final values = message.whereType<String>().where(
        (item) => item.isNotEmpty,
      );
      if (values.isNotEmpty) return values.join('\n');
    }
    return 'Máy chủ không thể xử lý yêu cầu.';
  }
}
