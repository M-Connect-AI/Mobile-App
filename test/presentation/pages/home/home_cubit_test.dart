import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:chatbot_project/domain/repository/auth_preference_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_cubit.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits loading then success', () async {
    final cubit = HomeCubit(
      _HomeRepository(data: _data),
      _CredentialRepository(),
      authPreferences: _AuthPreferences(),
    );
    addTearDown(cubit.close);
    final states = <HomeState>[];
    final subscription = cubit.stream.listen(states.add);
    addTearDown(subscription.cancel);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.aliceBubbleEnabled, isFalse);

    expect(
      states.map((state) => state.status),
      containsAllInOrder([HomeStatus.loading, HomeStatus.success]),
    );
    expect(cubit.state.data, _data);
  });

  test('keeps typed network failure for retry UI', () async {
    final cubit = HomeCubit(
      _HomeRepository(
        error: const HomeException(
          type: HomeFailureType.network,
          message: 'offline',
        ),
      ),
      _CredentialRepository(),
      authPreferences: _AuthPreferences(),
    );
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.status, HomeStatus.failure);
    expect(cubit.state.failureType, HomeFailureType.network);
  });

  test('xóa credential và phát trạng thái đăng xuất', () async {
    final credentials = _CredentialRepository();
    final cubit = HomeCubit(
      _HomeRepository(data: _data),
      credentials,
      authPreferences: _AuthPreferences(),
    );
    addTearDown(cubit.close);

    await cubit.logout();

    expect(credentials.wasCleared, isTrue);
    expect(cubit.state.status, HomeStatus.loggedOut);
  });

  test('refetches home data only for affected mutation scopes', () async {
    final repository = _HomeRepository(data: _data);
    final coordinator = DataRefreshCoordinator();
    final cubit = HomeCubit(
      repository,
      _CredentialRepository(),
      authPreferences: _AuthPreferences(),
      refreshCoordinator: coordinator,
    );
    addTearDown(cubit.close);
    addTearDown(coordinator.close);

    await cubit.load();
    coordinator.notify(const {DataRefreshScope.jira});
    await Future<void>.delayed(Duration.zero);
    expect(repository.calls, 1);

    coordinator.notify(const {DataRefreshScope.home});
    await Future<void>.delayed(Duration.zero);
    expect(repository.calls, 2);
  });

  test('bật tự động đăng nhập sẽ persist phiên hiện tại', () async {
    final credentials = _CredentialRepository(session: _session);
    final preferences = _AuthPreferences();
    final cubit = HomeCubit(
      _HomeRepository(data: _data),
      credentials,
      authPreferences: preferences,
    );
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    await cubit.setAutoLoginEnabled(true);

    expect(preferences.enabled, isTrue);
    expect(credentials.persist, isTrue);
    expect(cubit.state.autoLoginEnabled, isTrue);
  });

  test('bật Alice lưu lựa chọn và cập nhật trạng thái', () async {
    final preferences = _AuthPreferences();
    final cubit = HomeCubit(
      _HomeRepository(data: _data),
      _CredentialRepository(),
      authPreferences: preferences,
    );
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    await cubit.setAliceBubbleEnabled(true);

    expect(preferences.aliceBubbleEnabled, isTrue);
    expect(cubit.state.aliceBubbleEnabled, isTrue);
    expect(cubit.state.isUpdatingAliceBubble, isFalse);
  });
}

class _AuthPreferences implements AuthPreferenceRepository {
  bool enabled = false;
  bool aliceBubbleEnabled = false;

  @override
  Future<bool> readAutoLoginEnabled() async => enabled;

  @override
  Future<String?> readLastEmail() async => null;

  @override
  Future<void> saveLastEmail(String email) async {}

  @override
  Future<void> setAutoLoginEnabled(bool value) async => enabled = value;
  @override
  Future<bool> readAliceBubbleEnabled() async => aliceBubbleEnabled;

  @override
  Future<void> setAliceBubbleEnabled(bool enabled) async =>
      aliceBubbleEnabled = enabled;
}

class _CredentialRepository implements CredentialRepository {
  _CredentialRepository({this.session});

  bool wasCleared = false;
  AuthSession? session;
  bool? persist;

  @override
  Future<void> clear() async => wasCleared = true;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {
    this.session = session;
    this.persist = persist;
  }
}

class _HomeRepository implements HomeRepository {
  _HomeRepository({this.data, this.error});

  final HomeData? data;
  final HomeException? error;
  int calls = 0;

  @override
  Future<HomeData> getHomeData() async {
    calls++;
    final failure = error;
    if (failure != null) throw failure;
    return data!;
  }
}

const _data = HomeData(
  user: AuthUser(
    id: 'id',
    employeeCode: 'EMP001',
    email: 'a@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
  leaveBalance: LeaveBalance(
    employeeCode: 'EMP001',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
  upcomingTrips: [],
);

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'id',
    employeeCode: 'EMP001',
    email: 'a@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
