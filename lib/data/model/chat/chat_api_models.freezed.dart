// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatTurnRequestDto _$ChatTurnRequestDtoFromJson(Map<String, dynamic> json) {
  return _ChatTurnRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ChatTurnRequestDto {
  String get message => throw _privateConstructorUsedError;
  String? get threadId => throw _privateConstructorUsedError;
  bool? get confirm => throw _privateConstructorUsedError;

  /// Serializes this ChatTurnRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatTurnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatTurnRequestDtoCopyWith<ChatTurnRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatTurnRequestDtoCopyWith<$Res> {
  factory $ChatTurnRequestDtoCopyWith(
    ChatTurnRequestDto value,
    $Res Function(ChatTurnRequestDto) then,
  ) = _$ChatTurnRequestDtoCopyWithImpl<$Res, ChatTurnRequestDto>;
  @useResult
  $Res call({String message, String? threadId, bool? confirm});
}

/// @nodoc
class _$ChatTurnRequestDtoCopyWithImpl<$Res, $Val extends ChatTurnRequestDto>
    implements $ChatTurnRequestDtoCopyWith<$Res> {
  _$ChatTurnRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatTurnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? threadId = freezed,
    Object? confirm = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            threadId: freezed == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String?,
            confirm: freezed == confirm
                ? _value.confirm
                : confirm // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatTurnRequestDtoImplCopyWith<$Res>
    implements $ChatTurnRequestDtoCopyWith<$Res> {
  factory _$$ChatTurnRequestDtoImplCopyWith(
    _$ChatTurnRequestDtoImpl value,
    $Res Function(_$ChatTurnRequestDtoImpl) then,
  ) = __$$ChatTurnRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? threadId, bool? confirm});
}

