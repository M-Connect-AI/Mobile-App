import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_api_models.freezed.dart';
part 'chat_api_models.g.dart';

@freezed
abstract class ChatTurnRequestDto with _$ChatTurnRequestDto {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory ChatTurnRequestDto({
    required String message,
    String? threadId,
    bool? confirm,
  }) = _ChatTurnRequestDto;

  factory ChatTurnRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ChatTurnRequestDtoFromJson(json);
}

@freezed
abstract class ChatThreadSummaryDto with _$ChatThreadSummaryDto {
  const factory ChatThreadSummaryDto({
    required String threadId,
    required String title,
    required String preview,
    required String updatedAt,
  }) = _ChatThreadSummaryDto;

  factory ChatThreadSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$ChatThreadSummaryDtoFromJson(json);
}

@freezed
abstract class PersistedChatMessageDto with _$PersistedChatMessageDto {
  const factory PersistedChatMessageDto({
    required String role,
    @Default('') String content,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> blocks,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> highlights,
    Map<String, dynamic>? uiAction,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> suggestions,
  }) = _PersistedChatMessageDto;

  factory PersistedChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$PersistedChatMessageDtoFromJson(json);
}

@freezed
abstract class ChatDoneDto with _$ChatDoneDto {
  const factory ChatDoneDto({
    required String threadId,
    @Default('') String reply,
    ChatConfirmationDto? confirm,
    Map<String, dynamic>? uiAction,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> blocks,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> highlights,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> suggestions,
    @Default(false) bool didMutate,
    @Default(<String>[]) List<String> citations,
  }) = _ChatDoneDto;

  factory ChatDoneDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDoneDtoFromJson(json);
}

@freezed
abstract class ChatConfirmationDto with _$ChatConfirmationDto {
  const factory ChatConfirmationDto({
    required String tool,
    @Default(<String, dynamic>{}) Map<String, dynamic> args,
    required String summary,
  }) = _ChatConfirmationDto;

  factory ChatConfirmationDto.fromJson(Map<String, dynamic> json) =>
      _$ChatConfirmationDtoFromJson(json);
}

@freezed
abstract class ChatThreadDetailDto with _$ChatThreadDetailDto {
  const factory ChatThreadDetailDto({
    required String threadId,
    @Default(<PersistedChatMessageDto>[])
    List<PersistedChatMessageDto> messages,
    ChatConfirmationDto? pendingAction,
  }) = _ChatThreadDetailDto;

  factory ChatThreadDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ChatThreadDetailDtoFromJson(json);
}
