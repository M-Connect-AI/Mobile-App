import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/home_data.dart';
import '../../../../domain/repository/auth_preference_repository.dart';
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
    this.autoLoginEnabled = false,
    this.autoLoginPreferenceLoaded = false,
    this.isUpdatingAutoLogin = false,
    this.aliceBubbleEnabled = false,
    this.aliceBubblePreferenceLoaded = false,
    this.isUpdatingAliceBubble = false,
  });

  final HomeStatus status;
  final HomeData? data;
  final HomeFailureType? failureType;
  final String? errorMessage;
  final HomeTab tab;
  final bool autoLoginEnabled;
  final bool autoLoginPreferenceLoaded;
  final bool isUpdatingAutoLogin;
  final bool aliceBubbleEnabled;
  final bool aliceBubblePreferenceLoaded;
  final bool isUpdatingAliceBubble;

  HomeState copyWith({
    HomeStatus? status,
    HomeData? data,
    HomeFailureType? failureType,
    String? errorMessage,
    bool clearError = false,
    HomeTab? tab,
    bool? autoLoginEnabled,
    bool? autoLoginPreferenceLoaded,
    bool? isUpdatingAutoLogin,
    bool? aliceBubbleEnabled,
    bool? aliceBubblePreferenceLoaded,
    bool? isUpdatingAliceBubble,
  }) => HomeState(
    status: status ?? this.status,
    data: data ?? this.data,
    failureType: clearError ? null : failureType ?? this.failureType,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    tab: tab ?? this.tab,
    autoLoginEnabled: autoLoginEnabled ?? this.autoLoginEnabled,
    autoLoginPreferenceLoaded:
        autoLoginPreferenceLoaded ?? this.autoLoginPreferenceLoaded,
    isUpdatingAutoLogin: isUpdatingAutoLogin ?? this.isUpdatingAutoLogin,
    aliceBubbleEnabled: aliceBubbleEnabled ?? this.aliceBubbleEnabled,
    aliceBubblePreferenceLoaded:
        aliceBubblePreferenceLoaded ?? this.aliceBubblePreferenceLoaded,
    isUpdatingAliceBubble: isUpdatingAliceBubble ?? this.isUpdatingAliceBubble,
  );

  @override
  List<Object?> get props => [
    status,
    data,
    failureType,
    errorMessage,
    tab,
    autoLoginEnabled,
    autoLoginPreferenceLoaded,
    isUpdatingAutoLogin,
    aliceBubbleEnabled,
    aliceBubblePreferenceLoaded,
    isUpdatingAliceBubble,
  ];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._repository,
    this._credentials, {
    required AuthPreferenceRepository authPreferences,
    DataRefreshCoordinator? refreshCoordinator,
  }) : _authPreferences = authPreferences,
       super(const HomeState()) {
    unawaited(_loadAutoLoginPreference());
    unawaited(_loadAliceBubblePreference());
    _refreshSubscription = refreshCoordinator?.changes.listen((scopes) {
      if (scopes.contains(DataRefreshScope.home) && !isClosed) {
        unawaited(load());
      }
    });
  }

  final HomeRepository _repository;
  final CredentialRepository _credentials;
  final AuthPreferenceRepository _authPreferences;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;

  Future<void> _loadAliceBubblePreference() async {
    try {
      final enabled = await _authPreferences.readAliceBubbleEnabled();
      if (!isClosed) {
        emit(
          state.copyWith(
            aliceBubbleEnabled: enabled,
            aliceBubblePreferenceLoaded: true,
          ),
        );
      }
    } on Object {
      if (!isClosed) {
        emit(state.copyWith(aliceBubblePreferenceLoaded: true));
      }
    }
  }

  Future<void> setAliceBubbleEnabled(bool enabled) async {
    if (state.isUpdatingAliceBubble || !state.aliceBubblePreferenceLoaded) {
      return;
    }
    emit(state.copyWith(isUpdatingAliceBubble: true));
    try {
      await _authPreferences.setAliceBubbleEnabled(enabled);
      if (!isClosed) {
        emit(
          state.copyWith(
            aliceBubbleEnabled: enabled,
            isUpdatingAliceBubble: false,
          ),
        );
      }
    } on Object {
      if (!isClosed) {
        emit(state.copyWith(isUpdatingAliceBubble: false));
      }
    }
  }

  Future<void> _loadAutoLoginPreference() async {
    try {
      final enabled = await _authPreferences.readAutoLoginEnabled();
      if (!isClosed) {
        emit(
          state.copyWith(
            autoLoginEnabled: enabled,
            autoLoginPreferenceLoaded: true,
          ),
        );
      }
    } on Object {
      if (!isClosed) {
        emit(state.copyWith(autoLoginPreferenceLoaded: true));
      }
    }
  }

  Future<void> setAutoLoginEnabled(bool enabled) async {
    if (state.isUpdatingAutoLogin) return;
    final previousValue = state.autoLoginEnabled;
    emit(state.copyWith(autoLoginEnabled: enabled, isUpdatingAutoLogin: true));
    try {
      final session = await _credentials.read();
      if (session != null) {
        await _credentials.save(session, persist: enabled);
      }
      await _authPreferences.setAutoLoginEnabled(enabled);
      emit(state.copyWith(isUpdatingAutoLogin: false));
    } on Object {
      emit(
        state.copyWith(
          autoLoginEnabled: previousValue,
          isUpdatingAutoLogin: false,
        ),
      );
    }
  }

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
