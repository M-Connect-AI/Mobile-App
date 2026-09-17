// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_rich_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatUiAction {

 ChatUiActionKey get key; String get label; String? get url; String? get path;
/// Create a copy of ChatUiAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatUiActionCopyWith<ChatUiAction> get copyWith => _$ChatUiActionCopyWithImpl<ChatUiAction>(this as ChatUiAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatUiAction&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,url,path);

@override
String toString() {
  return 'ChatUiAction(key: $key, label: $label, url: $url, path: $path)';
}


}

/// @nodoc
abstract mixin class $ChatUiActionCopyWith<$Res>  {
  factory $ChatUiActionCopyWith(ChatUiAction value, $Res Function(ChatUiAction) _then) = _$ChatUiActionCopyWithImpl;
@useResult
$Res call({
 ChatUiActionKey key, String label, String? url, String? path
});




}
/// @nodoc
class _$ChatUiActionCopyWithImpl<$Res>
    implements $ChatUiActionCopyWith<$Res> {
  _$ChatUiActionCopyWithImpl(this._self, this._then);

  final ChatUiAction _self;
  final $Res Function(ChatUiAction) _then;

/// Create a copy of ChatUiAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? url = freezed,Object? path = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as ChatUiActionKey,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatUiAction].
extension ChatUiActionPatterns on ChatUiAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatUiAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatUiAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatUiAction value)  $default,){
final _that = this;
switch (_that) {
case _ChatUiAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatUiAction value)?  $default,){
final _that = this;
switch (_that) {
case _ChatUiAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatUiActionKey key,  String label,  String? url,  String? path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatUiAction() when $default != null:
return $default(_that.key,_that.label,_that.url,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatUiActionKey key,  String label,  String? url,  String? path)  $default,) {final _that = this;
switch (_that) {
case _ChatUiAction():
return $default(_that.key,_that.label,_that.url,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatUiActionKey key,  String label,  String? url,  String? path)?  $default,) {final _that = this;
switch (_that) {
case _ChatUiAction() when $default != null:
return $default(_that.key,_that.label,_that.url,_that.path);case _:
  return null;

}
}

}

/// @nodoc


class _ChatUiAction implements ChatUiAction {
  const _ChatUiAction({required this.key, required this.label, this.url, this.path});
  

@override final  ChatUiActionKey key;
@override final  String label;
@override final  String? url;
@override final  String? path;

/// Create a copy of ChatUiAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatUiActionCopyWith<_ChatUiAction> get copyWith => __$ChatUiActionCopyWithImpl<_ChatUiAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatUiAction&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,url,path);

@override
String toString() {
  return 'ChatUiAction(key: $key, label: $label, url: $url, path: $path)';
}


}

/// @nodoc
abstract mixin class _$ChatUiActionCopyWith<$Res> implements $ChatUiActionCopyWith<$Res> {
  factory _$ChatUiActionCopyWith(_ChatUiAction value, $Res Function(_ChatUiAction) _then) = __$ChatUiActionCopyWithImpl;
@override @useResult
$Res call({
 ChatUiActionKey key, String label, String? url, String? path
});




}
/// @nodoc
class __$ChatUiActionCopyWithImpl<$Res>
    implements _$ChatUiActionCopyWith<$Res> {
  __$ChatUiActionCopyWithImpl(this._self, this._then);

  final _ChatUiAction _self;
  final $Res Function(_ChatUiAction) _then;

/// Create a copy of ChatUiAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? url = freezed,Object? path = freezed,}) {
  return _then(_ChatUiAction(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as ChatUiActionKey,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ChatSuggestion {

 String get label; String get text;
/// Create a copy of ChatSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSuggestionCopyWith<ChatSuggestion> get copyWith => _$ChatSuggestionCopyWithImpl<ChatSuggestion>(this as ChatSuggestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSuggestion&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,label,text);

@override
String toString() {
  return 'ChatSuggestion(label: $label, text: $text)';
}


}

/// @nodoc
abstract mixin class $ChatSuggestionCopyWith<$Res>  {
  factory $ChatSuggestionCopyWith(ChatSuggestion value, $Res Function(ChatSuggestion) _then) = _$ChatSuggestionCopyWithImpl;
@useResult
$Res call({
 String label, String text
});




}
/// @nodoc
class _$ChatSuggestionCopyWithImpl<$Res>
    implements $ChatSuggestionCopyWith<$Res> {
  _$ChatSuggestionCopyWithImpl(this._self, this._then);

  final ChatSuggestion _self;
  final $Res Function(ChatSuggestion) _then;

/// Create a copy of ChatSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? text = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSuggestion].
extension ChatSuggestionPatterns on ChatSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _ChatSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSuggestion() when $default != null:
return $default(_that.label,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String text)  $default,) {final _that = this;
switch (_that) {
case _ChatSuggestion():
return $default(_that.label,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String text)?  $default,) {final _that = this;
switch (_that) {
case _ChatSuggestion() when $default != null:
return $default(_that.label,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _ChatSuggestion implements ChatSuggestion {
  const _ChatSuggestion({required this.label, required this.text});
  

@override final  String label;
@override final  String text;

/// Create a copy of ChatSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSuggestionCopyWith<_ChatSuggestion> get copyWith => __$ChatSuggestionCopyWithImpl<_ChatSuggestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSuggestion&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,label,text);

@override
String toString() {
  return 'ChatSuggestion(label: $label, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ChatSuggestionCopyWith<$Res> implements $ChatSuggestionCopyWith<$Res> {
  factory _$ChatSuggestionCopyWith(_ChatSuggestion value, $Res Function(_ChatSuggestion) _then) = __$ChatSuggestionCopyWithImpl;
@override @useResult
$Res call({
 String label, String text
});




}
/// @nodoc
class __$ChatSuggestionCopyWithImpl<$Res>
    implements _$ChatSuggestionCopyWith<$Res> {
  __$ChatSuggestionCopyWithImpl(this._self, this._then);

  final _ChatSuggestion _self;
  final $Res Function(_ChatSuggestion) _then;

/// Create a copy of ChatSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? text = null,}) {
  return _then(_ChatSuggestion(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChatHighlight {

 int get start; int get end; ChatHighlightKind get kind; ChatTone? get tone;
/// Create a copy of ChatHighlight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatHighlightCopyWith<ChatHighlight> get copyWith => _$ChatHighlightCopyWithImpl<ChatHighlight>(this as ChatHighlight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatHighlight&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.tone, tone) || other.tone == tone));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,kind,tone);

@override
String toString() {
  return 'ChatHighlight(start: $start, end: $end, kind: $kind, tone: $tone)';
}


}

/// @nodoc
abstract mixin class $ChatHighlightCopyWith<$Res>  {
  factory $ChatHighlightCopyWith(ChatHighlight value, $Res Function(ChatHighlight) _then) = _$ChatHighlightCopyWithImpl;
@useResult
$Res call({
 int start, int end, ChatHighlightKind kind, ChatTone? tone
});




}
/// @nodoc
class _$ChatHighlightCopyWithImpl<$Res>
    implements $ChatHighlightCopyWith<$Res> {
  _$ChatHighlightCopyWithImpl(this._self, this._then);

  final ChatHighlight _self;
  final $Res Function(ChatHighlight) _then;

/// Create a copy of ChatHighlight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? kind = null,Object? tone = freezed,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChatHighlightKind,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ChatTone?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatHighlight].
extension ChatHighlightPatterns on ChatHighlight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatHighlight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatHighlight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatHighlight value)  $default,){
final _that = this;
switch (_that) {
case _ChatHighlight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatHighlight value)?  $default,){
final _that = this;
switch (_that) {
case _ChatHighlight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int start,  int end,  ChatHighlightKind kind,  ChatTone? tone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatHighlight() when $default != null:
return $default(_that.start,_that.end,_that.kind,_that.tone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int start,  int end,  ChatHighlightKind kind,  ChatTone? tone)  $default,) {final _that = this;
switch (_that) {
case _ChatHighlight():
return $default(_that.start,_that.end,_that.kind,_that.tone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int start,  int end,  ChatHighlightKind kind,  ChatTone? tone)?  $default,) {final _that = this;
switch (_that) {
case _ChatHighlight() when $default != null:
return $default(_that.start,_that.end,_that.kind,_that.tone);case _:
  return null;

}
}

}

/// @nodoc


class _ChatHighlight implements ChatHighlight {
  const _ChatHighlight({required this.start, required this.end, required this.kind, this.tone});
  

@override final  int start;
@override final  int end;
@override final  ChatHighlightKind kind;
@override final  ChatTone? tone;

/// Create a copy of ChatHighlight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatHighlightCopyWith<_ChatHighlight> get copyWith => __$ChatHighlightCopyWithImpl<_ChatHighlight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatHighlight&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.tone, tone) || other.tone == tone));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,kind,tone);

@override
String toString() {
  return 'ChatHighlight(start: $start, end: $end, kind: $kind, tone: $tone)';
}


}

/// @nodoc
abstract mixin class _$ChatHighlightCopyWith<$Res> implements $ChatHighlightCopyWith<$Res> {
  factory _$ChatHighlightCopyWith(_ChatHighlight value, $Res Function(_ChatHighlight) _then) = __$ChatHighlightCopyWithImpl;
@override @useResult
$Res call({
 int start, int end, ChatHighlightKind kind, ChatTone? tone
});




}
/// @nodoc
class __$ChatHighlightCopyWithImpl<$Res>
    implements _$ChatHighlightCopyWith<$Res> {
  __$ChatHighlightCopyWithImpl(this._self, this._then);

  final _ChatHighlight _self;
  final $Res Function(_ChatHighlight) _then;

/// Create a copy of ChatHighlight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? kind = null,Object? tone = freezed,}) {
  return _then(_ChatHighlight(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChatHighlightKind,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ChatTone?,
  ));
}


}

/// @nodoc
mixin _$ChatBlockItem {

 String? get label; Object? get value; String? get title; String? get subtitle; String? get kicker; String? get badge; ChatTone? get tone; String? get color; String? get url;
/// Create a copy of ChatBlockItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatBlockItemCopyWith<ChatBlockItem> get copyWith => _$ChatBlockItemCopyWithImpl<ChatBlockItem>(this as ChatBlockItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatBlockItem&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.kicker, kicker) || other.kicker == kicker)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.color, color) || other.color == color)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(value),title,subtitle,kicker,badge,tone,color,url);

@override
String toString() {
  return 'ChatBlockItem(label: $label, value: $value, title: $title, subtitle: $subtitle, kicker: $kicker, badge: $badge, tone: $tone, color: $color, url: $url)';
}


}

/// @nodoc
abstract mixin class $ChatBlockItemCopyWith<$Res>  {
  factory $ChatBlockItemCopyWith(ChatBlockItem value, $Res Function(ChatBlockItem) _then) = _$ChatBlockItemCopyWithImpl;
@useResult
$Res call({
 String? label, Object? value, String? title, String? subtitle, String? kicker, String? badge, ChatTone? tone, String? color, String? url
});




}
/// @nodoc
class _$ChatBlockItemCopyWithImpl<$Res>
    implements $ChatBlockItemCopyWith<$Res> {
  _$ChatBlockItemCopyWithImpl(this._self, this._then);

  final ChatBlockItem _self;
  final $Res Function(ChatBlockItem) _then;

/// Create a copy of ChatBlockItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = freezed,Object? value = freezed,Object? title = freezed,Object? subtitle = freezed,Object? kicker = freezed,Object? badge = freezed,Object? tone = freezed,Object? color = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value ,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,kicker: freezed == kicker ? _self.kicker : kicker // ignore: cast_nullable_to_non_nullable
as String?,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ChatTone?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatBlockItem].
extension ChatBlockItemPatterns on ChatBlockItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatBlockItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatBlockItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatBlockItem value)  $default,){
final _that = this;
switch (_that) {
case _ChatBlockItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatBlockItem value)?  $default,){
final _that = this;
switch (_that) {
case _ChatBlockItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? label,  Object? value,  String? title,  String? subtitle,  String? kicker,  String? badge,  ChatTone? tone,  String? color,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatBlockItem() when $default != null:
return $default(_that.label,_that.value,_that.title,_that.subtitle,_that.kicker,_that.badge,_that.tone,_that.color,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? label,  Object? value,  String? title,  String? subtitle,  String? kicker,  String? badge,  ChatTone? tone,  String? color,  String? url)  $default,) {final _that = this;
switch (_that) {
case _ChatBlockItem():
return $default(_that.label,_that.value,_that.title,_that.subtitle,_that.kicker,_that.badge,_that.tone,_that.color,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? label,  Object? value,  String? title,  String? subtitle,  String? kicker,  String? badge,  ChatTone? tone,  String? color,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ChatBlockItem() when $default != null:
return $default(_that.label,_that.value,_that.title,_that.subtitle,_that.kicker,_that.badge,_that.tone,_that.color,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _ChatBlockItem implements ChatBlockItem {
  const _ChatBlockItem({this.label, this.value, this.title, this.subtitle, this.kicker, this.badge, this.tone, this.color, this.url});
  

@override final  String? label;
@override final  Object? value;
@override final  String? title;
@override final  String? subtitle;
@override final  String? kicker;
@override final  String? badge;
@override final  ChatTone? tone;
@override final  String? color;
@override final  String? url;

/// Create a copy of ChatBlockItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatBlockItemCopyWith<_ChatBlockItem> get copyWith => __$ChatBlockItemCopyWithImpl<_ChatBlockItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatBlockItem&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.kicker, kicker) || other.kicker == kicker)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.color, color) || other.color == color)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(value),title,subtitle,kicker,badge,tone,color,url);

@override
String toString() {
  return 'ChatBlockItem(label: $label, value: $value, title: $title, subtitle: $subtitle, kicker: $kicker, badge: $badge, tone: $tone, color: $color, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ChatBlockItemCopyWith<$Res> implements $ChatBlockItemCopyWith<$Res> {
  factory _$ChatBlockItemCopyWith(_ChatBlockItem value, $Res Function(_ChatBlockItem) _then) = __$ChatBlockItemCopyWithImpl;
@override @useResult
$Res call({
 String? label, Object? value, String? title, String? subtitle, String? kicker, String? badge, ChatTone? tone, String? color, String? url
});




}
/// @nodoc
class __$ChatBlockItemCopyWithImpl<$Res>
    implements _$ChatBlockItemCopyWith<$Res> {
  __$ChatBlockItemCopyWithImpl(this._self, this._then);

  final _ChatBlockItem _self;
  final $Res Function(_ChatBlockItem) _then;

/// Create a copy of ChatBlockItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = freezed,Object? value = freezed,Object? title = freezed,Object? subtitle = freezed,Object? kicker = freezed,Object? badge = freezed,Object? tone = freezed,Object? color = freezed,Object? url = freezed,}) {
  return _then(_ChatBlockItem(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value ,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,kicker: freezed == kicker ? _self.kicker : kicker // ignore: cast_nullable_to_non_nullable
as String?,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as ChatTone?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ChatRichBlock {

 ChatBlockType get type; String? get title; String? get text; String? get source; num? get value; num? get max; String? get suffix; List<ChatBlockItem> get items;
/// Create a copy of ChatRichBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRichBlockCopyWith<ChatRichBlock> get copyWith => _$ChatRichBlockCopyWithImpl<ChatRichBlock>(this as ChatRichBlock, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRichBlock&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.source, source) || other.source == source)&&(identical(other.value, value) || other.value == value)&&(identical(other.max, max) || other.max == max)&&(identical(other.suffix, suffix) || other.suffix == suffix)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,text,source,value,max,suffix,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ChatRichBlock(type: $type, title: $title, text: $text, source: $source, value: $value, max: $max, suffix: $suffix, items: $items)';
}


}

/// @nodoc
abstract mixin class $ChatRichBlockCopyWith<$Res>  {
  factory $ChatRichBlockCopyWith(ChatRichBlock value, $Res Function(ChatRichBlock) _then) = _$ChatRichBlockCopyWithImpl;
@useResult
$Res call({
 ChatBlockType type, String? title, String? text, String? source, num? value, num? max, String? suffix, List<ChatBlockItem> items
});




}
/// @nodoc
class _$ChatRichBlockCopyWithImpl<$Res>
    implements $ChatRichBlockCopyWith<$Res> {
  _$ChatRichBlockCopyWithImpl(this._self, this._then);

  final ChatRichBlock _self;
  final $Res Function(ChatRichBlock) _then;

/// Create a copy of ChatRichBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = freezed,Object? text = freezed,Object? source = freezed,Object? value = freezed,Object? max = freezed,Object? suffix = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatBlockType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num?,suffix: freezed == suffix ? _self.suffix : suffix // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ChatBlockItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRichBlock].
extension ChatRichBlockPatterns on ChatRichBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRichBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRichBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRichBlock value)  $default,){
final _that = this;
switch (_that) {
case _ChatRichBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRichBlock value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRichBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatBlockType type,  String? title,  String? text,  String? source,  num? value,  num? max,  String? suffix,  List<ChatBlockItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRichBlock() when $default != null:
return $default(_that.type,_that.title,_that.text,_that.source,_that.value,_that.max,_that.suffix,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatBlockType type,  String? title,  String? text,  String? source,  num? value,  num? max,  String? suffix,  List<ChatBlockItem> items)  $default,) {final _that = this;
switch (_that) {
case _ChatRichBlock():
return $default(_that.type,_that.title,_that.text,_that.source,_that.value,_that.max,_that.suffix,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatBlockType type,  String? title,  String? text,  String? source,  num? value,  num? max,  String? suffix,  List<ChatBlockItem> items)?  $default,) {final _that = this;
switch (_that) {
case _ChatRichBlock() when $default != null:
return $default(_that.type,_that.title,_that.text,_that.source,_that.value,_that.max,_that.suffix,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ChatRichBlock implements ChatRichBlock {
  const _ChatRichBlock({required this.type, this.title, this.text, this.source, this.value, this.max, this.suffix, final  List<ChatBlockItem> items = const <ChatBlockItem>[]}): _items = items;
  

@override final  ChatBlockType type;
@override final  String? title;
@override final  String? text;
@override final  String? source;
@override final  num? value;
@override final  num? max;
@override final  String? suffix;
 final  List<ChatBlockItem> _items;
@override@JsonKey() List<ChatBlockItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ChatRichBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRichBlockCopyWith<_ChatRichBlock> get copyWith => __$ChatRichBlockCopyWithImpl<_ChatRichBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRichBlock&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.source, source) || other.source == source)&&(identical(other.value, value) || other.value == value)&&(identical(other.max, max) || other.max == max)&&(identical(other.suffix, suffix) || other.suffix == suffix)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,text,source,value,max,suffix,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ChatRichBlock(type: $type, title: $title, text: $text, source: $source, value: $value, max: $max, suffix: $suffix, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ChatRichBlockCopyWith<$Res> implements $ChatRichBlockCopyWith<$Res> {
  factory _$ChatRichBlockCopyWith(_ChatRichBlock value, $Res Function(_ChatRichBlock) _then) = __$ChatRichBlockCopyWithImpl;
@override @useResult
$Res call({
 ChatBlockType type, String? title, String? text, String? source, num? value, num? max, String? suffix, List<ChatBlockItem> items
});




}
/// @nodoc
class __$ChatRichBlockCopyWithImpl<$Res>
    implements _$ChatRichBlockCopyWith<$Res> {
  __$ChatRichBlockCopyWithImpl(this._self, this._then);

  final _ChatRichBlock _self;
  final $Res Function(_ChatRichBlock) _then;

/// Create a copy of ChatRichBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = freezed,Object? text = freezed,Object? source = freezed,Object? value = freezed,Object? max = freezed,Object? suffix = freezed,Object? items = null,}) {
  return _then(_ChatRichBlock(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatBlockType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num?,suffix: freezed == suffix ? _self.suffix : suffix // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ChatBlockItem>,
  ));
}


}

// dart format on
