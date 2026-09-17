import 'package:freezed_annotation/freezed_annotation.dart';

part 'outlook.freezed.dart';

@freezed
abstract class OutlookConnectionStatus with _$OutlookConnectionStatus {
  const factory OutlookConnectionStatus({
    required bool configured,
    required bool connected,
    String? microsoftEmail,
  }) = _OutlookConnectionStatus;
}

@freezed
abstract class OutlookCalendarEvent with _$OutlookCalendarEvent {
  const factory OutlookCalendarEvent({
    required String id,
    required String subject,
    required String start,
    required String end,
    @Default('busy') String showAs,
    @Default(false) bool isAllDay,
    String? location,
    String? webLink,
  }) = _OutlookCalendarEvent;
}

@freezed
abstract class OutlookMail with _$OutlookMail {
  const factory OutlookMail({
    required String id,
    required String subject,
    required String from,
    required String receivedAt,
    required String preview,
    required bool isRead,
    required bool hasAttachments,
    required String importance,
    String? body,
  }) = _OutlookMail;
}

@freezed
abstract class OutlookCalendarData with _$OutlookCalendarData {
  const factory OutlookCalendarData({
    required String microsoftEmail,
    required List<OutlookCalendarEvent> events,
  }) = _OutlookCalendarData;
}

@freezed
abstract class OutlookMailListData with _$OutlookMailListData {
  const factory OutlookMailListData({
    required String microsoftEmail,
    required List<OutlookMail> mails,
    required bool unreadOnly,
    String? from,
    String? to,
  }) = _OutlookMailListData;
}

@freezed
abstract class OutlookEventMutation with _$OutlookEventMutation {
  const factory OutlookEventMutation({
    required String microsoftEmail,
    required OutlookCalendarEvent event,
  }) = _OutlookEventMutation;
}

@freezed
abstract class OutlookReplyMutation with _$OutlookReplyMutation {
  const factory OutlookReplyMutation({
    required String microsoftEmail,
    required String messageId,
  }) = _OutlookReplyMutation;
}
