import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/outlook.dart';
import '../../../../domain/repository/outlook_repository.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';

enum OutlookLoadStatus { initial, loading, success, failure }

enum OutlookView { status, calendar, conflicts, mails, mailDetail }

class OutlookState extends Equatable {
  const OutlookState({
    this.status = OutlookLoadStatus.initial,
    this.connection,
    this.calendar,
    this.mailList,
    this.mail,
    this.failure,
    this.failureMessage,
    this.actionInProgress = false,
  });

  final OutlookLoadStatus status;
  final OutlookConnectionStatus? connection;
  final OutlookCalendarData? calendar;
  final OutlookMailListData? mailList;
  final OutlookMail? mail;
  final OutlookFailureType? failure;
  final String? failureMessage;
  final bool actionInProgress;

  OutlookState copyWith({
    OutlookLoadStatus? status,
    OutlookConnectionStatus? connection,
    OutlookCalendarData? calendar,
    OutlookMailListData? mailList,
    OutlookMail? mail,
    OutlookFailureType? failure,
    String? failureMessage,
    bool? actionInProgress,
    bool clearFailure = false,
    bool clearData = false,
  }) => OutlookState(
    status: status ?? this.status,
    connection: connection ?? this.connection,
    calendar: clearData ? null : calendar ?? this.calendar,
    mailList: clearData ? null : mailList ?? this.mailList,
    mail: clearData ? null : mail ?? this.mail,
    failure: clearFailure ? null : failure ?? this.failure,
    failureMessage: clearFailure ? null : failureMessage ?? this.failureMessage,
    actionInProgress: actionInProgress ?? this.actionInProgress,
  );

  @override
  List<Object?> get props => [
    status,
    connection,
    calendar,
    mailList,
    mail,
    failure,
    failureMessage,
    actionInProgress,
  ];
}

class OutlookCubit extends Cubit<OutlookState> {
  OutlookCubit(this._repository, {DataRefreshCoordinator? refreshCoordinator})
    : super(const OutlookState()) {
    _refreshSubscription = refreshCoordinator?.changes.listen(_onRefresh);
  }

  final OutlookRepository _repository;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;
  OutlookView _activeView = OutlookView.status;
  ({String from, String to})? _calendarRange;
  ({bool unreadOnly, String? search}) _mailFilter = (
    unreadOnly: false,
    search: null,
  );
  String? _mailId;

  void _onRefresh(Set<DataRefreshScope> scopes) {
    if (!scopes.contains(DataRefreshScope.outlook) || isClosed) return;
    switch (_activeView) {
      case OutlookView.status:
        unawaited(loadStatus());
      case OutlookView.calendar:
      case OutlookView.conflicts:
        final range = _calendarRange;
        if (range != null) {
          unawaited(
            loadCalendar(
              from: range.from,
              to: range.to,
              conflictsOnly: _activeView == OutlookView.conflicts,
            ),
          );
        }
      case OutlookView.mails:
        unawaited(
          loadMails(
            unreadOnly: _mailFilter.unreadOnly,
            search: _mailFilter.search,
          ),
        );
      case OutlookView.mailDetail:
        final id = _mailId;
        if (id != null) unawaited(loadMail(id));
    }
  }

  Future<void> loadStatus() async {
    _activeView = OutlookView.status;
    emit(state.copyWith(status: OutlookLoadStatus.loading, clearFailure: true));
    try {
      emit(
        state.copyWith(
          status: OutlookLoadStatus.success,
          connection: await _repository.getStatus(),
          clearFailure: true,
        ),
      );
    } on OutlookException catch (error) {
      _emitFailure(error);
    }
  }

  Future<Uri?> getAuthUri() async {
    emit(state.copyWith(actionInProgress: true, clearFailure: true));
    try {
      final uri = await _repository.getAuthUri();
      emit(state.copyWith(actionInProgress: false));
      return uri;
    } on OutlookException catch (error) {
      _emitFailure(error);
      return null;
    }
  }

  Future<void> disconnect() async {
    emit(state.copyWith(actionInProgress: true, clearFailure: true));
    try {
      await _repository.disconnect();
      emit(
        state.copyWith(
          actionInProgress: false,
          status: OutlookLoadStatus.success,
          connection: const OutlookConnectionStatus(
            configured: true,
            connected: false,
          ),
          clearData: true,
        ),
      );
    } on OutlookException catch (error) {
      _emitFailure(error);
    }
  }

  Future<void> loadCalendar({
    required String from,
    required String to,
    bool conflictsOnly = false,
  }) async {
    _activeView = conflictsOnly ? OutlookView.conflicts : OutlookView.calendar;
    _calendarRange = (from: from, to: to);
    emit(state.copyWith(status: OutlookLoadStatus.loading, clearFailure: true));
    try {
      emit(
        state.copyWith(
          status: OutlookLoadStatus.success,
          calendar: conflictsOnly
              ? await _repository.getConflicts(from: from, to: to)
              : await _repository.getCalendar(from: from, to: to),
          clearFailure: true,
        ),
      );
    } on OutlookException catch (error) {
      _emitFailure(error);
    }
  }

  Future<void> loadMails({bool unreadOnly = false, String? search}) async {
    _activeView = OutlookView.mails;
    _mailFilter = (unreadOnly: unreadOnly, search: search);
    emit(state.copyWith(status: OutlookLoadStatus.loading, clearFailure: true));
    try {
      emit(
        state.copyWith(
          status: OutlookLoadStatus.success,
          mailList: await _repository.getMails(
            unreadOnly: unreadOnly,
            search: search,
          ),
          clearFailure: true,
        ),
      );
    } on OutlookException catch (error) {
      _emitFailure(error);
    }
  }

  Future<void> loadMail(String id) async {
    _activeView = OutlookView.mailDetail;
    _mailId = id;
    emit(state.copyWith(status: OutlookLoadStatus.loading, clearFailure: true));
    try {
      emit(
        state.copyWith(
          status: OutlookLoadStatus.success,
          mail: await _repository.getMail(id),
          clearFailure: true,
        ),
      );
    } on OutlookException catch (error) {
      _emitFailure(error);
    }
  }

  void _emitFailure(OutlookException error) {
    emit(
      state.copyWith(
        status: OutlookLoadStatus.failure,
        actionInProgress: false,
        failure: error.type,
        failureMessage: error.message,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }
}
