import 'package:chatbot_project/domain/model/chat_result.dart';
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
    final cubit = HrRequestCubit(repository, refreshCoordinator: coordinator);
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
}

class _HrRepository implements HrRequestRepository {
  int leaveListCalls = 0;

  @override
  Future<LeaveRequest> getLeave(String id) async => _leave;

  @override
  Future<List<LeaveRequest>> getLeaves() async {
    leaveListCalls++;
    return [_leave];
  }

  @override
  Future<List<TripRequest>> getTrips() async => [_trip];
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