/// @nodoc
class __$$ChatTurnRequestDtoImplCopyWithImpl<$Res>
    extends _$ChatTurnRequestDtoCopyWithImpl<$Res, _$ChatTurnRequestDtoImpl>
    implements _$$ChatTurnRequestDtoImplCopyWith<$Res> {
  __$$ChatTurnRequestDtoImplCopyWithImpl(
    _$ChatTurnRequestDtoImpl _value,
    $Res Function(_$ChatTurnRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatTurnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? threadId = freezed,
    Object? confirm = freezed,
  }) {
    return _then(
      _$ChatTurnRequestDtoImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: freezed == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String?,
        confirm: freezed == confirm
            ? _value.confirm
            : confirm // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ChatTurnRequestDtoImpl implements _ChatTurnRequestDto {
  const _$ChatTurnRequestDtoImpl({
    required this.message,
    this.threadId,
    this.confirm,
  });

  factory _$ChatTurnRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatTurnRequestDtoImplFromJson(json);

  @override
  final String message;
  @override
  final String? threadId;
  @override
  final bool? confirm;

  @override
  String toString() {
    return 'ChatTurnRequestDto(message: $message, threadId: $threadId, confirm: $confirm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatTurnRequestDtoImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.confirm, confirm) || other.confirm == confirm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, threadId, confirm);

  /// Create a copy of ChatTurnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatTurnRequestDtoImplCopyWith<_$ChatTurnRequestDtoImpl> get copyWith =>
      __$$ChatTurnRequestDtoImplCopyWithImpl<_$ChatTurnRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatTurnRequestDtoImplToJson(this);
  }
}

abstract class _ChatTurnRequestDto implements ChatTurnRequestDto {
  const factory _ChatTurnRequestDto({
    required final String message,
    final String? threadId,
    final bool? confirm,
  }) = _$ChatTurnRequestDtoImpl;

  factory _ChatTurnRequestDto.fromJson(Map<String, dynamic> json) =
      _$ChatTurnRequestDtoImpl.fromJson;

  @override
  String get message;
  @override
  String? get threadId;
  @override
  bool? get confirm;

  /// Create a copy of ChatTurnRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatTurnRequestDtoImplCopyWith<_$ChatTurnRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatThreadSummaryDto _$ChatThreadSummaryDtoFromJson(Map<String, dynamic> json) {
  return _ChatThreadSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$ChatThreadSummaryDto {
  String get threadId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get preview => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatThreadSummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatThreadSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThreadSummaryDtoCopyWith<ChatThreadSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThreadSummaryDtoCopyWith<$Res> {
  factory $ChatThreadSummaryDtoCopyWith(
    ChatThreadSummaryDto value,
    $Res Function(ChatThreadSummaryDto) then,
  ) = _$ChatThreadSummaryDtoCopyWithImpl<$Res, ChatThreadSummaryDto>;
  @useResult
  $Res call({String threadId, String title, String preview, String updatedAt});
}

/// @nodoc
class _$ChatThreadSummaryDtoCopyWithImpl<
  $Res,
  $Val extends ChatThreadSummaryDto
>
    implements $ChatThreadSummaryDtoCopyWith<$Res> {
  _$ChatThreadSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatThreadSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? title = null,
    Object? preview = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            threadId: null == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            preview: null == preview
                ? _value.preview
                : preview // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatThreadSummaryDtoImplCopyWith<$Res>
    implements $ChatThreadSummaryDtoCopyWith<$Res> {
  factory _$$ChatThreadSummaryDtoImplCopyWith(
    _$ChatThreadSummaryDtoImpl value,
    $Res Function(_$ChatThreadSummaryDtoImpl) then,
  ) = __$$ChatThreadSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String threadId, String title, String preview, String updatedAt});
}

/// @nodoc
class __$$ChatThreadSummaryDtoImplCopyWithImpl<$Res>
    extends _$ChatThreadSummaryDtoCopyWithImpl<$Res, _$ChatThreadSummaryDtoImpl>
    implements _$$ChatThreadSummaryDtoImplCopyWith<$Res> {
  __$$ChatThreadSummaryDtoImplCopyWithImpl(
    _$ChatThreadSummaryDtoImpl _value,
    $Res Function(_$ChatThreadSummaryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatThreadSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? title = null,
    Object? preview = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ChatThreadSummaryDtoImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        preview: null == preview
            ? _value.preview
            : preview // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatThreadSummaryDtoImpl implements _ChatThreadSummaryDto {
  const _$ChatThreadSummaryDtoImpl({
    required this.threadId,
    required this.title,
    required this.preview,
    required this.updatedAt,
  });

  factory _$ChatThreadSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatThreadSummaryDtoImplFromJson(json);

  @override
  final String threadId;
  @override
  final String title;
  @override
  final String preview;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'ChatThreadSummaryDto(threadId: $threadId, title: $title, preview: $preview, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThreadSummaryDtoImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, threadId, title, preview, updatedAt);

  /// Create a copy of ChatThreadSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThreadSummaryDtoImplCopyWith<_$ChatThreadSummaryDtoImpl>
  get copyWith =>
      __$$ChatThreadSummaryDtoImplCopyWithImpl<_$ChatThreadSummaryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatThreadSummaryDtoImplToJson(this);
  }
}

abstract class _ChatThreadSummaryDto implements ChatThreadSummaryDto {
  const factory _ChatThreadSummaryDto({
    required final String threadId,
    required final String title,
    required final String preview,
    required final String updatedAt,
  }) = _$ChatThreadSummaryDtoImpl;

  factory _ChatThreadSummaryDto.fromJson(Map<String, dynamic> json) =
      _$ChatThreadSummaryDtoImpl.fromJson;

  @override
  String get threadId;
  @override
  String get title;
  @override
  String get preview;
  @override
  String get updatedAt;

  /// Create a copy of ChatThreadSummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThreadSummaryDtoImplCopyWith<_$ChatThreadSummaryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PersistedChatMessageDto _$PersistedChatMessageDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PersistedChatMessageDto.fromJson(json);
}

/// @nodoc
mixin _$PersistedChatMessageDto {
  String get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this PersistedChatMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PersistedChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersistedChatMessageDtoCopyWith<PersistedChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersistedChatMessageDtoCopyWith<$Res> {
  factory $PersistedChatMessageDtoCopyWith(
    PersistedChatMessageDto value,
    $Res Function(PersistedChatMessageDto) then,
  ) = _$PersistedChatMessageDtoCopyWithImpl<$Res, PersistedChatMessageDto>;
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class _$PersistedChatMessageDtoCopyWithImpl<
  $Res,
  $Val extends PersistedChatMessageDto
>
    implements $PersistedChatMessageDtoCopyWith<$Res> {
  _$PersistedChatMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PersistedChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? content = null}) {
    return _then(
      _value.copyWith(
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PersistedChatMessageDtoImplCopyWith<$Res>
    implements $PersistedChatMessageDtoCopyWith<$Res> {
  factory _$$PersistedChatMessageDtoImplCopyWith(
    _$PersistedChatMessageDtoImpl value,
    $Res Function(_$PersistedChatMessageDtoImpl) then,
  ) = __$$PersistedChatMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class __$$PersistedChatMessageDtoImplCopyWithImpl<$Res>
    extends
        _$PersistedChatMessageDtoCopyWithImpl<
          $Res,
          _$PersistedChatMessageDtoImpl
        >
    implements _$$PersistedChatMessageDtoImplCopyWith<$Res> {
  __$$PersistedChatMessageDtoImplCopyWithImpl(
    _$PersistedChatMessageDtoImpl _value,
    $Res Function(_$PersistedChatMessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PersistedChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? content = null}) {
    return _then(
      _$PersistedChatMessageDtoImpl(
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PersistedChatMessageDtoImpl implements _PersistedChatMessageDto {
  const _$PersistedChatMessageDtoImpl({required this.role, this.content = ''});

  factory _$PersistedChatMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersistedChatMessageDtoImplFromJson(json);

  @override
  final String role;
  @override
  @JsonKey()
  final String content;

  @override
  String toString() {
    return 'PersistedChatMessageDto(role: $role, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersistedChatMessageDtoImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, content);

  /// Create a copy of PersistedChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersistedChatMessageDtoImplCopyWith<_$PersistedChatMessageDtoImpl>
  get copyWith =>
      __$$PersistedChatMessageDtoImplCopyWithImpl<
        _$PersistedChatMessageDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersistedChatMessageDtoImplToJson(this);
  }
}

abstract class _PersistedChatMessageDto implements PersistedChatMessageDto {
  const factory _PersistedChatMessageDto({
    required final String role,
    final String content,
  }) = _$PersistedChatMessageDtoImpl;

  factory _PersistedChatMessageDto.fromJson(Map<String, dynamic> json) =
      _$PersistedChatMessageDtoImpl.fromJson;

  @override
  String get role;
  @override
  String get content;

  /// Create a copy of PersistedChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersistedChatMessageDtoImplCopyWith<_$PersistedChatMessageDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChatConfirmationDto _$ChatConfirmationDtoFromJson(Map<String, dynamic> json) {
  return _ChatConfirmationDto.fromJson(json);
}

/// @nodoc
mixin _$ChatConfirmationDto {
  String get tool => throw _privateConstructorUsedError;
  Map<String, dynamic> get args => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;

  /// Serializes this ChatConfirmationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatConfirmationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatConfirmationDtoCopyWith<ChatConfirmationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatConfirmationDtoCopyWith<$Res> {
  factory $ChatConfirmationDtoCopyWith(
    ChatConfirmationDto value,
    $Res Function(ChatConfirmationDto) then,
  ) = _$ChatConfirmationDtoCopyWithImpl<$Res, ChatConfirmationDto>;
  @useResult
  $Res call({String tool, Map<String, dynamic> args, String summary});
}

/// @nodoc
class _$ChatConfirmationDtoCopyWithImpl<$Res, $Val extends ChatConfirmationDto>
    implements $ChatConfirmationDtoCopyWith<$Res> {
  _$ChatConfirmationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatConfirmationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? args = null,
    Object? summary = null,
  }) {
    return _then(
      _value.copyWith(
            tool: null == tool
                ? _value.tool
                : tool // ignore: cast_nullable_to_non_nullable
                      as String,
            args: null == args
                ? _value.args
                : args // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatConfirmationDtoImplCopyWith<$Res>
    implements $ChatConfirmationDtoCopyWith<$Res> {
  factory _$$ChatConfirmationDtoImplCopyWith(
    _$ChatConfirmationDtoImpl value,
    $Res Function(_$ChatConfirmationDtoImpl) then,
  ) = __$$ChatConfirmationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tool, Map<String, dynamic> args, String summary});
}

/// @nodoc
class __$$ChatConfirmationDtoImplCopyWithImpl<$Res>
    extends _$ChatConfirmationDtoCopyWithImpl<$Res, _$ChatConfirmationDtoImpl>
    implements _$$ChatConfirmationDtoImplCopyWith<$Res> {
  __$$ChatConfirmationDtoImplCopyWithImpl(
    _$ChatConfirmationDtoImpl _value,
    $Res Function(_$ChatConfirmationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatConfirmationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? args = null,
    Object? summary = null,
  }) {
    return _then(
      _$ChatConfirmationDtoImpl(
        tool: null == tool
            ? _value.tool
            : tool // ignore: cast_nullable_to_non_nullable
                  as String,
        args: null == args
            ? _value._args
            : args // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatConfirmationDtoImpl implements _ChatConfirmationDto {
  const _$ChatConfirmationDtoImpl({
    required this.tool,
    final Map<String, dynamic> args = const <String, dynamic>{},
    required this.summary,
  }) : _args = args;

  factory _$ChatConfirmationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatConfirmationDtoImplFromJson(json);

  @override
  final String tool;
  final Map<String, dynamic> _args;
  @override
  @JsonKey()
  Map<String, dynamic> get args {
    if (_args is EqualUnmodifiableMapView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_args);
  }

  @override
  final String summary;

  @override
  String toString() {
    return 'ChatConfirmationDto(tool: $tool, args: $args, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatConfirmationDtoImpl &&
            (identical(other.tool, tool) || other.tool == tool) &&
            const DeepCollectionEquality().equals(other._args, _args) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tool,
    const DeepCollectionEquality().hash(_args),
    summary,
  );

  /// Create a copy of ChatConfirmationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatConfirmationDtoImplCopyWith<_$ChatConfirmationDtoImpl> get copyWith =>
      __$$ChatConfirmationDtoImplCopyWithImpl<_$ChatConfirmationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatConfirmationDtoImplToJson(this);
  }
}

abstract class _ChatConfirmationDto implements ChatConfirmationDto {
  const factory _ChatConfirmationDto({
    required final String tool,
    final Map<String, dynamic> args,
    required final String summary,
  }) = _$ChatConfirmationDtoImpl;

  factory _ChatConfirmationDto.fromJson(Map<String, dynamic> json) =
      _$ChatConfirmationDtoImpl.fromJson;

  @override
  String get tool;
  @override
  Map<String, dynamic> get args;
  @override
  String get summary;

  /// Create a copy of ChatConfirmationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatConfirmationDtoImplCopyWith<_$ChatConfirmationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatThreadDetailDto _$ChatThreadDetailDtoFromJson(Map<String, dynamic> json) {
  return _ChatThreadDetailDto.fromJson(json);
}

/// @nodoc
mixin _$ChatThreadDetailDto {
  String get threadId => throw _privateConstructorUsedError;
  List<PersistedChatMessageDto> get messages =>
      throw _privateConstructorUsedError;
  ChatConfirmationDto? get pendingAction => throw _privateConstructorUsedError;

  /// Serializes this ChatThreadDetailDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThreadDetailDtoCopyWith<ChatThreadDetailDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThreadDetailDtoCopyWith<$Res> {
  factory $ChatThreadDetailDtoCopyWith(
    ChatThreadDetailDto value,
    $Res Function(ChatThreadDetailDto) then,
  ) = _$ChatThreadDetailDtoCopyWithImpl<$Res, ChatThreadDetailDto>;
  @useResult
  $Res call({
    String threadId,
    List<PersistedChatMessageDto> messages,
    ChatConfirmationDto? pendingAction,
  });

  $ChatConfirmationDtoCopyWith<$Res>? get pendingAction;
}

/// @nodoc
class _$ChatThreadDetailDtoCopyWithImpl<$Res, $Val extends ChatThreadDetailDto>
    implements $ChatThreadDetailDtoCopyWith<$Res> {
  _$ChatThreadDetailDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? messages = null,
    Object? pendingAction = freezed,
  }) {
    return _then(
      _value.copyWith(
            threadId: null == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<PersistedChatMessageDto>,
            pendingAction: freezed == pendingAction
                ? _value.pendingAction
                : pendingAction // ignore: cast_nullable_to_non_nullable
                      as ChatConfirmationDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatConfirmationDtoCopyWith<$Res>? get pendingAction {
    if (_value.pendingAction == null) {
      return null;
    }

    return $ChatConfirmationDtoCopyWith<$Res>(_value.pendingAction!, (value) {
      return _then(_value.copyWith(pendingAction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatThreadDetailDtoImplCopyWith<$Res>
    implements $ChatThreadDetailDtoCopyWith<$Res> {
  factory _$$ChatThreadDetailDtoImplCopyWith(
    _$ChatThreadDetailDtoImpl value,
    $Res Function(_$ChatThreadDetailDtoImpl) then,
  ) = __$$ChatThreadDetailDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String threadId,
    List<PersistedChatMessageDto> messages,
    ChatConfirmationDto? pendingAction,
  });

  @override
  $ChatConfirmationDtoCopyWith<$Res>? get pendingAction;
}

/// @nodoc
class __$$ChatThreadDetailDtoImplCopyWithImpl<$Res>
    extends _$ChatThreadDetailDtoCopyWithImpl<$Res, _$ChatThreadDetailDtoImpl>
    implements _$$ChatThreadDetailDtoImplCopyWith<$Res> {
  __$$ChatThreadDetailDtoImplCopyWithImpl(
    _$ChatThreadDetailDtoImpl _value,
    $Res Function(_$ChatThreadDetailDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadId = null,
    Object? messages = null,
    Object? pendingAction = freezed,
  }) {
    return _then(
      _$ChatThreadDetailDtoImpl(
        threadId: null == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<PersistedChatMessageDto>,
        pendingAction: freezed == pendingAction
            ? _value.pendingAction
            : pendingAction // ignore: cast_nullable_to_non_nullable
                  as ChatConfirmationDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatThreadDetailDtoImpl implements _ChatThreadDetailDto {
  const _$ChatThreadDetailDtoImpl({
    required this.threadId,
    final List<PersistedChatMessageDto> messages =
        const <PersistedChatMessageDto>[],
    this.pendingAction,
  }) : _messages = messages;

  factory _$ChatThreadDetailDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatThreadDetailDtoImplFromJson(json);

  @override
  final String threadId;
  final List<PersistedChatMessageDto> _messages;
  @override
  @JsonKey()
  List<PersistedChatMessageDto> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final ChatConfirmationDto? pendingAction;

  @override
  String toString() {
    return 'ChatThreadDetailDto(threadId: $threadId, messages: $messages, pendingAction: $pendingAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThreadDetailDtoImpl &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.pendingAction, pendingAction) ||
                other.pendingAction == pendingAction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    threadId,
    const DeepCollectionEquality().hash(_messages),
    pendingAction,
  );

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThreadDetailDtoImplCopyWith<_$ChatThreadDetailDtoImpl> get copyWith =>
      __$$ChatThreadDetailDtoImplCopyWithImpl<_$ChatThreadDetailDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatThreadDetailDtoImplToJson(this);
  }
}

abstract class _ChatThreadDetailDto implements ChatThreadDetailDto {
  const factory _ChatThreadDetailDto({
    required final String threadId,
    final List<PersistedChatMessageDto> messages,
    final ChatConfirmationDto? pendingAction,
  }) = _$ChatThreadDetailDtoImpl;

  factory _ChatThreadDetailDto.fromJson(Map<String, dynamic> json) =
      _$ChatThreadDetailDtoImpl.fromJson;

  @override
  String get threadId;
  @override
  List<PersistedChatMessageDto> get messages;
  @override
  ChatConfirmationDto? get pendingAction;

  /// Create a copy of ChatThreadDetailDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThreadDetailDtoImplCopyWith<_$ChatThreadDetailDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
