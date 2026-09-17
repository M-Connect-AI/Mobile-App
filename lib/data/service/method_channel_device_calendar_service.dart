import 'package:flutter/services.dart';

import '../../domain/model/calendar_event.dart';
import '../../domain/service/device_calendar_service.dart';

class MethodChannelDeviceCalendarService implements DeviceCalendarService {
  const MethodChannelDeviceCalendarService({
    MethodChannel channel = const MethodChannel(_channelName),
  }) : _channel = channel;

  static const _channelName = 'com.irohasu.mconnect/device_calendar';
  final MethodChannel _channel;

  @override
  Future<CalendarEventResult> openCreateEvent(CalendarEventDraft draft) async {
    try {
      final result = await _channel.invokeMethod<String>('openCreateEvent', {
        'title': draft.title,
        'description': draft.description,
        'startMillis': draft.start.millisecondsSinceEpoch,
        'endMillis': draft.end.millisecondsSinceEpoch,
        'isAllDay': draft.isAllDay,
        'reminderMinutes': draft.reminderBefore?.inMinutes,
      });
      return switch (result) {
        'saved' => CalendarEventResult.saved,
        'cancelled' => CalendarEventResult.cancelled,
        'opened' => CalendarEventResult.opened,
        'permissionDenied' => CalendarEventResult.permissionDenied,
        'unavailable' => CalendarEventResult.unavailable,
        _ => CalendarEventResult.failed,
      };
    } on PlatformException catch (error) {
      return switch (error.code) {
        'permission_denied' => CalendarEventResult.permissionDenied,
        'unavailable' => CalendarEventResult.unavailable,
        _ => CalendarEventResult.failed,
      };
    } on MissingPluginException {
      return CalendarEventResult.unavailable;
    }
  }
}
