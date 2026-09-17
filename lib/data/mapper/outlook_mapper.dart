import '../../domain/model/outlook.dart';
import '../model/outlook/outlook_dto.dart';

abstract final class OutlookMapper {
  static OutlookConnectionStatus mapStatus(OutlookStatusDto dto) =>
      OutlookConnectionStatus(
        configured: dto.configured,
        connected: dto.connected,
        microsoftEmail: _nullable(dto.microsoftEmail),
      );

  static OutlookCalendarEvent mapEvent(OutlookEventDto dto) =>
      OutlookCalendarEvent(
        id: dto.id,
        subject: dto.subject,
        start: dto.start,
        end: dto.end,
        showAs: dto.showAs,
        isAllDay: dto.isAllDay,
        location: _nullable(dto.location),
        webLink: _nullable(dto.webLink),
      );

  static OutlookMail mapMail(OutlookMailDto dto) => OutlookMail(
    id: dto.id,
    subject: dto.subject,
    from: dto.from,
    receivedAt: dto.receivedAt,
    preview: dto.preview,
    isRead: dto.isRead,
    hasAttachments: dto.hasAttachments,
    importance: dto.importance,
    body: _nullable(dto.body),
  );

  static String? _nullable(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
