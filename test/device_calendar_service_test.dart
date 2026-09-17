import 'package:chatbot_project/data/service/method_channel_device_calendar_service.dart';
import 'package:chatbot_project/domain/model/calendar_event.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('calendar-test');
  const service = MethodChannelDeviceCalendarService(channel: channel);
  const results = {
    'saved': CalendarEventResult.saved,
    'cancelled': CalendarEventResult.cancelled,
    'opened': CalendarEventResult.opened,
    'permissionDenied': CalendarEventResult.permissionDenied,
    'unavailable': CalendarEventResult.unavailable,
  };

  for (final entry in results.entries) {
    test('maps native ${entry.key} calendar result', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (_) async => entry.key);
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, null),
      );

      expect(await service.openCreateEvent(_draft), entry.value);
    });
  }

  test('maps unavailable platform exception', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          channel,
          (_) async => throw PlatformException(code: 'unavailable'),
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null),
    );

    expect(
      await service.openCreateEvent(_draft),
      CalendarEventResult.unavailable,
    );
  });
}

final _draft = CalendarEventDraft(
  title: '[Jira] SCRUM-8 · Task',
  start: DateTime(2026, 9, 20),
  end: DateTime(2026, 9, 21),
  isAllDay: true,
);
