import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/model/chat_thread.dart';
import '../../../../domain/repository/chat_thread_repository.dart';

enum ChatThreadStatus { initial, loading, success, failure }

class HomeChatAiState extends Equatable {
  const HomeChatAiState({
    this.status = ChatThreadStatus.initial,
    this.threads = const [],
  });

  final ChatThreadStatus status;
  final List<ChatThread> threads;

  HomeChatAiState copyWith({
    ChatThreadStatus? status,
    List<ChatThread>? threads,
  }) => HomeChatAiState(
    status: status ?? this.status,
    threads: threads ?? this.threads,
  );

  @override
  List<Object> get props => [status, threads];
}

class HomeChatAiCubit extends Cubit<HomeChatAiState> {
  HomeChatAiCubit(this._repository) : super(const HomeChatAiState());

  final ChatThreadRepository _repository;

  Future<void> loadThreads() async {
    emit(state.copyWith(status: ChatThreadStatus.loading));
    try {
      final threads = await _repository.getThreads();
      emit(state.copyWith(status: ChatThreadStatus.success, threads: threads));
    } on Object {
      emit(state.copyWith(status: ChatThreadStatus.failure));
    }
  }
}
