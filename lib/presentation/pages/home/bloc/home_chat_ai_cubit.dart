import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/auth_session.dart';
import '../../../../domain/model/chat_result.dart';
import '../../../../domain/model/chat_thread.dart';
import '../../../../domain/repository/chat_thread_repository.dart';
import '../../../../domain/repository/credential_repository.dart';
import '../../../../domain/service/data_refresh_coordinator.dart';

enum ChatThreadStatus { initial, loading, success, failure }

class HomeChatAiState extends Equatable {
  const HomeChatAiState({
    this.status = ChatThreadStatus.initial,
    this.threads = const [],
    this.role = UserRole.staff,
  });

  final ChatThreadStatus status;
  final List<ChatThread> threads;
  final UserRole role;

  HomeChatAiState copyWith({
    ChatThreadStatus? status,
    List<ChatThread>? threads,
    UserRole? role,
  }) => HomeChatAiState(
    status: status ?? this.status,
    threads: threads ?? this.threads,
    role: role ?? this.role,
  );

  @override
  List<Object> get props => [status, threads, role];
}

class HomeChatAiCubit extends Cubit<HomeChatAiState> {
  HomeChatAiCubit(
    this._repository,
    this._credentials, {
    DataRefreshCoordinator? refreshCoordinator,
  }) : super(const HomeChatAiState()) {
    _refreshSubscription = refreshCoordinator?.changes.listen((scopes) {
      if (scopes.contains(DataRefreshScope.chatHistory) && !isClosed) {
        unawaited(loadThreads());
      }
    });
  }

  final ChatThreadRepository _repository;
  final CredentialRepository _credentials;
  StreamSubscription<Set<DataRefreshScope>>? _refreshSubscription;

  Future<void> loadRole() async {
    try {
      final session = await _credentials.read();
      final role = session?.user.role;
      if (role != null) {
        emit(state.copyWith(role: role));
      }
    } on Object {
      // Giữ nguyên role mặc định (staff) nếu không đọc được session.
    }
  }

  Future<void> loadThreads() async {
    emit(state.copyWith(status: ChatThreadStatus.loading));
    try {
      final threads = await _repository.getThreads();
      emit(state.copyWith(status: ChatThreadStatus.success, threads: threads));
    } on Object {
      emit(state.copyWith(status: ChatThreadStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    await _refreshSubscription?.cancel();
    return super.close();
  }
}
