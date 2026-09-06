import '../../../domain/model/auth_session.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/home_repository.dart';
import '../../model/auth/login_models.dart';
import '../../model/home/home_models.dart';
import '../../source/remote/home_remote_data_source.dart';

class ApiHomeRepository implements HomeRepository {
  const ApiHomeRepository(
    this._remote,
    this._sessions, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final HomeRemoteDataSource _remote;
  final CredentialRepository _sessions;
  final DateTime Function() _now;

  @override
  Future<HomeData> getHomeData() async {
    final session = await _sessions.read();
    if (session == null || session.accessToken.isEmpty) {
      throw const HomeException(
        type: HomeFailureType.sessionExpired,
        message: 'Phiên đăng nhập không tồn tại.',
      );
    }
    try {
      final results = await Future.wait<Object>([
        _remote.getProfile(session.accessToken),
        _remote.getLeaveBalance(session.accessToken),
        _remote.getMyTrips(session.accessToken),
      ]);
      final user = _mapUser(results[0] as AuthUserDto);
      final balance = _mapBalance(results[1] as LeaveBalanceDto);
      final trips =
          (results[2] as List<BusinessTripDto>)
              .map(_mapTrip)
              .where(_isUpcoming)
              .toList(growable: false)
            ..sort((left, right) => left.from.compareTo(right.from));
      return HomeData(user: user, leaveBalance: balance, upcomingTrips: trips);
    } on HomeRemoteException catch (error) {
      if (error.type == HomeRemoteErrorType.unauthorized) {
        await _sessions.clear();
      }
      throw HomeException(
        type: switch (error.type) {
          HomeRemoteErrorType.unauthorized => HomeFailureType.sessionExpired,
          HomeRemoteErrorType.forbidden => HomeFailureType.permissionDenied,
          HomeRemoteErrorType.network => HomeFailureType.network,
          HomeRemoteErrorType.server => HomeFailureType.server,
          HomeRemoteErrorType.malformed => HomeFailureType.invalidResponse,
        },
        message: error.message,
      );
    } on HomeException {
      rethrow;
    } on Object {
      throw const HomeException(
        type: HomeFailureType.invalidResponse,
        message: 'Không thể xử lý dữ liệu Home.',
      );
    }
  }

  bool _isUpcoming(BusinessTrip trip) {
    final today = _dateOnly(_now());
    return (trip.status == RequestStatus.pending ||
            trip.status == RequestStatus.approved) &&
        !trip.to.isBefore(today);
  }

  AuthUser _mapUser(AuthUserDto dto) => AuthUser(
    id: dto.id,
    employeeCode: dto.employeeCode,
    email: dto.email,
    fullName: dto.fullName,
    role: switch (dto.role) {
      'STAFF' => UserRole.staff,
      'MANAGER' => UserRole.manager,
      _ => throw const HomeException(
        type: HomeFailureType.invalidResponse,
        message: 'Vai trò người dùng không hợp lệ.',
      ),
    },
    department: dto.department,
    managerEmployeeCode: dto.managerEmployeeCode,
    annualRemaining: dto.annualRemaining,
    annualTotal: dto.annualTotal,
    sickRemaining: dto.sickRemaining,
  );

  LeaveBalance _mapBalance(LeaveBalanceDto dto) => LeaveBalance(
    employeeCode: dto.employeeCode,
    annualRemaining: dto.annualRemaining,
    annualTotal: dto.annualTotal,
    sickRemaining: dto.sickRemaining,
  );

  BusinessTrip _mapTrip(BusinessTripDto dto) {
    final id = dto.id ?? dto.mongoId;
    final from = DateTime.tryParse(dto.from);
    final to = DateTime.tryParse(dto.to);
    final status = switch (dto.status) {
      'PENDING' => RequestStatus.pending,
      'APPROVED' => RequestStatus.approved,
      'REJECTED' => RequestStatus.rejected,
      'CANCELLED' => RequestStatus.cancelled,
      _ => null,
    };
    if (id == null ||
        id.isEmpty ||
        from == null ||
        to == null ||
        status == null) {
      throw const HomeException(
        type: HomeFailureType.invalidResponse,
        message: 'Dữ liệu chuyến công tác không hợp lệ.',
      );
    }
    return BusinessTrip(
      id: id,
      employeeCode: dto.employeeCode,
      destination: dto.destination,
      from: _dateOnly(from),
      to: _dateOnly(to),
      purpose: dto.purpose,
      status: status,
      createdAt: DateTime.tryParse(dto.createdAt ?? ''),
      updatedAt: DateTime.tryParse(dto.updatedAt ?? ''),
    );
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
