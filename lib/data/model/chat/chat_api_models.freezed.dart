// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatTurnRequestDto {

 String get message; String? get threadId; bool? get confirm;
/// Create a copy of ChatTurnRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTurnRequestDtoCopyWith<ChatTurnRequestDto> get copyWith => _$ChatTurnRequestDtoCopyWithImpl<ChatTurnRequestDto>(this as ChatTurnRequestDto, _$identity);

  /// Serializes this ChatTurnRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnRequestDto&&(identical(other.message, message) || other.message == message)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.confirm, confirm) || other.confirm == confirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,threadId,confirm);

@override
String toString() {
  return 'ChatTurnRequestDto(message: $message, threadId: $threadId, confirm: $confirm)';
}


}

/// @nodoc
abstract mixin class $ChatTurnRequestDtoCopyWith<$Res>  {
  factory $ChatTurnRequestDtoCopyWith(ChatTurnRequestDto value, $Res Function(ChatTurnRequestDto) _then) = _$ChatTurnRequestDtoCopyWithImpl;
@useResult
$Res call({
 String message, String? threadId, bool? confirm
});




}
/// @nodoc
class _$ChatTurnRequestDtoCopyWithImpl<$Res>
    implements $ChatTurnRequestDtoCopyWith<$Res> {
  _$ChatTurnRequestDtoCopyWithImpl(this._self, this._then);

  final ChatTurnRequestDto _self;
  final $Res Function(ChatTurnRequestDto) _then;

/// Create a copy of ChatTurnRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? threadId = freezed,Object? confirm = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,confirm: freezed == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatTurnRequestDto].
extension ChatTurnRequestDtoPatterns on ChatTurnRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatTurnRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatTurnRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatTurnRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatTurnRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatTurnRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatTurnRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String? threadId,  bool? confirm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatTurnRequestDto() when $default != null:
return $default(_that.message,_that.threadId,_that.confirm);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String? threadId,  bool? confirm)  $default,) {final _that = this;
switch (_that) {
case _ChatTurnRequestDto():
return $default(_that.message,_that.threadId,_that.confirm);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String? threadId,  bool? confirm)?  $default,) {final _that = this;
switch (_that) {
case _ChatTurnRequestDto() when $default != null:
return $default(_that.message,_that.threadId,_that.confirm);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ChatTurnRequestDto implements ChatTurnRequestDto {
  const _ChatTurnRequestDto({required this.message, this.threadId, this.confirm});
  factory _ChatTurnRequestDto.fromJson(Map<String, dynamic> json) => _$ChatTurnRequestDtoFromJson(json);

@override final  String message;
@override final  String? threadId;
@override final  bool? confirm;

/// Create a copy of ChatTurnRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatTurnRequestDtoCopyWith<_ChatTurnRequestDto> get copyWith => __$ChatTurnRequestDtoCopyWithImpl<_ChatTurnRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatTurnRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatTurnRequestDto&&(identical(other.message, message) || other.message == message)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.confirm, confirm) || other.confirm == confirm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,threadId,confirm);

@override
String toString() {
  return 'ChatTurnRequestDto(message: $message, threadId: $threadId, confirm: $confirm)';
}


}

/// @nodoc
abstract mixin class _$ChatTurnRequestDtoCopyWith<$Res> implements $ChatTurnRequestDtoCopyWith<$Res> {
  factory _$ChatTurnRequestDtoCopyWith(_ChatTurnRequestDto value, $Res Function(_ChatTurnRequestDto) _then) = __$ChatTurnRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String message, String? threadId, bool? confirm
});




}
/// @nodoc
class __$ChatTurnRequestDtoCopyWithImpl<$Res>
    implements _$ChatTurnRequestDtoCopyWith<$Res> {
  __$ChatTurnRequestDtoCopyWithImpl(this._self, this._then);

  final _ChatTurnRequestDto _self;
  final $Res Function(_ChatTurnRequestDto) _then;

/// Create a copy of ChatTurnRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? threadId = freezed,Object? confirm = freezed,}) {
  return _then(_ChatTurnRequestDto(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,confirm: freezed == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ChatThreadSummaryDto {

 String get threadId; String get title; String get preview; String get updatedAt;
/// Create a copy of ChatThreadSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadSummaryDtoCopyWith<ChatThreadSummaryDto> get copyWith => _$ChatThreadSummaryDtoCopyWithImpl<ChatThreadSummaryDto>(this as ChatThreadSummaryDto, _$identity);

  /// Serializes this ChatThreadSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadSummaryDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,title,preview,updatedAt);

@override
String toString() {
  return 'ChatThreadSummaryDto(threadId: $threadId, title: $title, preview: $preview, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChatThreadSummaryDtoCopyWith<$Res>  {
  factory $ChatThreadSummaryDtoCopyWith(ChatThreadSummaryDto value, $Res Function(ChatThreadSummaryDto) _then) = _$ChatThreadSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String threadId, String title, String preview, String updatedAt
});




}
/// @nodoc
class _$ChatThreadSummaryDtoCopyWithImpl<$Res>
    implements $ChatThreadSummaryDtoCopyWith<$Res> {
  _$ChatThreadSummaryDtoCopyWithImpl(this._self, this._then);

  final ChatThreadSummaryDto _self;
  final $Res Function(ChatThreadSummaryDto) _then;

/// Create a copy of ChatThreadSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threadId = null,Object? title = null,Object? preview = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatThreadSummaryDto].
extension ChatThreadSummaryDtoPatterns on ChatThreadSummaryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThreadSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThreadSummaryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThreadSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatThreadSummaryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThreadSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThreadSummaryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String threadId,  String title,  String preview,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThreadSummaryDto() when $default != null:
return $default(_that.threadId,_that.title,_that.preview,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String threadId,  String title,  String preview,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatThreadSummaryDto():
return $default(_that.threadId,_that.title,_that.preview,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String threadId,  String title,  String preview,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatThreadSummaryDto() when $default != null:
return $default(_that.threadId,_that.title,_that.preview,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatThreadSummaryDto implements ChatThreadSummaryDto {
  const _ChatThreadSummaryDto({required this.threadId, required this.title, required this.preview, required this.updatedAt});
  factory _ChatThreadSummaryDto.fromJson(Map<String, dynamic> json) => _$ChatThreadSummaryDtoFromJson(json);

@override final  String threadId;
@override final  String title;
@override final  String preview;
@override final  String updatedAt;

/// Create a copy of ChatThreadSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadSummaryDtoCopyWith<_ChatThreadSummaryDto> get copyWith => __$ChatThreadSummaryDtoCopyWithImpl<_ChatThreadSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatThreadSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThreadSummaryDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.title, title) || other.title == title)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,title,preview,updatedAt);

@override
String toString() {
  return 'ChatThreadSummaryDto(threadId: $threadId, title: $title, preview: $preview, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadSummaryDtoCopyWith<$Res> implements $ChatThreadSummaryDtoCopyWith<$Res> {
  factory _$ChatThreadSummaryDtoCopyWith(_ChatThreadSummaryDto value, $Res Function(_ChatThreadSummaryDto) _then) = __$ChatThreadSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String threadId, String title, String preview, String updatedAt
});




}
/// @nodoc
class __$ChatThreadSummaryDtoCopyWithImpl<$Res>
    implements _$ChatThreadSummaryDtoCopyWith<$Res> {
  __$ChatThreadSummaryDtoCopyWithImpl(this._self, this._then);

  final _ChatThreadSummaryDto _self;
  final $Res Function(_ChatThreadSummaryDto) _then;

/// Create a copy of ChatThreadSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? title = null,Object? preview = null,Object? updatedAt = null,}) {
  return _then(_ChatThreadSummaryDto(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PersistedChatMessageDto {

 String get role; String get content; List<Map<String, dynamic>> get blocks; List<Map<String, dynamic>> get highlights; Map<String, dynamic>? get uiAction; List<Map<String, dynamic>> get suggestions;
/// Create a copy of PersistedChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersistedChatMessageDtoCopyWith<PersistedChatMessageDto> get copyWith => _$PersistedChatMessageDtoCopyWithImpl<PersistedChatMessageDto>(this as PersistedChatMessageDto, _$identity);

  /// Serializes this PersistedChatMessageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersistedChatMessageDto&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&const DeepCollectionEquality().equals(other.highlights, highlights)&&const DeepCollectionEquality().equals(other.uiAction, uiAction)&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content,const DeepCollectionEquality().hash(blocks),const DeepCollectionEquality().hash(highlights),const DeepCollectionEquality().hash(uiAction),const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'PersistedChatMessageDto(role: $role, content: $content, blocks: $blocks, highlights: $highlights, uiAction: $uiAction, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $PersistedChatMessageDtoCopyWith<$Res>  {
  factory $PersistedChatMessageDtoCopyWith(PersistedChatMessageDto value, $Res Function(PersistedChatMessageDto) _then) = _$PersistedChatMessageDtoCopyWithImpl;
@useResult
$Res call({
 String role, String content, List<Map<String, dynamic>> blocks, List<Map<String, dynamic>> highlights, Map<String, dynamic>? uiAction, List<Map<String, dynamic>> suggestions
});




}
/// @nodoc
class _$PersistedChatMessageDtoCopyWithImpl<$Res>
    implements $PersistedChatMessageDtoCopyWith<$Res> {
  _$PersistedChatMessageDtoCopyWithImpl(this._self, this._then);

  final PersistedChatMessageDto _self;
  final $Res Function(PersistedChatMessageDto) _then;

/// Create a copy of PersistedChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,Object? blocks = null,Object? highlights = null,Object? uiAction = freezed,Object? suggestions = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,uiAction: freezed == uiAction ? _self.uiAction : uiAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [PersistedChatMessageDto].
extension PersistedChatMessageDtoPatterns on PersistedChatMessageDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersistedChatMessageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersistedChatMessageDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersistedChatMessageDto value)  $default,){
final _that = this;
switch (_that) {
case _PersistedChatMessageDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersistedChatMessageDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersistedChatMessageDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String content,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersistedChatMessageDto() when $default != null:
return $default(_that.role,_that.content,_that.blocks,_that.highlights,_that.uiAction,_that.suggestions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String content,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> suggestions)  $default,) {final _that = this;
switch (_that) {
case _PersistedChatMessageDto():
return $default(_that.role,_that.content,_that.blocks,_that.highlights,_that.uiAction,_that.suggestions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String content,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _PersistedChatMessageDto() when $default != null:
return $default(_that.role,_that.content,_that.blocks,_that.highlights,_that.uiAction,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersistedChatMessageDto implements PersistedChatMessageDto {
  const _PersistedChatMessageDto({required this.role, this.content = '', final  List<Map<String, dynamic>> blocks = const <Map<String, dynamic>>[], final  List<Map<String, dynamic>> highlights = const <Map<String, dynamic>>[], final  Map<String, dynamic>? uiAction, final  List<Map<String, dynamic>> suggestions = const <Map<String, dynamic>>[]}): _blocks = blocks,_highlights = highlights,_uiAction = uiAction,_suggestions = suggestions;
  factory _PersistedChatMessageDto.fromJson(Map<String, dynamic> json) => _$PersistedChatMessageDtoFromJson(json);

@override final  String role;
@override@JsonKey() final  String content;
 final  List<Map<String, dynamic>> _blocks;
@override@JsonKey() List<Map<String, dynamic>> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

 final  List<Map<String, dynamic>> _highlights;
@override@JsonKey() List<Map<String, dynamic>> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}

 final  Map<String, dynamic>? _uiAction;
@override Map<String, dynamic>? get uiAction {
  final value = _uiAction;
  if (value == null) return null;
  if (_uiAction is EqualUnmodifiableMapView) return _uiAction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>> _suggestions;
@override@JsonKey() List<Map<String, dynamic>> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of PersistedChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersistedChatMessageDtoCopyWith<_PersistedChatMessageDto> get copyWith => __$PersistedChatMessageDtoCopyWithImpl<_PersistedChatMessageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersistedChatMessageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersistedChatMessageDto&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&const DeepCollectionEquality().equals(other._highlights, _highlights)&&const DeepCollectionEquality().equals(other._uiAction, _uiAction)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content,const DeepCollectionEquality().hash(_blocks),const DeepCollectionEquality().hash(_highlights),const DeepCollectionEquality().hash(_uiAction),const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'PersistedChatMessageDto(role: $role, content: $content, blocks: $blocks, highlights: $highlights, uiAction: $uiAction, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$PersistedChatMessageDtoCopyWith<$Res> implements $PersistedChatMessageDtoCopyWith<$Res> {
  factory _$PersistedChatMessageDtoCopyWith(_PersistedChatMessageDto value, $Res Function(_PersistedChatMessageDto) _then) = __$PersistedChatMessageDtoCopyWithImpl;
@override @useResult
$Res call({
 String role, String content, List<Map<String, dynamic>> blocks, List<Map<String, dynamic>> highlights, Map<String, dynamic>? uiAction, List<Map<String, dynamic>> suggestions
});




}
/// @nodoc
class __$PersistedChatMessageDtoCopyWithImpl<$Res>
    implements _$PersistedChatMessageDtoCopyWith<$Res> {
  __$PersistedChatMessageDtoCopyWithImpl(this._self, this._then);

  final _PersistedChatMessageDto _self;
  final $Res Function(_PersistedChatMessageDto) _then;

/// Create a copy of PersistedChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,Object? blocks = null,Object? highlights = null,Object? uiAction = freezed,Object? suggestions = null,}) {
  return _then(_PersistedChatMessageDto(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,uiAction: freezed == uiAction ? _self._uiAction : uiAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}


/// @nodoc
mixin _$ChatDoneDto {

 String get threadId; String get reply; ChatConfirmationDto? get confirm; Map<String, dynamic>? get uiAction; List<Map<String, dynamic>> get blocks; List<Map<String, dynamic>> get highlights; List<Map<String, dynamic>> get suggestions; bool get didMutate; List<String> get citations;
/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDoneDtoCopyWith<ChatDoneDto> get copyWith => _$ChatDoneDtoCopyWithImpl<ChatDoneDto>(this as ChatDoneDto, _$identity);

  /// Serializes this ChatDoneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDoneDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.confirm, confirm) || other.confirm == confirm)&&const DeepCollectionEquality().equals(other.uiAction, uiAction)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&const DeepCollectionEquality().equals(other.highlights, highlights)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.didMutate, didMutate) || other.didMutate == didMutate)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,reply,confirm,const DeepCollectionEquality().hash(uiAction),const DeepCollectionEquality().hash(blocks),const DeepCollectionEquality().hash(highlights),const DeepCollectionEquality().hash(suggestions),didMutate,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'ChatDoneDto(threadId: $threadId, reply: $reply, confirm: $confirm, uiAction: $uiAction, blocks: $blocks, highlights: $highlights, suggestions: $suggestions, didMutate: $didMutate, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $ChatDoneDtoCopyWith<$Res>  {
  factory $ChatDoneDtoCopyWith(ChatDoneDto value, $Res Function(ChatDoneDto) _then) = _$ChatDoneDtoCopyWithImpl;
@useResult
$Res call({
 String threadId, String reply, ChatConfirmationDto? confirm, Map<String, dynamic>? uiAction, List<Map<String, dynamic>> blocks, List<Map<String, dynamic>> highlights, List<Map<String, dynamic>> suggestions, bool didMutate, List<String> citations
});


$ChatConfirmationDtoCopyWith<$Res>? get confirm;

}
/// @nodoc
class _$ChatDoneDtoCopyWithImpl<$Res>
    implements $ChatDoneDtoCopyWith<$Res> {
  _$ChatDoneDtoCopyWithImpl(this._self, this._then);

  final ChatDoneDto _self;
  final $Res Function(ChatDoneDto) _then;

/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threadId = null,Object? reply = null,Object? confirm = freezed,Object? uiAction = freezed,Object? blocks = null,Object? highlights = null,Object? suggestions = null,Object? didMutate = null,Object? citations = null,}) {
  return _then(_self.copyWith(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,confirm: freezed == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as ChatConfirmationDto?,uiAction: freezed == uiAction ? _self.uiAction : uiAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,didMutate: null == didMutate ? _self.didMutate : didMutate // ignore: cast_nullable_to_non_nullable
as bool,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConfirmationDtoCopyWith<$Res>? get confirm {
    if (_self.confirm == null) {
    return null;
  }

  return $ChatConfirmationDtoCopyWith<$Res>(_self.confirm!, (value) {
    return _then(_self.copyWith(confirm: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatDoneDto].
extension ChatDoneDtoPatterns on ChatDoneDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatDoneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatDoneDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatDoneDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatDoneDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatDoneDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatDoneDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String threadId,  String reply,  ChatConfirmationDto? confirm,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  List<Map<String, dynamic>> suggestions,  bool didMutate,  List<String> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatDoneDto() when $default != null:
return $default(_that.threadId,_that.reply,_that.confirm,_that.uiAction,_that.blocks,_that.highlights,_that.suggestions,_that.didMutate,_that.citations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String threadId,  String reply,  ChatConfirmationDto? confirm,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  List<Map<String, dynamic>> suggestions,  bool didMutate,  List<String> citations)  $default,) {final _that = this;
switch (_that) {
case _ChatDoneDto():
return $default(_that.threadId,_that.reply,_that.confirm,_that.uiAction,_that.blocks,_that.highlights,_that.suggestions,_that.didMutate,_that.citations);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String threadId,  String reply,  ChatConfirmationDto? confirm,  Map<String, dynamic>? uiAction,  List<Map<String, dynamic>> blocks,  List<Map<String, dynamic>> highlights,  List<Map<String, dynamic>> suggestions,  bool didMutate,  List<String> citations)?  $default,) {final _that = this;
switch (_that) {
case _ChatDoneDto() when $default != null:
return $default(_that.threadId,_that.reply,_that.confirm,_that.uiAction,_that.blocks,_that.highlights,_that.suggestions,_that.didMutate,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatDoneDto implements ChatDoneDto {
  const _ChatDoneDto({required this.threadId, this.reply = '', this.confirm, final  Map<String, dynamic>? uiAction, final  List<Map<String, dynamic>> blocks = const <Map<String, dynamic>>[], final  List<Map<String, dynamic>> highlights = const <Map<String, dynamic>>[], final  List<Map<String, dynamic>> suggestions = const <Map<String, dynamic>>[], this.didMutate = false, final  List<String> citations = const <String>[]}): _uiAction = uiAction,_blocks = blocks,_highlights = highlights,_suggestions = suggestions,_citations = citations;
  factory _ChatDoneDto.fromJson(Map<String, dynamic> json) => _$ChatDoneDtoFromJson(json);

@override final  String threadId;
@override@JsonKey() final  String reply;
@override final  ChatConfirmationDto? confirm;
 final  Map<String, dynamic>? _uiAction;
@override Map<String, dynamic>? get uiAction {
  final value = _uiAction;
  if (value == null) return null;
  if (_uiAction is EqualUnmodifiableMapView) return _uiAction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>> _blocks;
@override@JsonKey() List<Map<String, dynamic>> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

 final  List<Map<String, dynamic>> _highlights;
@override@JsonKey() List<Map<String, dynamic>> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}

 final  List<Map<String, dynamic>> _suggestions;
@override@JsonKey() List<Map<String, dynamic>> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  bool didMutate;
 final  List<String> _citations;
@override@JsonKey() List<String> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatDoneDtoCopyWith<_ChatDoneDto> get copyWith => __$ChatDoneDtoCopyWithImpl<_ChatDoneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatDoneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatDoneDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.confirm, confirm) || other.confirm == confirm)&&const DeepCollectionEquality().equals(other._uiAction, _uiAction)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&const DeepCollectionEquality().equals(other._highlights, _highlights)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.didMutate, didMutate) || other.didMutate == didMutate)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,reply,confirm,const DeepCollectionEquality().hash(_uiAction),const DeepCollectionEquality().hash(_blocks),const DeepCollectionEquality().hash(_highlights),const DeepCollectionEquality().hash(_suggestions),didMutate,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'ChatDoneDto(threadId: $threadId, reply: $reply, confirm: $confirm, uiAction: $uiAction, blocks: $blocks, highlights: $highlights, suggestions: $suggestions, didMutate: $didMutate, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$ChatDoneDtoCopyWith<$Res> implements $ChatDoneDtoCopyWith<$Res> {
  factory _$ChatDoneDtoCopyWith(_ChatDoneDto value, $Res Function(_ChatDoneDto) _then) = __$ChatDoneDtoCopyWithImpl;
@override @useResult
$Res call({
 String threadId, String reply, ChatConfirmationDto? confirm, Map<String, dynamic>? uiAction, List<Map<String, dynamic>> blocks, List<Map<String, dynamic>> highlights, List<Map<String, dynamic>> suggestions, bool didMutate, List<String> citations
});


@override $ChatConfirmationDtoCopyWith<$Res>? get confirm;

}
/// @nodoc
class __$ChatDoneDtoCopyWithImpl<$Res>
    implements _$ChatDoneDtoCopyWith<$Res> {
  __$ChatDoneDtoCopyWithImpl(this._self, this._then);

  final _ChatDoneDto _self;
  final $Res Function(_ChatDoneDto) _then;

/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? reply = null,Object? confirm = freezed,Object? uiAction = freezed,Object? blocks = null,Object? highlights = null,Object? suggestions = null,Object? didMutate = null,Object? citations = null,}) {
  return _then(_ChatDoneDto(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,confirm: freezed == confirm ? _self.confirm : confirm // ignore: cast_nullable_to_non_nullable
as ChatConfirmationDto?,uiAction: freezed == uiAction ? _self._uiAction : uiAction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,didMutate: null == didMutate ? _self.didMutate : didMutate // ignore: cast_nullable_to_non_nullable
as bool,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ChatDoneDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConfirmationDtoCopyWith<$Res>? get confirm {
    if (_self.confirm == null) {
    return null;
  }

  return $ChatConfirmationDtoCopyWith<$Res>(_self.confirm!, (value) {
    return _then(_self.copyWith(confirm: value));
  });
}
}


/// @nodoc
mixin _$ChatConfirmationDto {

 String get tool; Map<String, dynamic> get args; String get summary;
/// Create a copy of ChatConfirmationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConfirmationDtoCopyWith<ChatConfirmationDto> get copyWith => _$ChatConfirmationDtoCopyWithImpl<ChatConfirmationDto>(this as ChatConfirmationDto, _$identity);

  /// Serializes this ChatConfirmationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConfirmationDto&&(identical(other.tool, tool) || other.tool == tool)&&const DeepCollectionEquality().equals(other.args, args)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tool,const DeepCollectionEquality().hash(args),summary);

@override
String toString() {
  return 'ChatConfirmationDto(tool: $tool, args: $args, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ChatConfirmationDtoCopyWith<$Res>  {
  factory $ChatConfirmationDtoCopyWith(ChatConfirmationDto value, $Res Function(ChatConfirmationDto) _then) = _$ChatConfirmationDtoCopyWithImpl;
@useResult
$Res call({
 String tool, Map<String, dynamic> args, String summary
});




}
/// @nodoc
class _$ChatConfirmationDtoCopyWithImpl<$Res>
    implements $ChatConfirmationDtoCopyWith<$Res> {
  _$ChatConfirmationDtoCopyWithImpl(this._self, this._then);

  final ChatConfirmationDto _self;
  final $Res Function(ChatConfirmationDto) _then;

/// Create a copy of ChatConfirmationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tool = null,Object? args = null,Object? summary = null,}) {
  return _then(_self.copyWith(
tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as String,args: null == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatConfirmationDto].
extension ChatConfirmationDtoPatterns on ChatConfirmationDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatConfirmationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatConfirmationDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatConfirmationDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatConfirmationDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatConfirmationDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatConfirmationDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tool,  Map<String, dynamic> args,  String summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConfirmationDto() when $default != null:
return $default(_that.tool,_that.args,_that.summary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tool,  Map<String, dynamic> args,  String summary)  $default,) {final _that = this;
switch (_that) {
case _ChatConfirmationDto():
return $default(_that.tool,_that.args,_that.summary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tool,  Map<String, dynamic> args,  String summary)?  $default,) {final _that = this;
switch (_that) {
case _ChatConfirmationDto() when $default != null:
return $default(_that.tool,_that.args,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatConfirmationDto implements ChatConfirmationDto {
  const _ChatConfirmationDto({required this.tool, final  Map<String, dynamic> args = const <String, dynamic>{}, required this.summary}): _args = args;
  factory _ChatConfirmationDto.fromJson(Map<String, dynamic> json) => _$ChatConfirmationDtoFromJson(json);

@override final  String tool;
 final  Map<String, dynamic> _args;
@override@JsonKey() Map<String, dynamic> get args {
  if (_args is EqualUnmodifiableMapView) return _args;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_args);
}

@override final  String summary;

/// Create a copy of ChatConfirmationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConfirmationDtoCopyWith<_ChatConfirmationDto> get copyWith => __$ChatConfirmationDtoCopyWithImpl<_ChatConfirmationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatConfirmationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConfirmationDto&&(identical(other.tool, tool) || other.tool == tool)&&const DeepCollectionEquality().equals(other._args, _args)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tool,const DeepCollectionEquality().hash(_args),summary);

@override
String toString() {
  return 'ChatConfirmationDto(tool: $tool, args: $args, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$ChatConfirmationDtoCopyWith<$Res> implements $ChatConfirmationDtoCopyWith<$Res> {
  factory _$ChatConfirmationDtoCopyWith(_ChatConfirmationDto value, $Res Function(_ChatConfirmationDto) _then) = __$ChatConfirmationDtoCopyWithImpl;
@override @useResult
$Res call({
 String tool, Map<String, dynamic> args, String summary
});




}
/// @nodoc
class __$ChatConfirmationDtoCopyWithImpl<$Res>
    implements _$ChatConfirmationDtoCopyWith<$Res> {
  __$ChatConfirmationDtoCopyWithImpl(this._self, this._then);

  final _ChatConfirmationDto _self;
  final $Res Function(_ChatConfirmationDto) _then;

/// Create a copy of ChatConfirmationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tool = null,Object? args = null,Object? summary = null,}) {
  return _then(_ChatConfirmationDto(
tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as String,args: null == args ? _self._args : args // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatThreadDetailDto {

 String get threadId; List<PersistedChatMessageDto> get messages; ChatConfirmationDto? get pendingAction;
/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadDetailDtoCopyWith<ChatThreadDetailDto> get copyWith => _$ChatThreadDetailDtoCopyWithImpl<ChatThreadDetailDto>(this as ChatThreadDetailDto, _$identity);

  /// Serializes this ChatThreadDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadDetailDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.pendingAction, pendingAction) || other.pendingAction == pendingAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,const DeepCollectionEquality().hash(messages),pendingAction);

@override
String toString() {
  return 'ChatThreadDetailDto(threadId: $threadId, messages: $messages, pendingAction: $pendingAction)';
}


}

/// @nodoc
abstract mixin class $ChatThreadDetailDtoCopyWith<$Res>  {
  factory $ChatThreadDetailDtoCopyWith(ChatThreadDetailDto value, $Res Function(ChatThreadDetailDto) _then) = _$ChatThreadDetailDtoCopyWithImpl;
@useResult
$Res call({
 String threadId, List<PersistedChatMessageDto> messages, ChatConfirmationDto? pendingAction
});


$ChatConfirmationDtoCopyWith<$Res>? get pendingAction;

}
/// @nodoc
class _$ChatThreadDetailDtoCopyWithImpl<$Res>
    implements $ChatThreadDetailDtoCopyWith<$Res> {
  _$ChatThreadDetailDtoCopyWithImpl(this._self, this._then);

  final ChatThreadDetailDto _self;
  final $Res Function(ChatThreadDetailDto) _then;

/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threadId = null,Object? messages = null,Object? pendingAction = freezed,}) {
  return _then(_self.copyWith(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<PersistedChatMessageDto>,pendingAction: freezed == pendingAction ? _self.pendingAction : pendingAction // ignore: cast_nullable_to_non_nullable
as ChatConfirmationDto?,
  ));
}
/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConfirmationDtoCopyWith<$Res>? get pendingAction {
    if (_self.pendingAction == null) {
    return null;
  }

  return $ChatConfirmationDtoCopyWith<$Res>(_self.pendingAction!, (value) {
    return _then(_self.copyWith(pendingAction: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatThreadDetailDto].
extension ChatThreadDetailDtoPatterns on ChatThreadDetailDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThreadDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThreadDetailDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThreadDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatThreadDetailDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThreadDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThreadDetailDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String threadId,  List<PersistedChatMessageDto> messages,  ChatConfirmationDto? pendingAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThreadDetailDto() when $default != null:
return $default(_that.threadId,_that.messages,_that.pendingAction);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String threadId,  List<PersistedChatMessageDto> messages,  ChatConfirmationDto? pendingAction)  $default,) {final _that = this;
switch (_that) {
case _ChatThreadDetailDto():
return $default(_that.threadId,_that.messages,_that.pendingAction);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String threadId,  List<PersistedChatMessageDto> messages,  ChatConfirmationDto? pendingAction)?  $default,) {final _that = this;
switch (_that) {
case _ChatThreadDetailDto() when $default != null:
return $default(_that.threadId,_that.messages,_that.pendingAction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatThreadDetailDto implements ChatThreadDetailDto {
  const _ChatThreadDetailDto({required this.threadId, final  List<PersistedChatMessageDto> messages = const <PersistedChatMessageDto>[], this.pendingAction}): _messages = messages;
  factory _ChatThreadDetailDto.fromJson(Map<String, dynamic> json) => _$ChatThreadDetailDtoFromJson(json);

@override final  String threadId;
 final  List<PersistedChatMessageDto> _messages;
@override@JsonKey() List<PersistedChatMessageDto> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  ChatConfirmationDto? pendingAction;

/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadDetailDtoCopyWith<_ChatThreadDetailDto> get copyWith => __$ChatThreadDetailDtoCopyWithImpl<_ChatThreadDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatThreadDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThreadDetailDto&&(identical(other.threadId, threadId) || other.threadId == threadId)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.pendingAction, pendingAction) || other.pendingAction == pendingAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,threadId,const DeepCollectionEquality().hash(_messages),pendingAction);

@override
String toString() {
  return 'ChatThreadDetailDto(threadId: $threadId, messages: $messages, pendingAction: $pendingAction)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadDetailDtoCopyWith<$Res> implements $ChatThreadDetailDtoCopyWith<$Res> {
  factory _$ChatThreadDetailDtoCopyWith(_ChatThreadDetailDto value, $Res Function(_ChatThreadDetailDto) _then) = __$ChatThreadDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 String threadId, List<PersistedChatMessageDto> messages, ChatConfirmationDto? pendingAction
});


@override $ChatConfirmationDtoCopyWith<$Res>? get pendingAction;

}
/// @nodoc
class __$ChatThreadDetailDtoCopyWithImpl<$Res>
    implements _$ChatThreadDetailDtoCopyWith<$Res> {
  __$ChatThreadDetailDtoCopyWithImpl(this._self, this._then);

  final _ChatThreadDetailDto _self;
  final $Res Function(_ChatThreadDetailDto) _then;

/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threadId = null,Object? messages = null,Object? pendingAction = freezed,}) {
  return _then(_ChatThreadDetailDto(
threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<PersistedChatMessageDto>,pendingAction: freezed == pendingAction ? _self.pendingAction : pendingAction // ignore: cast_nullable_to_non_nullable
as ChatConfirmationDto?,
  ));
}

/// Create a copy of ChatThreadDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatConfirmationDtoCopyWith<$Res>? get pendingAction {
    if (_self.pendingAction == null) {
    return null;
  }

  return $ChatConfirmationDtoCopyWith<$Res>(_self.pendingAction!, (value) {
    return _then(_self.copyWith(pendingAction: value));
  });
}
}

// dart format on
