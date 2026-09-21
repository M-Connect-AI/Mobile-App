import 'package:chatbot_project/data/repository/auth/secure_credential_repository.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stores session and removes legacy raw credentials', () async {
    FlutterSecureStorage.setMockInitialValues({
      'login_email': 'legacy@msb.vn',
      'login_password': 'plain-text-password',
    });
    final repository = SecureCredentialRepository();

    await repository.save(_session, persist: true);

    expect(await repository.read(), _session);
    const storage = FlutterSecureStorage();
    expect(await storage.read(key: 'login_email'), isNull);
    expect(await storage.read(key: 'login_password'), isNull);
    expect(await storage.read(key: 'auth_session'), isNotEmpty);
  });

  test('treats invalid persisted session as empty state', () async {
    FlutterSecureStorage.setMockInitialValues({'auth_session': '{broken'});
    final repository = SecureCredentialRepository();

    expect(await repository.read(), isNull);
    expect(
      await const FlutterSecureStorage().read(key: 'auth_session'),
      isNull,
    );
  });

  test('removes legacy raw credentials while loading an empty state', () async {
    FlutterSecureStorage.setMockInitialValues({
      'login_email': 'legacy@msb.vn',
      'login_password': 'plain-text-password',
    });
    final repository = SecureCredentialRepository();

    expect(await repository.read(), isNull);
    const storage = FlutterSecureStorage();
    expect(await storage.read(key: 'login_email'), isNull);
    expect(await storage.read(key: 'login_password'), isNull);
  });

  test(
    'keeps a non-persistent session available for the current run',
    () async {
      FlutterSecureStorage.setMockInitialValues({});
      final repository = SecureCredentialRepository();

      await repository.save(_session, persist: false);

      expect(await repository.read(), _session);
      expect(
        await const FlutterSecureStorage().read(key: 'auth_session'),
        isNull,
      );
    },
  );

  test('giữ email gần nhất sau khi đăng xuất', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final repository = SecureCredentialRepository();

    await repository.saveLastEmail(' A.NGUYEN@MSB.VN ');
    await repository.save(_session, persist: true);
    await repository.clear();

    expect(await repository.read(), isNull);
    expect(await repository.readLastEmail(), 'a.nguyen@msb.vn');
  });

  test('lưu tùy chọn tự động đăng nhập độc lập với phiên', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final repository = SecureCredentialRepository();

    await repository.setAutoLoginEnabled(true);
    await repository.clear();

    expect(await repository.readAutoLoginEnabled(), isTrue);
  });

  test('401 invalidates the matching token and emits session expiry', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final repository = SecureCredentialRepository();
    final events = <void>[];
    final subscription = repository.onSessionExpired.listen(events.add);
    await repository.save(_session, persist: true);

    await repository.expireSession('other-token');
    expect(await repository.read(), _session);
    expect(events, isEmpty);

    await repository.save(_session.copyWith(accessToken: 'new-token'), persist: true);
    await repository.expireSession(_session.accessToken);
    expect((await repository.read())?.accessToken, 'new-token');
    expect(events, isEmpty);

    await repository.save(_session, persist: true);
    await repository.expireSession(_session.accessToken);
    await Future<void>.delayed(Duration.zero);
    expect(await repository.read(), isNull);
    expect(events, hasLength(1));
    await subscription.cancel();
  });
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a.nguyen@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    managerEmployeeCode: null,
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
