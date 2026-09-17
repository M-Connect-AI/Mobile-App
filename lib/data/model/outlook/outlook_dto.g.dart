// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlook_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OutlookStatusDto _$OutlookStatusDtoFromJson(Map<String, dynamic> json) =>
    _OutlookStatusDto(
      configured: json['configured'] as bool,
      connected: json['connected'] as bool,
      microsoftEmail: json['microsoftEmail'] as String?,
    );

Map<String, dynamic> _$OutlookStatusDtoToJson(_OutlookStatusDto instance) =>
    <String, dynamic>{
      'configured': instance.configured,
      'connected': instance.connected,
      'microsoftEmail': instance.microsoftEmail,
    };

_OutlookAuthUrlDto _$OutlookAuthUrlDtoFromJson(Map<String, dynamic> json) =>
    _OutlookAuthUrlDto(url: json['url'] as String);

Map<String, dynamic> _$OutlookAuthUrlDtoToJson(_OutlookAuthUrlDto instance) =>
    <String, dynamic>{'url': instance.url};

_OutlookEventDto _$OutlookEventDtoFromJson(Map<String, dynamic> json) =>
    _OutlookEventDto(
      id: json['id'] as String,
      subject: json['subject'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      showAs: json['showAs'] as String? ?? 'busy',
      isAllDay: json['isAllDay'] as bool? ?? false,
      location: json['location'] as String?,
      webLink: json['webLink'] as String?,
    );

Map<String, dynamic> _$OutlookEventDtoToJson(_OutlookEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'start': instance.start,
      'end': instance.end,
      'showAs': instance.showAs,
      'isAllDay': instance.isAllDay,
      'location': instance.location,
      'webLink': instance.webLink,
    };

_OutlookMailDto _$OutlookMailDtoFromJson(Map<String, dynamic> json) =>
    _OutlookMailDto(
      id: json['id'] as String,
      subject: json['subject'] as String,
      from: json['from'] as String,
      receivedAt: json['receivedAt'] as String,
      preview: json['preview'] as String,
      isRead: json['isRead'] as bool,
      hasAttachments: json['hasAttachments'] as bool,
      importance: json['importance'] as String,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$OutlookMailDtoToJson(_OutlookMailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'from': instance.from,
      'receivedAt': instance.receivedAt,
      'preview': instance.preview,
      'isRead': instance.isRead,
      'hasAttachments': instance.hasAttachments,
      'importance': instance.importance,
      'body': instance.body,
    };

_OutlookCalendarResponseDto _$OutlookCalendarResponseDtoFromJson(
  Map<String, dynamic> json,
) => _OutlookCalendarResponseDto(
  configured: json['configured'] as bool,
  connected: json['connected'] as bool,
  microsoftEmail: json['microsoftEmail'] as String?,
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => OutlookEventDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OutlookEventDto>[],
  error: json['error'] as String?,
);

Map<String, dynamic> _$OutlookCalendarResponseDtoToJson(
  _OutlookCalendarResponseDto instance,
) => <String, dynamic>{
  'configured': instance.configured,
  'connected': instance.connected,
  'microsoftEmail': instance.microsoftEmail,
  'events': instance.events,
  'error': instance.error,
};

_OutlookMailListResponseDto _$OutlookMailListResponseDtoFromJson(
  Map<String, dynamic> json,
) => _OutlookMailListResponseDto(
  configured: json['configured'] as bool,
  connected: json['connected'] as bool,
  microsoftEmail: json['microsoftEmail'] as String?,
  unreadOnly: json['unreadOnly'] as bool? ?? false,
  from: json['from'] as String?,
  to: json['to'] as String?,
  count: (json['count'] as num?)?.toInt() ?? 0,
  mails:
      (json['mails'] as List<dynamic>?)
          ?.map((e) => OutlookMailDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <OutlookMailDto>[],
  error: json['error'] as String?,
);

Map<String, dynamic> _$OutlookMailListResponseDtoToJson(
  _OutlookMailListResponseDto instance,
) => <String, dynamic>{
  'configured': instance.configured,
  'connected': instance.connected,
  'microsoftEmail': instance.microsoftEmail,
  'unreadOnly': instance.unreadOnly,
  'from': instance.from,
  'to': instance.to,
  'count': instance.count,
  'mails': instance.mails,
  'error': instance.error,
};

_OutlookMailDetailResponseDto _$OutlookMailDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) => _OutlookMailDetailResponseDto(
  configured: json['configured'] as bool,
  connected: json['connected'] as bool,
  microsoftEmail: json['microsoftEmail'] as String?,
  mail: json['mail'] == null
      ? null
      : OutlookMailDto.fromJson(json['mail'] as Map<String, dynamic>),
  error: json['error'] as String?,
);

Map<String, dynamic> _$OutlookMailDetailResponseDtoToJson(
  _OutlookMailDetailResponseDto instance,
) => <String, dynamic>{
  'configured': instance.configured,
  'connected': instance.connected,
  'microsoftEmail': instance.microsoftEmail,
  'mail': instance.mail,
  'error': instance.error,
};
