import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/hr_request.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/repository/hr_request_repository.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';

enum HrRequestKind { leave, trip }

enum HrRequestStatus { loading, success, failure }

class HrRequestState extends Equatable {
  const HrRequestState({
    this.status = HrRequestStatus.loading,
    this.leaves = const [],
    this.trips = const [],
    this.leave,
    this.trip,
    this.failure,
  });

  final HrRequestStatus status;
  final List<LeaveRequest> leaves;
  final List<TripRequest> trips;
  final LeaveRequest? leave;
  final TripRequest? trip;
  final HrFailureType? failure;

  @override
  List<Object?> get props => [status, leaves, trips, leave, trip, failure];
}

class HrRequestCubit extends Cubit<HrRequestState> {
  HrRequestCubit(this._repository, {DataRefreshCoordinator? refreshCoordinator})
    : super(const HrRequestState()) {
    _refreshSubscription = refreshCoordinator?.changes.listen(_onRefresh);
  }

  final HrRequestRepository _repository;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;
  HrRequestKind? _activeKind;
  String? _activeId;

  void _onRefresh(Set<DataRefreshScope> scopes) {
    final kind = _activeKind;
    if (kind == null || isClosed) return;
    final affected = kind == HrRequestKind.leave
        ? scopes.contains(DataRefreshScope.leaves)
        : scopes.contains(DataRefreshScope.trips);
    if (!affected) return;
    final id = _activeId;
    if (id == null) {
      unawaited(loadList(kind));
    } else {
      unawaited(loadDetail(kind, id));
    }
  }

  Future<void> loadList(HrRequestKind kind) async {
    _activeKind = kind;
    _activeId = null;
    emit(const HrRequestState());
    try {
      if (kind == HrRequestKind.leave) {
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            leaves: await _repository.getLeaves(),
          ),
        );
      } else {
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            trips: await _repository.getTrips(),
          ),
        );
      }
    } on HrException catch (error) {
      emit(
        HrRequestState(status: HrRequestStatus.failure, failure: error.type),
      );
    }
  }

  Future<void> loadDetail(HrRequestKind kind, String id) async {
    _activeKind = kind;
    _activeId = id;
    emit(const HrRequestState());
    try {
      if (kind == HrRequestKind.leave) {
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            leave: await _repository.getLeave(id),
          ),
        );
      } else {
        // HR API does not expose GET /trips/:id; resolve the self-scoped list.
        final trips = await _repository.getTrips();
        final matches = trips.where((trip) => trip.id == id);
        if (matches.isEmpty) throw const HrException(HrFailureType.notFound);
        emit(
          HrRequestState(status: HrRequestStatus.success, trip: matches.first),
        );
      }
    } on HrException catch (error) {
      emit(
        HrRequestState(status: HrRequestStatus.failure, failure: error.type),
      );
    }
  }

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }
}
