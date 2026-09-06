import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emits loading then success', () async {
    final cubit = HomeCubit(
      _HomeRepository(data: _data),
      _CredentialRepository(),
    );
    addTearDown(cubit.close);
    final states = <HomeState>[];
    final subscription = cubit.stream.listen(states.add);
    addTearDown(subscription.cancel);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(states.map((state) => state.status), [
      HomeStatus.loading,
      HomeStatus.success,
    ]);
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
    );
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.status, HomeStatus.failure);
    expect(cubit.state.failureType, HomeFailureType.network);
  });

  test('xóa credential và phát trạng thái đăng xuất', () async {
    final credentials = _CredentialRepository();
    final cubit = HomeCubit(_HomeRepository(data: _data), credentials);
    addTearDown(cubit.close);

    await cubit.logout();

    expect(credentials.wasCleared, isTrue);
    expect(cubit.state.status, HomeStatus.loggedOut);
  });
}

class _CredentialRepository implements CredentialRepository {
  bool wasCleared = false;

  @override
  Future<void> clear() async => wasCleared = true;

  @override
  Future<AuthSession?> read() async => null;

  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
}

class _HomeRepository implements HomeRepository {
  const _HomeRepository({this.data, this.error});

  final HomeData? data;
  final HomeException? error;

  @override
  Future<HomeData> getHomeData() async {
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
