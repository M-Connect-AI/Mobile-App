import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot_project/data/repository/outlook/api_outlook_repository.dart';
import 'package:chatbot_project/data/source/remote/outlook_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/outlook_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps Outlook status, calendar, mails, detail and OAuth URL', () async {
    final requests = <RequestOptions>[];
    final dio = Dio()
      ..httpClientAdapter = _MockAdapter((request) {
        requests.add(request);
        if (request.path.endsWith('/outlook/status')) {
          return _json(200, {
            'configured': true,
            'connected': true,
            'microsoftEmail': 'a@msb.vn',
          });
        }
        if (request.path.endsWith('/outlook/auth-url')) {
          return _json(200, {
            'url':
                'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
          });
        }
        if (request.path.endsWith('/outlook/calendar') ||
            request.path.endsWith('/outlook/conflicts')) {
          return _json(200, {
            'configured': true,
            'connected': true,
            'microsoftEmail': 'a@msb.vn',
            'events': [
              {
                'id': 'event-1',
                'subject': 'Họp dự án',
                'start': '2026-09-20T09:00:00',
                'end': '2026-09-20T10:00:00',
                'showAs': 'busy',
                'isAllDay': false,
              },
            ],
          });
        }
        if (request.path.endsWith('/outlook/mails')) {
          return _json(200, {
            'configured': true,
            'connected': true,
            'microsoftEmail': 'a@msb.vn',
            'unreadOnly': false,
            'count': 1,
            'mails': [_mail],
          });
        }
        if (request.path.endsWith('/outlook/mail')) {
          return _json(200, {
            'configured': true,
            'connected': true,
            'microsoftEmail': 'a@msb.vn',
            'mail': {..._mail, 'body': 'Nội dung email'},
          });
        }
        if (request.path.endsWith('/outlook/disconnect')) {
          return _json(200, {'connected': false});
        }
        return _json(404, {});
      });
    final repository = ApiOutlookRepository(
      OutlookRemoteDataSource(baseUrl: 'http://hr.test', dio: dio),
      _Credentials(),
    );

    final status = await repository.getStatus();
    final authUri = await repository.getAuthUri();
    final calendar = await repository.getCalendar(
      from: '2026-09-20',
      to: '2026-09-30',
    );
    final conflicts = await repository.getConflicts(
      from: '2026-09-20',
      to: '2026-09-30',
    );
    final mails = await repository.getMails(search: 'dự án');
    final mail = await repository.getMail('mail-1');
    await repository.disconnect();

    expect(status.connected, isTrue);
    expect(authUri.scheme, 'https');
    expect(calendar.events.single.id, 'event-1');
    expect(conflicts.events.single.showAs, 'busy');
    expect(mails.mails.single.subject, 'Thông báo');
    expect(mail.body, 'Nội dung email');
    expect(
      requests.every(
        (request) => request.headers['Authorization'] == 'Bearer jwt',
      ),
      isTrue,
    );
    expect(
      requests
          .firstWhere((request) => request.path.endsWith('/outlook/calendar'))
          .queryParameters,
      {'from': '2026-09-20', 'to': '2026-09-30'},
    );
  });

  test('treats HTTP 200 business error as a typed failure', () async {
    final repository = ApiOutlookRepository(
      OutlookRemoteDataSource(
        baseUrl: 'http://hr.test',
        dio: Dio()
          ..httpClientAdapter = _MockAdapter(
            (_) => _json(200, {
              'configured': true,
              'connected': false,
              'microsoftEmail': null,
              'count': 0,
              'error': 'Chưa kết nối Outlook',
            }),
          ),
      ),
      _Credentials(),
    );

    await expectLater(
      repository.getMails(),
      throwsA(
        isA<OutlookException>().having(
          (error) => error.type,
          'type',
          OutlookFailureType.notConnected,
        ),
      ),
    );
  });

  test('rejects an unsafe OAuth URL', () async {
    final repository = ApiOutlookRepository(
      OutlookRemoteDataSource(
        baseUrl: 'http://hr.test',
        dio: Dio()
          ..httpClientAdapter = _MockAdapter(
            (_) => _json(200, {'url': 'javascript:alert(1)'}),
          ),
      ),
      _Credentials(),
    );

    await expectLater(
      repository.getAuthUri(),
      throwsA(
        isA<OutlookException>().having(
          (error) => error.type,
          'type',
          OutlookFailureType.invalidResponse,
        ),
      ),
    );
  });
}

const _mail = <String, dynamic>{
  'id': 'mail-1',
  'subject': 'Thông báo',
  'from': 'Nguyễn Văn A <a@msb.vn>',
  'receivedAt': '2026-09-20T09:00:00Z',
  'preview': 'Nội dung xem trước',
  'isRead': false,
  'hasAttachments': false,
  'importance': 'normal',
};

class _Credentials implements CredentialRepository {
  AuthSession? session = _session;

  @override
  Future<void> clear() async => session = null;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async =>
      session = value;
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'id',
    employeeCode: 'EMP001',
    email: 'a@msb.vn',
    fullName: 'A',
    role: UserRole.staff,
    department: 'D',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
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
