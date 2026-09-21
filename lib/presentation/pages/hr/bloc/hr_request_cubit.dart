import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/auth_session.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/home_data.dart';
import '../../../../domain/model/hr_request.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/repository/hr_request_repository.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';

enum HrRequestKind { leave, trip }

enum HrRequestStatus { loading, success, failure }

enum HrAction { approve, reject, batchApprove }

class HrRequestState extends Equatable {
  const HrRequestState({
    this.status = HrRequestStatus.loading,
    this.leaves = const [],
    this.trips = const [],
    this.leave,
    this.trip,
    this.failure,
    this.isManager = false,
    this.action,
    this.actionError,
    this.actionSuccess,
    this.selectedIds = const {},
    this.batchResult,
    this.batchFailed = 0,
  });

  final HrRequestStatus status;
  final List<LeaveRequest> leaves;
  final List<TripRequest> trips;
  final LeaveRequest? leave;
  final TripRequest? trip;
  final HrFailureType? failure;
  final bool isManager;
  final HrAction? action;
  final HrException? actionError;
  final HrAction? actionSuccess;
  final Set<String> selectedIds;
  final String? batchResult;
  final int batchFailed;

  HrRequestState copyWith({
    List<LeaveRequest>? leaves,
    List<TripRequest>? trips,
    LeaveRequest? leave,
    TripRequest? trip,
    HrAction? action,
    HrException? actionError,
    HrAction? actionSuccess,
    Set<String>? selectedIds,
    String? batchResult,
    int? batchFailed,
    bool clearAction = false,
  }) => HrRequestState(
    status: status,
    leaves: leaves ?? this.leaves,
    trips: trips ?? this.trips,
    leave: leave ?? this.leave,
    trip: trip ?? this.trip,
    failure: failure,
    isManager: isManager,
    action: clearAction ? null : action ?? this.action,
    actionError: actionError,
    actionSuccess: actionSuccess,
    selectedIds: selectedIds ?? this.selectedIds,
    batchResult: batchResult,
    batchFailed: batchFailed ?? this.batchFailed,
  );

  @override
  List<Object?> get props => [
    status,
    leaves,
    trips,
    leave,
    trip,
    failure,
    isManager,
    action,
    actionError,
    actionSuccess,
    selectedIds,
    batchResult,
    batchFailed,
  ];
}

class HrRequestCubit extends Cubit<HrRequestState> {
  HrRequestCubit(
    this._repository,
    this._credentials, {
    DataRefreshCoordinator? refreshCoordinator,
  }) : _refreshCoordinator = refreshCoordinator,
       super(const HrRequestState()) {
    _refreshSubscription = refreshCoordinator?.changes.listen(_onRefresh);
  }

  final HrRequestRepository _repository;
  final CredentialRepository _credentials;
  final DataRefreshCoordinator? _refreshCoordinator;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;
  HrRequestKind? _activeKind;
  String? _activeId;
  bool _submitting = false;
  TripRequest? _initialTrip;
  String? _employeeName;

  Future<bool> _isManager() async =>
      (await _credentials.read())?.user.role == UserRole.manager;

  void _onRefresh(Set<DataRefreshScope> scopes) {
    final kind = _activeKind;
    if (kind == null || isClosed || _submitting) return;
    final affected = kind == HrRequestKind.leave
        ? scopes.contains(DataRefreshScope.leaves)
        : scopes.contains(DataRefreshScope.trips);
    if (!affected) return;
    final id = _activeId;
    if (id == null) {
      unawaited(loadList(kind));
    } else {
      unawaited(
        loadDetail(
          kind,
          id,
          initialTrip: _initialTrip,
          employeeName: _employeeName,
        ),
      );
    }
  }

