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
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
  highlights:
      (json['highlights'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
  uiAction: json['uiAction'] as Map<String, dynamic>?,
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
);

Map<String, dynamic> _$PersistedChatMessageDtoToJson(
  _PersistedChatMessageDto instance,
) => <String, dynamic>{
  'role': instance.role,
  'content': instance.content,
  'blocks': instance.blocks,
  'highlights': instance.highlights,
  'uiAction': instance.uiAction,
  'suggestions': instance.suggestions,
};

_ChatDoneDto _$ChatDoneDtoFromJson(Map<String, dynamic> json) => _ChatDoneDto(
  threadId: json['threadId'] as String,
  reply: json['reply'] as String? ?? '',
  confirm: json['confirm'] == null
      ? null
      : ChatConfirmationDto.fromJson(json['confirm'] as Map<String, dynamic>),
  uiAction: json['uiAction'] as Map<String, dynamic>?,
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
  highlights:
      (json['highlights'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
  didMutate: json['didMutate'] as bool? ?? false,
  citations:
      (json['citations'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$ChatDoneDtoToJson(_ChatDoneDto instance) =>
    <String, dynamic>{
      'threadId': instance.threadId,
      'reply': instance.reply,
      'confirm': instance.confirm,
      'uiAction': instance.uiAction,
      'blocks': instance.blocks,
      'highlights': instance.highlights,
      'suggestions': instance.suggestions,
      'didMutate': instance.didMutate,
      'citations': instance.citations,
    };

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
