import 'package:dio/dio.dart';

import '../../model/hr/hr_request_dto.dart';
import 'hr_api_url.dart';

class HrRemoteException implements Exception {
  const HrRemoteException(this.statusCode, this.message);

  final int statusCode;
  final String? message;
}

class HrRequestRemoteDataSource {
  HrRequestRemoteDataSource({required String baseUrl, Dio? dio})
    : _baseUrl = normalizeHrApiBaseUrl(baseUrl),
      _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;

  Future<List<LeaveRequestDto>> getLeaves(
    String token, {
    bool team = false,
  }) async {
    final data = await _get(
      '/leaves',
      token,
      query: {'scope': team ? 'team' : 'me'},
    );
    if (data is! List) throw const FormatException('Invalid leave list');
    return data
        .map(
          (item) =>
              LeaveRequestDto.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }

  Future<LeaveRequestDto> getLeave(String token, String id) async {
    final data = await _get('/leaves/${Uri.encodeComponent(id)}', token);
    if (data is! Map) throw const FormatException('Invalid leave detail');
    return LeaveRequestDto.fromJson(Map<String, dynamic>.from(data));
  }

  Future<List<TripRequestDto>> getTrips(
    String token, {
    bool team = false,
  }) async {
    final data = await _get(
      '/trips',
      token,
      query: {'scope': team ? 'team' : 'me'},
    );
    if (data is! List) throw const FormatException('Invalid trip list');
    return data
        .map(
          (item) =>
              TripRequestDto.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }

  Future<LeaveRequestDto> setLeaveStatus(
    String token,
    String id,
    String status,
  ) async {
    final data = await _write(
      'PATCH',
      '/leaves/${Uri.encodeComponent(id)}/status',
      token,
      {'status': status},
    );
    if (data is! Map) {
      throw const FormatException('Invalid leave status response');
    }
    return LeaveRequestDto.fromJson(Map<String, dynamic>.from(data));
  }

  Future<TripRequestDto> setTripStatus(
    String token,
    String id,
    String status,
  ) async {
    final data = await _write(
      'PATCH',
      '/trips/${Uri.encodeComponent(id)}/status',
      token,
      {'status': status},
    );
    if (data is! Map) {
      throw const FormatException('Invalid trip status response');
    }
    return TripRequestDto.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> approveLeaves(String token, List<String> ids) async {
    final data = await _write('POST', '/leaves/approve-batch', token, {
      'ids': ids,
    });
    if (data is! Map || data['count'] is! int || data['items'] is! List) {
      throw const FormatException('Invalid batch response');
    }
  }

  Future<Object?> _write(
    String method,
    String path,
    String token,
    Map<String, Object> body,
  ) async {
    final response = await _dio.request<Object?>(
      '$_baseUrl$path',
      data: body,
      options: Options(
        method: method,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (_) => true,
      ),
    );
    return _responseData(response);
  }

  Future<Object?> _get(
    String path,
    String token, {
    Map<String, String>? query,
  }) async {
    final response = await _dio.get<Object?>(
      '$_baseUrl$path',
      queryParameters: query,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (_) => true,
      ),
    );
    return _responseData(response);
  }

  Object? _responseData(Response<Object?> response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) return response.data;
    final data = response.data;
    final message = data is Map && data['message'] is String
        ? data['message'] as String
        : null;
    throw HrRemoteException(status, message);
  }
}
