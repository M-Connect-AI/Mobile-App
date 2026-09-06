import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/home_data.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/repository/home_repository.dart';

enum HomeStatus { initial, loading, success, failure, loggingOut, loggedOut }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.data,
    this.failureType,
    this.errorMessage,
  });

  final HomeStatus status;
  final HomeData? data;
  final HomeFailureType? failureType;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    HomeData? data,
    HomeFailureType? failureType,
    String? errorMessage,
    bool clearError = false,
  }) => HomeState(
    status: status ?? this.status,
    data: data ?? this.data,
    failureType: clearError ? null : failureType ?? this.failureType,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, data, failureType, errorMessage];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository, this._credentials) : super(const HomeState());

  final HomeRepository _repository;
  final CredentialRepository _credentials;

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
}
