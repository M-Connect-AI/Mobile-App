import 'package:dio/dio.dart';

import '../../../domain/model/outlook.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/outlook_repository.dart';
import '../../../domain/service/session_expiry.dart';
import '../../mapper/outlook_mapper.dart';
import '../../source/remote/outlook_remote_data_source.dart';

class ApiOutlookRepository implements OutlookRepository {
  const ApiOutlookRepository(this._remote, this._credentials);

  final OutlookRemoteDataSource _remote;
  final CredentialRepository _credentials;

  @override
  Future<OutlookConnectionStatus> getStatus() => _authorized(
    (token) async => OutlookMapper.mapStatus(await _remote.getStatus(token)),
  );

  @override
  Future<Uri> getAuthUri() => _authorized((token) async {
    final value = (await _remote.getAuthUrl(token)).url.trim();
    final uri = Uri.tryParse(value);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
    return uri;
  });

  @override
  Future<void> disconnect() => _authorized((token) async {
    await _remote.disconnect(token);
  });

  @override
  Future<OutlookCalendarData> getCalendar({
    required String from,
    required String to,
  }) => _authorized((token) async {
    final response = await _remote.getCalendar(token, from: from, to: to);
    _validateEnvelope(
      configured: response.configured,
      connected: response.connected,
      error: response.error,
    );
    final email = _required(response.microsoftEmail);
    return OutlookCalendarData(
      microsoftEmail: email,
      events: response.events
          .map(OutlookMapper.mapEvent)
          .toList(growable: false),
    );
  });

  @override
  Future<OutlookCalendarData> getConflicts({
    required String from,
    required String to,
  }) => _authorized((token) async {
    final response = await _remote.getConflicts(token, from: from, to: to);
    _validateEnvelope(
      configured: response.configured,
      connected: response.connected,
      error: response.error,
    );
    return OutlookCalendarData(
      microsoftEmail: _required(response.microsoftEmail),
      events: response.events
          .map(OutlookMapper.mapEvent)
          .toList(growable: false),
    );
  });

  @override
  Future<OutlookMailListData> getMails({
    bool unreadOnly = false,
    int top = 15,
    String? search,
    String? from,
    String? to,
  }) => _authorized((token) async {
    final response = await _remote.getMails(
      token,
      unreadOnly: unreadOnly,
      top: top.clamp(1, 50),
      search: search,
      from: from,
      to: to,
    );
    _validateEnvelope(
      configured: response.configured,
      connected: response.connected,
      error: response.error,
    );
    if (response.count != response.mails.length) {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
    return OutlookMailListData(
      microsoftEmail: _required(response.microsoftEmail),
      mails: response.mails.map(OutlookMapper.mapMail).toList(growable: false),
      unreadOnly: response.unreadOnly,
      from: response.from,
      to: response.to,
    );
  });

  @override
  Future<OutlookMail> getMail(String id) => _authorized((token) async {
    if (id.trim().isEmpty) {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
    final response = await _remote.getMail(token, id.trim());
    _validateEnvelope(
      configured: response.configured,
      connected: response.connected,
      error: response.error,
    );
    final mail = response.mail;
    if (mail == null) {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
    return OutlookMapper.mapMail(mail);
  });

  Future<T> _authorized<T>(Future<T> Function(String token) request) async {
    final session = await _credentials.read();
    if (session == null || session.accessToken.isEmpty) {
      throw const OutlookException(OutlookFailureType.sessionExpired);
    }
    try {
      return await request(session.accessToken);
    } on OutlookRemoteException catch (error) {
      if (error.statusCode == 401) {
        await expireSessionForToken(_credentials, session.accessToken);
      }
      throw OutlookException(switch (error.statusCode) {
        401 => OutlookFailureType.sessionExpired,
        403 => OutlookFailureType.permissionDenied,
        _ => OutlookFailureType.server,
      }, message: error.message);
    } on DioException catch (error) {
      throw OutlookException(switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError => OutlookFailureType.network,
        _ => OutlookFailureType.server,
      });
    } on OutlookException {
      rethrow;
    } on Object {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
  }

  void _validateEnvelope({
    required bool configured,
    required bool connected,
    String? error,
  }) {
    if (!configured) {
      throw OutlookException(OutlookFailureType.notConfigured, message: error);
    }
    if (!connected) {
      throw OutlookException(OutlookFailureType.notConnected, message: error);
    }
    if (error?.trim().isNotEmpty ?? false) {
      throw OutlookException(OutlookFailureType.business, message: error);
    }
  }

  String _required(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      throw const OutlookException(OutlookFailureType.invalidResponse);
    }
    return normalized;
  }
}
