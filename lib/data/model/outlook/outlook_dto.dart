import 'package:freezed_annotation/freezed_annotation.dart';

part 'outlook_dto.freezed.dart';
part 'outlook_dto.g.dart';

@freezed
abstract class OutlookStatusDto with _$OutlookStatusDto {
  const factory OutlookStatusDto({
    required bool configured,
    required bool connected,
    String? microsoftEmail,
  }) = _OutlookStatusDto;

  factory OutlookStatusDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookStatusDtoFromJson(json);
}

@freezed
abstract class OutlookAuthUrlDto with _$OutlookAuthUrlDto {
  const factory OutlookAuthUrlDto({required String url}) = _OutlookAuthUrlDto;

  factory OutlookAuthUrlDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookAuthUrlDtoFromJson(json);
}

@freezed
abstract class OutlookEventDto with _$OutlookEventDto {
  const factory OutlookEventDto({
    required String id,
    required String subject,
    required String start,
    required String end,
    @Default('busy') String showAs,
    @Default(false) bool isAllDay,
    String? location,
    String? webLink,
  }) = _OutlookEventDto;

  factory OutlookEventDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookEventDtoFromJson(json);
}

@freezed
abstract class OutlookMailDto with _$OutlookMailDto {
  const factory OutlookMailDto({
    required String id,
    required String subject,
    required String from,
    required String receivedAt,
    required String preview,
    required bool isRead,
    required bool hasAttachments,
    required String importance,
    String? body,
  }) = _OutlookMailDto;

  factory OutlookMailDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookMailDtoFromJson(json);
}

@freezed
abstract class OutlookCalendarResponseDto with _$OutlookCalendarResponseDto {
  const factory OutlookCalendarResponseDto({
    required bool configured,
    required bool connected,
    String? microsoftEmail,
    @Default(<OutlookEventDto>[]) List<OutlookEventDto> events,
    String? error,
  }) = _OutlookCalendarResponseDto;

  factory OutlookCalendarResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookCalendarResponseDtoFromJson(json);
}

@freezed
abstract class OutlookMailListResponseDto with _$OutlookMailListResponseDto {
  const factory OutlookMailListResponseDto({
    required bool configured,
    required bool connected,
    String? microsoftEmail,
    @Default(false) bool unreadOnly,
    String? from,
    String? to,
    @Default(0) int count,
    @Default(<OutlookMailDto>[]) List<OutlookMailDto> mails,
    String? error,
  }) = _OutlookMailListResponseDto;

  factory OutlookMailListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookMailListResponseDtoFromJson(json);
}

@freezed
abstract class OutlookMailDetailResponseDto
    with _$OutlookMailDetailResponseDto {
  const factory OutlookMailDetailResponseDto({
    required bool configured,
    required bool connected,
    String? microsoftEmail,
    OutlookMailDto? mail,
    String? error,
  }) = _OutlookMailDetailResponseDto;

  factory OutlookMailDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OutlookMailDetailResponseDtoFromJson(json);
}
