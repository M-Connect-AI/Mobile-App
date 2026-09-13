// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatTurnRequestDto _$ChatTurnRequestDtoFromJson(Map<String, dynamic> json) =>
    _ChatTurnRequestDto(
      message: json['message'] as String,
      threadId: json['threadId'] as String?,
      confirm: json['confirm'] as bool?,
    );

Map<String, dynamic> _$ChatTurnRequestDtoToJson(_ChatTurnRequestDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'threadId': ?instance.threadId,
      'confirm': ?instance.confirm,
    };

_ChatThreadSummaryDto _$ChatThreadSummaryDtoFromJson(
  Map<String, dynamic> json,
) => _ChatThreadSummaryDto(
  threadId: json['threadId'] as String,
  title: json['title'] as String,
  preview: json['preview'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$ChatThreadSummaryDtoToJson(
  _ChatThreadSummaryDto instance,
) => <String, dynamic>{
  'threadId': instance.threadId,
  'title': instance.title,
  'preview': instance.preview,
  'updatedAt': instance.updatedAt,
};

_PersistedChatMessageDto _$PersistedChatMessageDtoFromJson(
  Map<String, dynamic> json,
) => _PersistedChatMessageDto(
  role: json['role'] as String,
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$PersistedChatMessageDtoToJson(
  _PersistedChatMessageDto instance,
) => <String, dynamic>{'role': instance.role, 'content': instance.content};

_ChatConfirmationDto _$ChatConfirmationDtoFromJson(Map<String, dynamic> json) =>
    _ChatConfirmationDto(
      tool: json['tool'] as String,
      args: json['args'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$ChatConfirmationDtoToJson(
  _ChatConfirmationDto instance,
) => <String, dynamic>{
  'tool': instance.tool,
  'args': instance.args,
  'summary': instance.summary,
};

_ChatThreadDetailDto _$ChatThreadDetailDtoFromJson(Map<String, dynamic> json) =>
    _ChatThreadDetailDto(
      threadId: json['threadId'] as String,
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PersistedChatMessageDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <PersistedChatMessageDto>[],
      pendingAction: json['pendingAction'] == null
          ? null
          : ChatConfirmationDto.fromJson(
              json['pendingAction'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ChatThreadDetailDtoToJson(
  _ChatThreadDetailDto instance,
) => <String, dynamic>{
  'threadId': instance.threadId,
  'messages': instance.messages,
  'pendingAction': instance.pendingAction,
};
