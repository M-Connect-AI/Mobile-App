import 'dart:async';

import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/model/hr_request.dart';
import 'package:chatbot_project/domain/repository/hr_request_repository.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:chatbot_project/presentation/pages/hr/bloc/hr_request_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('refetches only the active affected HR resource', () async {
    final repository = _HrRepository();
    final coordinator = DataRefreshCoordinator();
    final cubit = HrRequestCubit(
      repository,
      _Credentials(),
      refreshCoordinator: coordinator,
    );
    addTearDown(cubit.close);
    addTearDown(coordinator.close);

    await cubit.loadList(HrRequestKind.leave);
    expect(repository.leaveListCalls, 1);

    coordinator.notify(const {DataRefreshScope.trips});
    await Future<void>.delayed(Duration.zero);
    expect(repository.leaveListCalls, 1);

    coordinator.notify(const {DataRefreshScope.leaves});
    await Future<void>.delayed(Duration.zero);
    expect(repository.leaveListCalls, 2);
  });

  test(
    'only manager can mutate pending request; double submit is ignored',
    () async {
      final repository = _HrRepository();
      final staff = HrRequestCubit(repository, _Credentials());
      addTearDown(staff.close);
      await staff.loadDetail(HrRequestKind.leave, 'leave-1');
      await staff.setStatus(HrRequestKind.leave, RequestStatus.approved);
      expect(repository.statusCalls, 0);

      final manager = HrRequestCubit(repository, _Credentials(manager: true));
      addTearDown(manager.close);
      await manager.loadDetail(HrRequestKind.leave, 'leave-1');
      final pending = Completer<LeaveRequest>();
      repository.pendingStatus = pending;
      final first = manager.setStatus(
        HrRequestKind.leave,
        RequestStatus.approved,
      );
      final second = manager.setStatus(
        HrRequestKind.leave,
        RequestStatus.rejected,
      );
      expect(repository.statusCalls, 1);
      expect(repository.requestedStatus, RequestStatus.approved);
      expect(manager.state.leave!.status, RequestStatus.pending);
      pending.complete(_leave.copyWith(status: RequestStatus.approved));
      await Future.wait([first, second]);
      expect(manager.state.leave!.status, RequestStatus.approved);
      await manager.setStatus(HrRequestKind.leave, RequestStatus.rejected);
      expect(repository.statusCalls, 1);
    },
  );

  test('failed mutation preserves pending state', () async {
    final repository = _HrRepository()
      ..statusError = const HrException(HrFailureType.server);
    final cubit = HrRequestCubit(repository, _Credentials(manager: true));
    addTearDown(cubit.close);
    await cubit.loadDetail(HrRequestKind.leave, 'leave-1');
    await cubit.setStatus(HrRequestKind.leave, RequestStatus.rejected);
    expect(cubit.state.leave!.status, RequestStatus.pending);
    expect(cubit.state.actionError?.type, HrFailureType.server);
    expect(cubit.state.action, isNull);
  });

  test('partial batch failure refetches actual statuses', () async {
    final repository = _HrRepository()..partialBatchFailure = true;
    final cubit = HrRequestCubit(repository, _Credentials(manager: true));
    addTearDown(cubit.close);
    await cubit.loadList(HrRequestKind.leave);
    cubit.toggleSelection('leave-1');
    cubit.toggleSelection('leave-2');
    await cubit.approveSelected();
    expect(cubit.state.batchResult, '1/2');
    expect(cubit.state.leaves.first.status, RequestStatus.approved);
    expect(cubit.state.leaves.last.status, RequestStatus.pending);
    expect(repository.leaveListCalls, 2);
  });

  test('trip detail uses navigation item without detail endpoint', () async {
    final repository = _HrRepository();
    final cubit = HrRequestCubit(repository, _Credentials(manager: true));
    addTearDown(cubit.close);
    await cubit.loadDetail(HrRequestKind.trip, 'trip-1', initialTrip: _trip);
    expect(repository.tripListCalls, 0);
    expect(cubit.state.trip, _trip);
  });
}

class _HrRepository implements HrRequestRepository {
  int leaveListCalls = 0;
  int tripListCalls = 0;
  int statusCalls = 0;
  RequestStatus? requestedStatus;
  Completer<LeaveRequest>? pendingStatus;
  HrException? statusError;
  bool partialBatchFailure = false;
  bool firstApproved = false;

  @override
  Future<LeaveRequest> getLeave(String id) async => _leave;

  @override
  Future<List<LeaveRequest>> getLeaves({bool team = false}) async {
    leaveListCalls++;
    return [
      _leave.copyWith(
        status: firstApproved ? RequestStatus.approved : RequestStatus.pending,
      ),
      _leave.copyWith(id: 'leave-2'),
    ];
  }

  @override
  Future<List<TripRequest>> getTrips({bool team = false}) async {
    tripListCalls++;
    return [_trip];
  }

  @override
  Future<LeaveRequest> setLeaveStatus(String id, RequestStatus status) async {
    statusCalls++;
    requestedStatus = status;
    if (statusError case final error?) throw error;
    return pendingStatus?.future ?? _leave.copyWith(status: status);
  }

  @override
  Future<TripRequest> setTripStatus(String id, RequestStatus status) async =>
      _trip.copyWith(status: status);

  @override
  Future<void> approveLeaves(List<String> ids) async {
    if (partialBatchFailure) {
      firstApproved = true;
      throw const HrException(HrFailureType.server);
    }
  }
}

class _Credentials implements CredentialRepository {
  _Credentials({this.manager = false});
  final bool manager;
  @override
  Future<AuthSession?> read() async => AuthSession(
    accessToken: 'jwt',
    user: AuthUser(
      id: '1',
      employeeCode: 'EMP001',
      email: 'a@b.com',
      fullName: 'A',
      role: manager ? UserRole.manager : UserRole.staff,
      department: 'HR',
      annualRemaining: 1,
      annualTotal: 1,
      sickRemaining: 1,
    ),
  );
  @override
  Future<void> save(AuthSession session, {required bool persist}) async {}
  @override
  Future<void> clear() async {}
}

final _leave = LeaveRequest(
  id: 'leave-1',
  employeeCode: 'EMP001',
  type: LeaveType.annual,
  from: _date,
  to: _date,
  days: 1,
  reason: 'Nghỉ phép',
  status: RequestStatus.pending,
);

final _trip = TripRequest(
  id: 'trip-1',
  employeeCode: 'EMP001',
  destination: 'Đà Nẵng',
  from: _date,
  to: _date,
  purpose: 'Gặp khách hàng',
  status: RequestStatus.pending,
);

final _date = DateTime(2026, 9, 20);
