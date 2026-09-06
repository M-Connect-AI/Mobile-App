import 'package:chatbot_project/data/model/auth/login_models.dart';
import 'package:chatbot_project/data/model/home/home_models.dart';
import 'package:chatbot_project/data/repository/home/api_home_repository.dart';
import 'package:chatbot_project/data/source/remote/home_remote_data_source.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps, filters and sorts upcoming trips from backend', () async {
    final repository = ApiHomeRepository(
      _FakeRemote(
        trips: const [
          BusinessTripDto(
            id: 'later',
            employeeCode: 'EMP001',
            destination: 'Đà Nẵng',
            from: '2026-09-20',
            to: '2026-09-22',
            purpose: 'Họp dự án',
            status: 'APPROVED',
          ),
          BusinessTripDto(
            mongoId: 'next',
            employeeCode: 'EMP001',
            destination: 'Hà Nội',
            from: '2026-09-08',
            to: '2026-09-10',
            purpose: 'Gặp đối tác',
            status: 'PENDING',
          ),
          BusinessTripDto(
            id: 'cancelled',
            employeeCode: 'EMP001',
            destination: 'Huế',
            from: '2026-09-09',
            to: '2026-09-11',
            purpose: 'Đã hủy',
            status: 'CANCELLED',
          ),
        ],
      ),
      _SessionStore(_session),
      now: () => DateTime(2026, 9, 6),
    );

    final data = await repository.getHomeData();

    expect(data.user.fullName, 'Nguyễn Văn A');
    expect(data.leaveBalance.annualRemaining, 9);
    expect(
      data.upcomingTrips.map((trip) => trip.id),
      orderedEquals(['next', 'later']),
    );
  });

  test('returns an empty upcoming list when backend list is empty', () async {
    final repository = ApiHomeRepository(
      _FakeRemote(),
      _SessionStore(_session),
      now: () => DateTime(2026, 9, 6),
    );

    expect((await repository.getHomeData()).upcomingTrips, isEmpty);
  });

  test('clears session when backend returns 401', () async {
    final sessions = _SessionStore(_session);
    final repository = ApiHomeRepository(
      _FakeRemote(
        error: const HomeRemoteException(
          type: HomeRemoteErrorType.unauthorized,
          message: 'expired',
        ),
      ),
      sessions,
    );

    await expectLater(
      repository.getHomeData(),
      throwsA(
        isA<HomeException>().having(
          (error) => error.type,
          'type',
          HomeFailureType.sessionExpired,
        ),
      ),
    );
    expect(sessions.cleared, isTrue);
  });
}

class _FakeRemote extends HomeRemoteDataSource {
  _FakeRemote({this.trips = const [], this.error})
    : super(baseUrl: 'http://unused');

  final List<BusinessTripDto> trips;
  final HomeRemoteException? error;

  void _throwIfNeeded() {
    final failure = error;
    if (failure != null) throw failure;
  }

  @override
  Future<AuthUserDto> getProfile(String accessToken) async {
    _throwIfNeeded();
    return _user;
  }

  @override
  Future<LeaveBalanceDto> getLeaveBalance(String accessToken) async {
    _throwIfNeeded();
    return _balance;
  }

  @override
  Future<List<BusinessTripDto>> getMyTrips(String accessToken) async {
    _throwIfNeeded();
    return trips;
  }
}

class _SessionStore implements CredentialRepository {
  _SessionStore(this.session);

  AuthSession? session;
  bool cleared = false;

  @override
  Future<void> clear() async {
    cleared = true;
    session = null;
  }

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async =>
      session = value;
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
    annualRemaining: 8,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);

const _user = AuthUserDto(
  id: 'user-id',
  employeeCode: 'EMP001',
  email: 'a.nguyen@msb.vn',
  fullName: 'Nguyễn Văn A',
  role: 'STAFF',
  department: 'Khối bán lẻ',
  annualRemaining: 9,
  annualTotal: 12,
  sickRemaining: 30,
);

const _balance = LeaveBalanceDto(
  employeeCode: 'EMP001',
  annualRemaining: 9,
  annualTotal: 12,
  sickRemaining: 30,
);
