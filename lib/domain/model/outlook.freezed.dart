// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outlook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OutlookConnectionStatus {

 bool get configured; bool get connected; String? get microsoftEmail;
/// Create a copy of OutlookConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookConnectionStatusCopyWith<OutlookConnectionStatus> get copyWith => _$OutlookConnectionStatusCopyWithImpl<OutlookConnectionStatus>(this as OutlookConnectionStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookConnectionStatus&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail));
}


@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail);

@override
String toString() {
  return 'OutlookConnectionStatus(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail)';
}


}

/// @nodoc
abstract mixin class $OutlookConnectionStatusCopyWith<$Res>  {
  factory $OutlookConnectionStatusCopyWith(OutlookConnectionStatus value, $Res Function(OutlookConnectionStatus) _then) = _$OutlookConnectionStatusCopyWithImpl;
@useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail
});




}
/// @nodoc
class _$OutlookConnectionStatusCopyWithImpl<$Res>
    implements $OutlookConnectionStatusCopyWith<$Res> {
  _$OutlookConnectionStatusCopyWithImpl(this._self, this._then);

  final OutlookConnectionStatus _self;
  final $Res Function(OutlookConnectionStatus) _then;

/// Create a copy of OutlookConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,}) {
  return _then(_self.copyWith(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookConnectionStatus].
extension OutlookConnectionStatusPatterns on OutlookConnectionStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookConnectionStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookConnectionStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookConnectionStatus value)  $default,){
final _that = this;
switch (_that) {
case _OutlookConnectionStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookConnectionStatus value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookConnectionStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookConnectionStatus() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail)  $default,) {final _that = this;
switch (_that) {
case _OutlookConnectionStatus():
return $default(_that.configured,_that.connected,_that.microsoftEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool configured,  bool connected,  String? microsoftEmail)?  $default,) {final _that = this;
switch (_that) {
case _OutlookConnectionStatus() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookConnectionStatus implements OutlookConnectionStatus {
  const _OutlookConnectionStatus({required this.configured, required this.connected, this.microsoftEmail});
  

@override final  bool configured;
@override final  bool connected;
@override final  String? microsoftEmail;

/// Create a copy of OutlookConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookConnectionStatusCopyWith<_OutlookConnectionStatus> get copyWith => __$OutlookConnectionStatusCopyWithImpl<_OutlookConnectionStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookConnectionStatus&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail));
}


@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail);

@override
String toString() {
  return 'OutlookConnectionStatus(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail)';
}


}

/// @nodoc
abstract mixin class _$OutlookConnectionStatusCopyWith<$Res> implements $OutlookConnectionStatusCopyWith<$Res> {
  factory _$OutlookConnectionStatusCopyWith(_OutlookConnectionStatus value, $Res Function(_OutlookConnectionStatus) _then) = __$OutlookConnectionStatusCopyWithImpl;
@override @useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail
});




}
/// @nodoc
class __$OutlookConnectionStatusCopyWithImpl<$Res>
    implements _$OutlookConnectionStatusCopyWith<$Res> {
  __$OutlookConnectionStatusCopyWithImpl(this._self, this._then);

  final _OutlookConnectionStatus _self;
  final $Res Function(_OutlookConnectionStatus) _then;

/// Create a copy of OutlookConnectionStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,}) {
  return _then(_OutlookConnectionStatus(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$OutlookCalendarEvent {

 String get id; String get subject; String get start; String get end; String get showAs; bool get isAllDay; String? get location; String? get webLink;
/// Create a copy of OutlookCalendarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookCalendarEventCopyWith<OutlookCalendarEvent> get copyWith => _$OutlookCalendarEventCopyWithImpl<OutlookCalendarEvent>(this as OutlookCalendarEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookCalendarEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.showAs, showAs) || other.showAs == showAs)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.location, location) || other.location == location)&&(identical(other.webLink, webLink) || other.webLink == webLink));
}


@override
int get hashCode => Object.hash(runtimeType,id,subject,start,end,showAs,isAllDay,location,webLink);

@override
String toString() {
  return 'OutlookCalendarEvent(id: $id, subject: $subject, start: $start, end: $end, showAs: $showAs, isAllDay: $isAllDay, location: $location, webLink: $webLink)';
}


}

/// @nodoc
abstract mixin class $OutlookCalendarEventCopyWith<$Res>  {
  factory $OutlookCalendarEventCopyWith(OutlookCalendarEvent value, $Res Function(OutlookCalendarEvent) _then) = _$OutlookCalendarEventCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String start, String end, String showAs, bool isAllDay, String? location, String? webLink
});




}
/// @nodoc
class _$OutlookCalendarEventCopyWithImpl<$Res>
    implements $OutlookCalendarEventCopyWith<$Res> {
  _$OutlookCalendarEventCopyWithImpl(this._self, this._then);

  final OutlookCalendarEvent _self;
  final $Res Function(OutlookCalendarEvent) _then;

/// Create a copy of OutlookCalendarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? start = null,Object? end = null,Object? showAs = null,Object? isAllDay = null,Object? location = freezed,Object? webLink = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,showAs: null == showAs ? _self.showAs : showAs // ignore: cast_nullable_to_non_nullable
as String,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,webLink: freezed == webLink ? _self.webLink : webLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookCalendarEvent].
extension OutlookCalendarEventPatterns on OutlookCalendarEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookCalendarEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookCalendarEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookCalendarEvent value)  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookCalendarEvent value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subject,  String start,  String end,  String showAs,  bool isAllDay,  String? location,  String? webLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookCalendarEvent() when $default != null:
return $default(_that.id,_that.subject,_that.start,_that.end,_that.showAs,_that.isAllDay,_that.location,_that.webLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subject,  String start,  String end,  String showAs,  bool isAllDay,  String? location,  String? webLink)  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarEvent():
return $default(_that.id,_that.subject,_that.start,_that.end,_that.showAs,_that.isAllDay,_that.location,_that.webLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subject,  String start,  String end,  String showAs,  bool isAllDay,  String? location,  String? webLink)?  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarEvent() when $default != null:
return $default(_that.id,_that.subject,_that.start,_that.end,_that.showAs,_that.isAllDay,_that.location,_that.webLink);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookCalendarEvent implements OutlookCalendarEvent {
  const _OutlookCalendarEvent({required this.id, required this.subject, required this.start, required this.end, this.showAs = 'busy', this.isAllDay = false, this.location, this.webLink});
  

@override final  String id;
@override final  String subject;
@override final  String start;
@override final  String end;
@override@JsonKey() final  String showAs;
@override@JsonKey() final  bool isAllDay;
@override final  String? location;
@override final  String? webLink;

/// Create a copy of OutlookCalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookCalendarEventCopyWith<_OutlookCalendarEvent> get copyWith => __$OutlookCalendarEventCopyWithImpl<_OutlookCalendarEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookCalendarEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.showAs, showAs) || other.showAs == showAs)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.location, location) || other.location == location)&&(identical(other.webLink, webLink) || other.webLink == webLink));
}