  Future<void> loadList(HrRequestKind kind) async {
    _activeKind = kind;
    _activeId = null;
    emit(const HrRequestState());
    try {
      final manager = await _isManager();
      if (kind == HrRequestKind.leave) {
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            leaves: await _repository.getLeaves(team: manager),
            isManager: manager,
          ),
        );
      } else {
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            trips: await _repository.getTrips(team: manager),
            isManager: manager,
          ),
        );
      }
    } on HrException catch (error) {
      emit(
        HrRequestState(status: HrRequestStatus.failure, failure: error.type),
      );
    }
  }

  Future<void> loadDetail(
    HrRequestKind kind,
    String id, {
    TripRequest? initialTrip,
    String? employeeName,
  }) async {
    _activeKind = kind;
    _activeId = id;
    _initialTrip = initialTrip;
    _employeeName = employeeName;
    emit(const HrRequestState());
    try {
      final manager = await _isManager();
      if (kind == HrRequestKind.leave) {
        final leave = await _repository.getLeave(id);
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            leave: leave.copyWith(
              employeeName: leave.employeeName ?? employeeName,
            ),
            isManager: manager,
          ),
        );
      } else {
        final trip =
            initialTrip ??
            (await _repository.getTrips(
              team: manager,
            )).where((item) => item.id == id).firstOrNull;
        if (trip == null) throw const HrException(HrFailureType.notFound);
        emit(
          HrRequestState(
            status: HrRequestStatus.success,
            trip: trip,
            isManager: manager,
          ),
        );
      }
    } on HrException catch (error) {
      emit(
        HrRequestState(status: HrRequestStatus.failure, failure: error.type),
      );
    }
  }

  void toggleSelection(String id) {
    if (!state.isManager ||
        _submitting ||
        !state.leaves.any(
          (leave) => leave.id == id && leave.status == RequestStatus.pending,
        )) {
      return;
    }
    final selected = {...state.selectedIds};
    selected.contains(id) ? selected.remove(id) : selected.add(id);
    emit(state.copyWith(selectedIds: selected, clearAction: true));
  }

  Future<void> setStatus(HrRequestKind kind, RequestStatus status) async {
    final itemStatus = kind == HrRequestKind.leave
        ? state.leave?.status
        : state.trip?.status;
    if (_submitting ||
        !state.isManager ||
        itemStatus != RequestStatus.pending ||
        (status != RequestStatus.approved &&
            status != RequestStatus.rejected)) {
      return;
    }
    _submitting = true;
    final action = status == RequestStatus.approved
        ? HrAction.approve
        : HrAction.reject;
    emit(state.copyWith(action: action));
    try {
      if (kind == HrRequestKind.leave) {
        final updated = await _repository.setLeaveStatus(
          state.leave!.id,
          status,
        );
        emit(
          state.copyWith(
            leave: updated.copyWith(employeeName: state.leave!.employeeName),
            clearAction: true,
            actionSuccess: action,
          ),
        );
        _refreshCoordinator?.notify(const {DataRefreshScope.leaves});
      } else {
        final updated = await _repository.setTripStatus(state.trip!.id, status);
        _initialTrip = updated;
        emit(
          state.copyWith(
            trip: updated,
            clearAction: true,
            actionSuccess: action,
          ),
        );
        _refreshCoordinator?.notify(const {DataRefreshScope.trips});
      }
    } on HrException catch (error) {
      emit(state.copyWith(clearAction: true, actionError: error));
      if (error.statusCode == 400 || error.statusCode == 409) {
        await _refreshDetailAfterConflict(kind);
      }
    } finally {
      _submitting = false;
    }
  }

  Future<void> _refreshDetailAfterConflict(HrRequestKind kind) async {
    try {
      if (kind == HrRequestKind.leave) {
        emit(
          state.copyWith(leave: await _repository.getLeave(state.leave!.id)),
        );
      } else {
        final trips = await _repository.getTrips(team: true);
        final trip = trips
            .where((item) => item.id == state.trip!.id)
            .firstOrNull;
        if (trip != null) {
          _initialTrip = trip;
          emit(state.copyWith(trip: trip));
        }
      }
    } on HrException {
      // Keep the original error visible if refresh also fails.
    }
  }

  Future<void> approveSelected() async {
    if (_submitting || !state.isManager || state.selectedIds.isEmpty) return;
    final ids = state.selectedIds.toList(growable: false);
    if (ids.any(
      (id) => !state.leaves.any(
        (leave) => leave.id == id && leave.status == RequestStatus.pending,
      ),
    )) {
      return;
    }
    _submitting = true;
    emit(state.copyWith(action: HrAction.batchApprove));
    HrException? error;
    try {
      await _repository.approveLeaves(ids);
    } on HrException catch (caught) {
      error = caught;
    }
    try {
      final leaves = await _repository.getLeaves(team: true);
      final approved = ids
          .where(
            (id) => leaves.any(
              (leave) =>
                  leave.id == id && leave.status == RequestStatus.approved,
            ),
          )
          .length;
      emit(
        state.copyWith(
          leaves: leaves,
          selectedIds: const {},
          clearAction: true,
          actionError: error,
          actionSuccess: error == null ? HrAction.batchApprove : null,
          batchResult: '$approved/${ids.length}',
          batchFailed: ids.length - approved,
        ),
      );
      _refreshCoordinator?.notify(const {DataRefreshScope.leaves});
    } on HrException catch (refreshError) {
      emit(
        state.copyWith(clearAction: true, actionError: error ?? refreshError),
      );
    } finally {
      _submitting = false;
    }
  }

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }
}
