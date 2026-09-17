import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JiraCalendarDraftState extends Equatable {
  const JiraCalendarDraftState({
    required this.date,
    this.isAllDay = true,
    this.reminderEnabled = true,
  });

  final DateTime date;
  final bool isAllDay;
  final bool reminderEnabled;

  JiraCalendarDraftState copyWith({
    DateTime? date,
    bool? isAllDay,
    bool? reminderEnabled,
  }) => JiraCalendarDraftState(
    date: date ?? this.date,
    isAllDay: isAllDay ?? this.isAllDay,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
  );

  @override
  List<Object?> get props => [date, isAllDay, reminderEnabled];
}

class JiraCalendarDraftCubit extends Cubit<JiraCalendarDraftState> {
  JiraCalendarDraftCubit({DateTime? initialDate})
    : super(JiraCalendarDraftState(date: initialDate ?? DateTime.now()));

  void selectDate(DateTime date) => emit(state.copyWith(date: date));

  void selectAllDay(bool value) => emit(state.copyWith(isAllDay: value));

  void setReminder(bool enabled) =>
      emit(state.copyWith(reminderEnabled: enabled));
}
