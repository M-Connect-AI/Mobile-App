import '../model/calendar_event.dart';

abstract interface class DeviceCalendarService {
  Future<CalendarEventResult> openCreateEvent(CalendarEventDraft draft);
}