@override
int get hashCode => Object.hash(runtimeType,id,subject,start,end,showAs,isAllDay,location,webLink);

@override
String toString() {
  return 'OutlookCalendarEvent(id: $id, subject: $subject, start: $start, end: $end, showAs: $showAs, isAllDay: $isAllDay, location: $location, webLink: $webLink)';
}


}

/// @nodoc
abstract mixin class _$OutlookCalendarEventCopyWith<$Res> implements $OutlookCalendarEventCopyWith<$Res> {
  factory _$OutlookCalendarEventCopyWith(_OutlookCalendarEvent value, $Res Function(_OutlookCalendarEvent) _then) = __$OutlookCalendarEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String start, String end, String showAs, bool isAllDay, String? location, String? webLink
});




}
/// @nodoc
class __$OutlookCalendarEventCopyWithImpl<$Res>
    implements _$OutlookCalendarEventCopyWith<$Res> {
  __$OutlookCalendarEventCopyWithImpl(this._self, this._then);

  final _OutlookCalendarEvent _self;
  final $Res Function(_OutlookCalendarEvent) _then;

/// Create a copy of OutlookCalendarEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? start = null,Object? end = null,Object? showAs = null,Object? isAllDay = null,Object? location = freezed,Object? webLink = freezed,}) {
  return _then(_OutlookCalendarEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,showAs: null == showAs ? _self.showAs : showAs // ignore: cast_nullable_to_non_nullable
as String,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,webLink: freezed == webLink ? _self.webLink : webLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$OutlookMail {

 String get id; String get subject; String get from; String get receivedAt; String get preview; bool get isRead; bool get hasAttachments; String get importance; String? get body;
/// Create a copy of OutlookMail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookMailCopyWith<OutlookMail> get copyWith => _$OutlookMailCopyWithImpl<OutlookMail>(this as OutlookMail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookMail&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,id,subject,from,receivedAt,preview,isRead,hasAttachments,importance,body);

@override
String toString() {
  return 'OutlookMail(id: $id, subject: $subject, from: $from, receivedAt: $receivedAt, preview: $preview, isRead: $isRead, hasAttachments: $hasAttachments, importance: $importance, body: $body)';
}


}

/// @nodoc
abstract mixin class $OutlookMailCopyWith<$Res>  {
  factory $OutlookMailCopyWith(OutlookMail value, $Res Function(OutlookMail) _then) = _$OutlookMailCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String from, String receivedAt, String preview, bool isRead, bool hasAttachments, String importance, String? body
});




}
/// @nodoc
class _$OutlookMailCopyWithImpl<$Res>
    implements $OutlookMailCopyWith<$Res> {
  _$OutlookMailCopyWithImpl(this._self, this._then);

  final OutlookMail _self;
  final $Res Function(OutlookMail) _then;

/// Create a copy of OutlookMail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? from = null,Object? receivedAt = null,Object? preview = null,Object? isRead = null,Object? hasAttachments = null,Object? importance = null,Object? body = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookMail].
extension OutlookMailPatterns on OutlookMail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookMail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookMail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookMail value)  $default,){
final _that = this;
switch (_that) {
case _OutlookMail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookMail value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookMail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subject,  String from,  String receivedAt,  String preview,  bool isRead,  bool hasAttachments,  String importance,  String? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookMail() when $default != null:
return $default(_that.id,_that.subject,_that.from,_that.receivedAt,_that.preview,_that.isRead,_that.hasAttachments,_that.importance,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subject,  String from,  String receivedAt,  String preview,  bool isRead,  bool hasAttachments,  String importance,  String? body)  $default,) {final _that = this;
switch (_that) {
case _OutlookMail():
return $default(_that.id,_that.subject,_that.from,_that.receivedAt,_that.preview,_that.isRead,_that.hasAttachments,_that.importance,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subject,  String from,  String receivedAt,  String preview,  bool isRead,  bool hasAttachments,  String importance,  String? body)?  $default,) {final _that = this;
switch (_that) {
case _OutlookMail() when $default != null:
return $default(_that.id,_that.subject,_that.from,_that.receivedAt,_that.preview,_that.isRead,_that.hasAttachments,_that.importance,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookMail implements OutlookMail {
  const _OutlookMail({required this.id, required this.subject, required this.from, required this.receivedAt, required this.preview, required this.isRead, required this.hasAttachments, required this.importance, this.body});
  

@override final  String id;
@override final  String subject;
@override final  String from;
@override final  String receivedAt;
@override final  String preview;
@override final  bool isRead;
@override final  bool hasAttachments;
@override final  String importance;
@override final  String? body;

/// Create a copy of OutlookMail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookMailCopyWith<_OutlookMail> get copyWith => __$OutlookMailCopyWithImpl<_OutlookMail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookMail&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,id,subject,from,receivedAt,preview,isRead,hasAttachments,importance,body);

@override
String toString() {
  return 'OutlookMail(id: $id, subject: $subject, from: $from, receivedAt: $receivedAt, preview: $preview, isRead: $isRead, hasAttachments: $hasAttachments, importance: $importance, body: $body)';
}


}

/// @nodoc
abstract mixin class _$OutlookMailCopyWith<$Res> implements $OutlookMailCopyWith<$Res> {
  factory _$OutlookMailCopyWith(_OutlookMail value, $Res Function(_OutlookMail) _then) = __$OutlookMailCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String from, String receivedAt, String preview, bool isRead, bool hasAttachments, String importance, String? body
});




}
/// @nodoc
class __$OutlookMailCopyWithImpl<$Res>
    implements _$OutlookMailCopyWith<$Res> {
  __$OutlookMailCopyWithImpl(this._self, this._then);

  final _OutlookMail _self;
  final $Res Function(_OutlookMail) _then;

/// Create a copy of OutlookMail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? from = null,Object? receivedAt = null,Object? preview = null,Object? isRead = null,Object? hasAttachments = null,Object? importance = null,Object? body = freezed,}) {
  return _then(_OutlookMail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$OutlookCalendarData {

 String get microsoftEmail; List<OutlookCalendarEvent> get events;
/// Create a copy of OutlookCalendarData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookCalendarDataCopyWith<OutlookCalendarData> get copyWith => _$OutlookCalendarDataCopyWithImpl<OutlookCalendarData>(this as OutlookCalendarData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookCalendarData&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other.events, events));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'OutlookCalendarData(microsoftEmail: $microsoftEmail, events: $events)';
}


}

/// @nodoc
abstract mixin class $OutlookCalendarDataCopyWith<$Res>  {
  factory $OutlookCalendarDataCopyWith(OutlookCalendarData value, $Res Function(OutlookCalendarData) _then) = _$OutlookCalendarDataCopyWithImpl;
@useResult
$Res call({
 String microsoftEmail, List<OutlookCalendarEvent> events
});




}
/// @nodoc
class _$OutlookCalendarDataCopyWithImpl<$Res>
    implements $OutlookCalendarDataCopyWith<$Res> {
  _$OutlookCalendarDataCopyWithImpl(this._self, this._then);

  final OutlookCalendarData _self;
  final $Res Function(OutlookCalendarData) _then;

/// Create a copy of OutlookCalendarData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? microsoftEmail = null,Object? events = null,}) {
  return _then(_self.copyWith(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<OutlookCalendarEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookCalendarData].
extension OutlookCalendarDataPatterns on OutlookCalendarData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookCalendarData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookCalendarData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookCalendarData value)  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookCalendarData value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String microsoftEmail,  List<OutlookCalendarEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookCalendarData() when $default != null:
return $default(_that.microsoftEmail,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String microsoftEmail,  List<OutlookCalendarEvent> events)  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarData():
return $default(_that.microsoftEmail,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String microsoftEmail,  List<OutlookCalendarEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarData() when $default != null:
return $default(_that.microsoftEmail,_that.events);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookCalendarData implements OutlookCalendarData {
  const _OutlookCalendarData({required this.microsoftEmail, required final  List<OutlookCalendarEvent> events}): _events = events;
  

@override final  String microsoftEmail;
 final  List<OutlookCalendarEvent> _events;
@override List<OutlookCalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of OutlookCalendarData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookCalendarDataCopyWith<_OutlookCalendarData> get copyWith => __$OutlookCalendarDataCopyWithImpl<_OutlookCalendarData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookCalendarData&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'OutlookCalendarData(microsoftEmail: $microsoftEmail, events: $events)';
}


}

/// @nodoc
abstract mixin class _$OutlookCalendarDataCopyWith<$Res> implements $OutlookCalendarDataCopyWith<$Res> {
  factory _$OutlookCalendarDataCopyWith(_OutlookCalendarData value, $Res Function(_OutlookCalendarData) _then) = __$OutlookCalendarDataCopyWithImpl;
@override @useResult
$Res call({
 String microsoftEmail, List<OutlookCalendarEvent> events
});




}
/// @nodoc
class __$OutlookCalendarDataCopyWithImpl<$Res>
    implements _$OutlookCalendarDataCopyWith<$Res> {
  __$OutlookCalendarDataCopyWithImpl(this._self, this._then);

  final _OutlookCalendarData _self;
  final $Res Function(_OutlookCalendarData) _then;

/// Create a copy of OutlookCalendarData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? microsoftEmail = null,Object? events = null,}) {
  return _then(_OutlookCalendarData(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<OutlookCalendarEvent>,
  ));
}


}

/// @nodoc
mixin _$OutlookMailListData {

 String get microsoftEmail; List<OutlookMail> get mails; bool get unreadOnly; String? get from; String? get to;
/// Create a copy of OutlookMailListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookMailListDataCopyWith<OutlookMailListData> get copyWith => _$OutlookMailListDataCopyWithImpl<OutlookMailListData>(this as OutlookMailListData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookMailListData&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other.mails, mails)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,const DeepCollectionEquality().hash(mails),unreadOnly,from,to);

@override
String toString() {
  return 'OutlookMailListData(microsoftEmail: $microsoftEmail, mails: $mails, unreadOnly: $unreadOnly, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $OutlookMailListDataCopyWith<$Res>  {
  factory $OutlookMailListDataCopyWith(OutlookMailListData value, $Res Function(OutlookMailListData) _then) = _$OutlookMailListDataCopyWithImpl;
@useResult
$Res call({
 String microsoftEmail, List<OutlookMail> mails, bool unreadOnly, String? from, String? to
});




}
/// @nodoc
class _$OutlookMailListDataCopyWithImpl<$Res>
    implements $OutlookMailListDataCopyWith<$Res> {
  _$OutlookMailListDataCopyWithImpl(this._self, this._then);

  final OutlookMailListData _self;
  final $Res Function(OutlookMailListData) _then;

/// Create a copy of OutlookMailListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? microsoftEmail = null,Object? mails = null,Object? unreadOnly = null,Object? from = freezed,Object? to = freezed,}) {
  return _then(_self.copyWith(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,mails: null == mails ? _self.mails : mails // ignore: cast_nullable_to_non_nullable
as List<OutlookMail>,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookMailListData].
extension OutlookMailListDataPatterns on OutlookMailListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookMailListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookMailListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookMailListData value)  $default,){
final _that = this;
switch (_that) {
case _OutlookMailListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookMailListData value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookMailListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String microsoftEmail,  List<OutlookMail> mails,  bool unreadOnly,  String? from,  String? to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookMailListData() when $default != null:
return $default(_that.microsoftEmail,_that.mails,_that.unreadOnly,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String microsoftEmail,  List<OutlookMail> mails,  bool unreadOnly,  String? from,  String? to)  $default,) {final _that = this;
switch (_that) {
case _OutlookMailListData():
return $default(_that.microsoftEmail,_that.mails,_that.unreadOnly,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String microsoftEmail,  List<OutlookMail> mails,  bool unreadOnly,  String? from,  String? to)?  $default,) {final _that = this;
switch (_that) {
case _OutlookMailListData() when $default != null:
return $default(_that.microsoftEmail,_that.mails,_that.unreadOnly,_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookMailListData implements OutlookMailListData {
  const _OutlookMailListData({required this.microsoftEmail, required final  List<OutlookMail> mails, required this.unreadOnly, this.from, this.to}): _mails = mails;
  

@override final  String microsoftEmail;
 final  List<OutlookMail> _mails;
@override List<OutlookMail> get mails {
  if (_mails is EqualUnmodifiableListView) return _mails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mails);
}

@override final  bool unreadOnly;
@override final  String? from;
@override final  String? to;

/// Create a copy of OutlookMailListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookMailListDataCopyWith<_OutlookMailListData> get copyWith => __$OutlookMailListDataCopyWithImpl<_OutlookMailListData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookMailListData&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other._mails, _mails)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,const DeepCollectionEquality().hash(_mails),unreadOnly,from,to);

@override
String toString() {
  return 'OutlookMailListData(microsoftEmail: $microsoftEmail, mails: $mails, unreadOnly: $unreadOnly, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$OutlookMailListDataCopyWith<$Res> implements $OutlookMailListDataCopyWith<$Res> {
  factory _$OutlookMailListDataCopyWith(_OutlookMailListData value, $Res Function(_OutlookMailListData) _then) = __$OutlookMailListDataCopyWithImpl;
@override @useResult
$Res call({
 String microsoftEmail, List<OutlookMail> mails, bool unreadOnly, String? from, String? to
});




}
/// @nodoc
class __$OutlookMailListDataCopyWithImpl<$Res>
    implements _$OutlookMailListDataCopyWith<$Res> {
  __$OutlookMailListDataCopyWithImpl(this._self, this._then);

  final _OutlookMailListData _self;
  final $Res Function(_OutlookMailListData) _then;

/// Create a copy of OutlookMailListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? microsoftEmail = null,Object? mails = null,Object? unreadOnly = null,Object? from = freezed,Object? to = freezed,}) {
  return _then(_OutlookMailListData(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,mails: null == mails ? _self._mails : mails // ignore: cast_nullable_to_non_nullable
as List<OutlookMail>,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$OutlookEventMutation {

 String get microsoftEmail; OutlookCalendarEvent get event;
/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookEventMutationCopyWith<OutlookEventMutation> get copyWith => _$OutlookEventMutationCopyWithImpl<OutlookEventMutation>(this as OutlookEventMutation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookEventMutation&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,event);

@override
String toString() {
  return 'OutlookEventMutation(microsoftEmail: $microsoftEmail, event: $event)';
}


}

/// @nodoc
abstract mixin class $OutlookEventMutationCopyWith<$Res>  {
  factory $OutlookEventMutationCopyWith(OutlookEventMutation value, $Res Function(OutlookEventMutation) _then) = _$OutlookEventMutationCopyWithImpl;
@useResult
$Res call({
 String microsoftEmail, OutlookCalendarEvent event
});


$OutlookCalendarEventCopyWith<$Res> get event;

}
/// @nodoc
class _$OutlookEventMutationCopyWithImpl<$Res>
    implements $OutlookEventMutationCopyWith<$Res> {
  _$OutlookEventMutationCopyWithImpl(this._self, this._then);

  final OutlookEventMutation _self;
  final $Res Function(OutlookEventMutation) _then;

/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? microsoftEmail = null,Object? event = null,}) {
  return _then(_self.copyWith(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as OutlookCalendarEvent,
  ));
}
/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OutlookCalendarEventCopyWith<$Res> get event {
  
  return $OutlookCalendarEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [OutlookEventMutation].
extension OutlookEventMutationPatterns on OutlookEventMutation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookEventMutation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookEventMutation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookEventMutation value)  $default,){
final _that = this;
switch (_that) {
case _OutlookEventMutation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookEventMutation value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookEventMutation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String microsoftEmail,  OutlookCalendarEvent event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookEventMutation() when $default != null:
return $default(_that.microsoftEmail,_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String microsoftEmail,  OutlookCalendarEvent event)  $default,) {final _that = this;
switch (_that) {
case _OutlookEventMutation():
return $default(_that.microsoftEmail,_that.event);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String microsoftEmail,  OutlookCalendarEvent event)?  $default,) {final _that = this;
switch (_that) {
case _OutlookEventMutation() when $default != null:
return $default(_that.microsoftEmail,_that.event);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookEventMutation implements OutlookEventMutation {
  const _OutlookEventMutation({required this.microsoftEmail, required this.event});
  

@override final  String microsoftEmail;
@override final  OutlookCalendarEvent event;

/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookEventMutationCopyWith<_OutlookEventMutation> get copyWith => __$OutlookEventMutationCopyWithImpl<_OutlookEventMutation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookEventMutation&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,event);

@override
String toString() {
  return 'OutlookEventMutation(microsoftEmail: $microsoftEmail, event: $event)';
}


}

/// @nodoc
abstract mixin class _$OutlookEventMutationCopyWith<$Res> implements $OutlookEventMutationCopyWith<$Res> {
  factory _$OutlookEventMutationCopyWith(_OutlookEventMutation value, $Res Function(_OutlookEventMutation) _then) = __$OutlookEventMutationCopyWithImpl;
@override @useResult
$Res call({
 String microsoftEmail, OutlookCalendarEvent event
});


@override $OutlookCalendarEventCopyWith<$Res> get event;

}
/// @nodoc
class __$OutlookEventMutationCopyWithImpl<$Res>
    implements _$OutlookEventMutationCopyWith<$Res> {
  __$OutlookEventMutationCopyWithImpl(this._self, this._then);

  final _OutlookEventMutation _self;
  final $Res Function(_OutlookEventMutation) _then;

/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? microsoftEmail = null,Object? event = null,}) {
  return _then(_OutlookEventMutation(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as OutlookCalendarEvent,
  ));
}

/// Create a copy of OutlookEventMutation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OutlookCalendarEventCopyWith<$Res> get event {
  
  return $OutlookCalendarEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc
mixin _$OutlookReplyMutation {

 String get microsoftEmail; String get messageId;
/// Create a copy of OutlookReplyMutation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookReplyMutationCopyWith<OutlookReplyMutation> get copyWith => _$OutlookReplyMutationCopyWithImpl<OutlookReplyMutation>(this as OutlookReplyMutation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookReplyMutation&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,messageId);

@override
String toString() {
  return 'OutlookReplyMutation(microsoftEmail: $microsoftEmail, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class $OutlookReplyMutationCopyWith<$Res>  {
  factory $OutlookReplyMutationCopyWith(OutlookReplyMutation value, $Res Function(OutlookReplyMutation) _then) = _$OutlookReplyMutationCopyWithImpl;
@useResult
$Res call({
 String microsoftEmail, String messageId
});




}
/// @nodoc
class _$OutlookReplyMutationCopyWithImpl<$Res>
    implements $OutlookReplyMutationCopyWith<$Res> {
  _$OutlookReplyMutationCopyWithImpl(this._self, this._then);

  final OutlookReplyMutation _self;
  final $Res Function(OutlookReplyMutation) _then;

/// Create a copy of OutlookReplyMutation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? microsoftEmail = null,Object? messageId = null,}) {
  return _then(_self.copyWith(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookReplyMutation].
extension OutlookReplyMutationPatterns on OutlookReplyMutation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookReplyMutation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookReplyMutation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookReplyMutation value)  $default,){
final _that = this;
switch (_that) {
case _OutlookReplyMutation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookReplyMutation value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookReplyMutation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String microsoftEmail,  String messageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookReplyMutation() when $default != null:
return $default(_that.microsoftEmail,_that.messageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String microsoftEmail,  String messageId)  $default,) {final _that = this;
switch (_that) {
case _OutlookReplyMutation():
return $default(_that.microsoftEmail,_that.messageId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String microsoftEmail,  String messageId)?  $default,) {final _that = this;
switch (_that) {
case _OutlookReplyMutation() when $default != null:
return $default(_that.microsoftEmail,_that.messageId);case _:
  return null;

}
}

}

/// @nodoc


class _OutlookReplyMutation implements OutlookReplyMutation {
  const _OutlookReplyMutation({required this.microsoftEmail, required this.messageId});
  

@override final  String microsoftEmail;
@override final  String messageId;

/// Create a copy of OutlookReplyMutation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookReplyMutationCopyWith<_OutlookReplyMutation> get copyWith => __$OutlookReplyMutationCopyWithImpl<_OutlookReplyMutation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookReplyMutation&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}


@override
int get hashCode => Object.hash(runtimeType,microsoftEmail,messageId);

@override
String toString() {
  return 'OutlookReplyMutation(microsoftEmail: $microsoftEmail, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class _$OutlookReplyMutationCopyWith<$Res> implements $OutlookReplyMutationCopyWith<$Res> {
  factory _$OutlookReplyMutationCopyWith(_OutlookReplyMutation value, $Res Function(_OutlookReplyMutation) _then) = __$OutlookReplyMutationCopyWithImpl;
@override @useResult
$Res call({
 String microsoftEmail, String messageId
});




}
/// @nodoc
class __$OutlookReplyMutationCopyWithImpl<$Res>
    implements _$OutlookReplyMutationCopyWith<$Res> {
  __$OutlookReplyMutationCopyWithImpl(this._self, this._then);

  final _OutlookReplyMutation _self;
  final $Res Function(_OutlookReplyMutation) _then;

/// Create a copy of OutlookReplyMutation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? microsoftEmail = null,Object? messageId = null,}) {
  return _then(_OutlookReplyMutation(
microsoftEmail: null == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
