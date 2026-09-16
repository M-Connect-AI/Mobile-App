import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/home_data.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/repository/home_repository.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';

enum HomeStatus { initial, loading, success, failure, loggingOut, loggedOut }

enum HomeTab { home, utilities }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.data,
    this.failureType,
    this.errorMessage,
    this.tab = HomeTab.home,
  });

  final HomeStatus status;
  final HomeData? data;
  final HomeFailureType? failureType;
  final String? errorMessage;
  final HomeTab tab;

  HomeState copyWith({
    HomeStatus? status,
    HomeData? data,
    HomeFailureType? failureType,
    String? errorMessage,
    bool clearError = false,
    HomeTab? tab,
  }) => HomeState(
    status: status ?? this.status,
    data: data ?? this.data,
    failureType: clearError ? null : failureType ?? this.failureType,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    tab: tab ?? this.tab,
  );

  @override
  List<Object?> get props => [status, data, failureType, errorMessage, tab];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._repository,
    this._credentials, {
    DataRefreshCoordinator? refreshCoordinator,
  }) : super(const HomeState()) {
    _refreshSubscription = refreshCoordinator?.changes.listen((scopes) {
      if (scopes.contains(DataRefreshScope.home) && !isClosed) {
        unawaited(load());
      }
    });
  }

  final HomeRepository _repository;
  final CredentialRepository _credentials;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;

  void selectTab(HomeTab tab) => emit(state.copyWith(tab: tab));

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading, clearError: true));
    try {
      final data = await _repository.getHomeData();
      emit(state.copyWith(status: HomeStatus.success, data: data));
    } on HomeException catch (error) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failureType: error.type,
          errorMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failureType: HomeFailureType.invalidResponse,
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: HomeStatus.loggingOut, clearError: true));
    await _credentials.clear();
    emit(state.copyWith(status: HomeStatus.loggedOut));
  }

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }
}
