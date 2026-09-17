import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

enum CalendarEventResult {
  saved,
  cancelled,
  opened,
  permissionDenied,
  unavailable,
  failed,
}

@freezed
abstract class CalendarEventDraft with _$CalendarEventDraft {
  const factory CalendarEventDraft({
    required String title,
    String? description,
    required DateTime start,
    required DateTime end,
    required bool isAllDay,
    Duration? reminderBefore,
  }) = _CalendarEventDraft;
}
