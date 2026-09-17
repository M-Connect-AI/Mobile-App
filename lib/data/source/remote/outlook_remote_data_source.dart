import 'package:dio/dio.dart';

import '../../model/outlook/outlook_dto.dart';
import 'hr_api_url.dart';

class OutlookRemoteException implements Exception {
  const OutlookRemoteException({required this.statusCode, this.message});

  final int statusCode;
  final String? message;
}

class OutlookRemoteDataSource {
  OutlookRemoteDataSource({required String baseUrl, Dio? dio})
    : _baseUrl = normalizeHrApiBaseUrl(baseUrl),
      _dio = dio ?? Dio();

  final String _baseUrl;
  final Dio _dio;

  Future<OutlookStatusDto> getStatus(String token) async =>
      OutlookStatusDto.fromJson(await _getMap('/outlook/status', token));

  Future<OutlookAuthUrlDto> getAuthUrl(String token) async =>
      OutlookAuthUrlDto.fromJson(await _getMap('/outlook/auth-url', token));

  Future<void> disconnect(String token) async {
    final data = await _requestMap(
      '/outlook/disconnect',
      token,
      method: 'POST',
    );
    if (data['connected'] != false) {
      throw const FormatException('Invalid Outlook disconnect response');
    }
  }

  Future<OutlookCalendarResponseDto> getCalendar(
    String token, {
    required String from,
    required String to,
  }) async => OutlookCalendarResponseDto.fromJson(
    await _getMap('/outlook/calendar', token, query: {'from': from, 'to': to}),
  );

  Future<OutlookCalendarResponseDto> getConflicts(
    String token, {
    required String from,
    required String to,
  }) async => OutlookCalendarResponseDto.fromJson(
    await _getMap('/outlook/conflicts', token, query: {'from': from, 'to': to}),
  );

  Future<OutlookMailListResponseDto> getMails(
    String token, {
    required bool unreadOnly,
    required int top,
    String? search,
    String? from,
    String? to,
  }) async => OutlookMailListResponseDto.fromJson(
    await _getMap(
      '/outlook/mails',
      token,
      query: {
        'unreadOnly': unreadOnly,
        'top': top,
        if (search?.trim().isNotEmpty ?? false) 'search': search!.trim(),
        if (from?.trim().isNotEmpty ?? false) 'from': from!.trim(),
        if (to?.trim().isNotEmpty ?? false) 'to': to!.trim(),
      },
    ),
  );

  Future<OutlookMailDetailResponseDto> getMail(String token, String id) async =>
      OutlookMailDetailResponseDto.fromJson(
        await _getMap('/outlook/mail', token, query: {'id': id}),
      );

  Future<Map<String, dynamic>> _getMap(
    String path,
    String token, {
    Map<String, Object?>? query,
  }) => _requestMap(path, token, query: query);

  Future<Map<String, dynamic>> _requestMap(
    String path,
    String token, {
    String method = 'GET',
    Map<String, Object?>? query,
  }) async {
    final response = await _dio.request<Object?>(
      '$_baseUrl$path',
      queryParameters: query,
      options: Options(
        method: method,
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
    if (status >= 200 && status < 300) {
      final data = response.data;
      if (data is Map) return Map<String, dynamic>.from(data);
      throw const FormatException('Invalid Outlook response');
    }
    throw OutlookRemoteException(
      statusCode: status,
      message: _errorMessage(response.data),
    );
  }

  String? _errorMessage(Object? data) {
    if (data is! Map) return null;
    final message = data['message'];
    if (message is String && message.trim().isNotEmpty) return message.trim();
    if (message is List) {
      final values = message.whereType<String>().where(
        (item) => item.trim().isNotEmpty,
      );
      if (values.isNotEmpty) return values.join('\n');
    }
    return null;
  }
}
