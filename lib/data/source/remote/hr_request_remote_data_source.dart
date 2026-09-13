import 'package:dio/dio.dart';

import '../../model/hr/hr_request_dto.dart';
import 'hr_api_url.dart';

class HrRemoteException implements Exception {
  const HrRemoteException(this.statusCode);

  final int statusCode;
}

class HrRequestRemoteDataSource {
  HrRequestRemoteDataSource({required String baseUrl, Dio? dio})
    : _baseUrl = normalizeHrApiBaseUrl(baseUrl),
      _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;

  Future<List<LeaveRequestDto>> getLeaves(String token) async {
    final data = await _get('/leaves', token, query: const {'scope': 'me'});
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

  Future<List<TripRequestDto>> getTrips(String token) async {
    final data = await _get('/trips', token, query: const {'scope': 'me'});
    if (data is! List) throw const FormatException('Invalid trip list');
    return data
        .map(
          (item) =>
              TripRequestDto.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
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
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) return response.data;
    throw HrRemoteException(status);
  }
}
