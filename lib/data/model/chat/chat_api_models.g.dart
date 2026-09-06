// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatTurnRequestDtoImpl _$$ChatTurnRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ChatTurnRequestDtoImpl(
  message: json['message'] as String,
  threadId: json['threadId'] as String?,
  confirm: json['confirm'] as bool?,
);

Map<String, dynamic> _$$ChatTurnRequestDtoImplToJson(
  _$ChatTurnRequestDtoImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  if (instance.threadId case final value?) 'threadId': value,
  if (instance.confirm case final value?) 'confirm': value,
};

_$ChatThreadSummaryDtoImpl _$$ChatThreadSummaryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ChatThreadSummaryDtoImpl(
  threadId: json['threadId'] as String,
  title: json['title'] as String,
  preview: json['preview'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$$ChatThreadSummaryDtoImplToJson(
  _$ChatThreadSummaryDtoImpl instance,
) => <String, dynamic>{
  'threadId': instance.threadId,
  'title': instance.title,
  'preview': instance.preview,
  'updatedAt': instance.updatedAt,
};

_$PersistedChatMessageDtoImpl _$$PersistedChatMessageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PersistedChatMessageDtoImpl(
  role: json['role'] as String,
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$$PersistedChatMessageDtoImplToJson(
  _$PersistedChatMessageDtoImpl instance,
) => <String, dynamic>{'role': instance.role, 'content': instance.content};

_$ChatConfirmationDtoImpl _$$ChatConfirmationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ChatConfirmationDtoImpl(
  tool: json['tool'] as String,
  args: json['args'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  summary: json['summary'] as String,
);

Map<String, dynamic> _$$ChatConfirmationDtoImplToJson(
  _$ChatConfirmationDtoImpl instance,
) => <String, dynamic>{
  'tool': instance.tool,
  'args': instance.args,
  'summary': instance.summary,
};

_$ChatThreadDetailDtoImpl _$$ChatThreadDetailDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ChatThreadDetailDtoImpl(
  threadId: json['threadId'] as String,
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map(
            (e) => PersistedChatMessageDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <PersistedChatMessageDto>[],
  pendingAction: json['pendingAction'] == null
      ? null
      : ChatConfirmationDto.fromJson(
          json['pendingAction'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$ChatThreadDetailDtoImplToJson(
  _$ChatThreadDetailDtoImpl instance,
) => <String, dynamic>{
  'threadId': instance.threadId,
  'messages': instance.messages,
  'pendingAction': instance.pendingAction,
};
