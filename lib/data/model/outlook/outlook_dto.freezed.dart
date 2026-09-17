// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outlook_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutlookStatusDto {

 bool get configured; bool get connected; String? get microsoftEmail;
/// Create a copy of OutlookStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookStatusDtoCopyWith<OutlookStatusDto> get copyWith => _$OutlookStatusDtoCopyWithImpl<OutlookStatusDto>(this as OutlookStatusDto, _$identity);

  /// Serializes this OutlookStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookStatusDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail);

@override
String toString() {
  return 'OutlookStatusDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail)';
}


}

/// @nodoc
abstract mixin class $OutlookStatusDtoCopyWith<$Res>  {
  factory $OutlookStatusDtoCopyWith(OutlookStatusDto value, $Res Function(OutlookStatusDto) _then) = _$OutlookStatusDtoCopyWithImpl;
@useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail
});




}
/// @nodoc
class _$OutlookStatusDtoCopyWithImpl<$Res>
    implements $OutlookStatusDtoCopyWith<$Res> {
  _$OutlookStatusDtoCopyWithImpl(this._self, this._then);

  final OutlookStatusDto _self;
  final $Res Function(OutlookStatusDto) _then;

/// Create a copy of OutlookStatusDto
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


/// Adds pattern-matching-related methods to [OutlookStatusDto].
extension OutlookStatusDtoPatterns on OutlookStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookStatusDto() when $default != null:
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
case _OutlookStatusDto() when $default != null:
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
case _OutlookStatusDto():
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
case _OutlookStatusDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookStatusDto implements OutlookStatusDto {
  const _OutlookStatusDto({required this.configured, required this.connected, this.microsoftEmail});
  factory _OutlookStatusDto.fromJson(Map<String, dynamic> json) => _$OutlookStatusDtoFromJson(json);

@override final  bool configured;
@override final  bool connected;
@override final  String? microsoftEmail;

/// Create a copy of OutlookStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookStatusDtoCopyWith<_OutlookStatusDto> get copyWith => __$OutlookStatusDtoCopyWithImpl<_OutlookStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookStatusDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail);

@override
String toString() {
  return 'OutlookStatusDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail)';
}


}

/// @nodoc
abstract mixin class _$OutlookStatusDtoCopyWith<$Res> implements $OutlookStatusDtoCopyWith<$Res> {
  factory _$OutlookStatusDtoCopyWith(_OutlookStatusDto value, $Res Function(_OutlookStatusDto) _then) = __$OutlookStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail
});




}
/// @nodoc
class __$OutlookStatusDtoCopyWithImpl<$Res>
    implements _$OutlookStatusDtoCopyWith<$Res> {
  __$OutlookStatusDtoCopyWithImpl(this._self, this._then);

  final _OutlookStatusDto _self;
  final $Res Function(_OutlookStatusDto) _then;

/// Create a copy of OutlookStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,}) {
  return _then(_OutlookStatusDto(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OutlookAuthUrlDto {

 String get url;
/// Create a copy of OutlookAuthUrlDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookAuthUrlDtoCopyWith<OutlookAuthUrlDto> get copyWith => _$OutlookAuthUrlDtoCopyWithImpl<OutlookAuthUrlDto>(this as OutlookAuthUrlDto, _$identity);

  /// Serializes this OutlookAuthUrlDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookAuthUrlDto&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'OutlookAuthUrlDto(url: $url)';
}


}

/// @nodoc
abstract mixin class $OutlookAuthUrlDtoCopyWith<$Res>  {
  factory $OutlookAuthUrlDtoCopyWith(OutlookAuthUrlDto value, $Res Function(OutlookAuthUrlDto) _then) = _$OutlookAuthUrlDtoCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$OutlookAuthUrlDtoCopyWithImpl<$Res>
    implements $OutlookAuthUrlDtoCopyWith<$Res> {
  _$OutlookAuthUrlDtoCopyWithImpl(this._self, this._then);

  final OutlookAuthUrlDto _self;
  final $Res Function(OutlookAuthUrlDto) _then;

/// Create a copy of OutlookAuthUrlDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookAuthUrlDto].
extension OutlookAuthUrlDtoPatterns on OutlookAuthUrlDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookAuthUrlDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookAuthUrlDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookAuthUrlDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookAuthUrlDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookAuthUrlDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookAuthUrlDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookAuthUrlDto() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _OutlookAuthUrlDto():
return $default(_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _OutlookAuthUrlDto() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookAuthUrlDto implements OutlookAuthUrlDto {
  const _OutlookAuthUrlDto({required this.url});
  factory _OutlookAuthUrlDto.fromJson(Map<String, dynamic> json) => _$OutlookAuthUrlDtoFromJson(json);

@override final  String url;

/// Create a copy of OutlookAuthUrlDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookAuthUrlDtoCopyWith<_OutlookAuthUrlDto> get copyWith => __$OutlookAuthUrlDtoCopyWithImpl<_OutlookAuthUrlDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookAuthUrlDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookAuthUrlDto&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'OutlookAuthUrlDto(url: $url)';
}


}

/// @nodoc
abstract mixin class _$OutlookAuthUrlDtoCopyWith<$Res> implements $OutlookAuthUrlDtoCopyWith<$Res> {
  factory _$OutlookAuthUrlDtoCopyWith(_OutlookAuthUrlDto value, $Res Function(_OutlookAuthUrlDto) _then) = __$OutlookAuthUrlDtoCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$OutlookAuthUrlDtoCopyWithImpl<$Res>
    implements _$OutlookAuthUrlDtoCopyWith<$Res> {
  __$OutlookAuthUrlDtoCopyWithImpl(this._self, this._then);

  final _OutlookAuthUrlDto _self;
  final $Res Function(_OutlookAuthUrlDto) _then;

/// Create a copy of OutlookAuthUrlDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_OutlookAuthUrlDto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OutlookEventDto {

 String get id; String get subject; String get start; String get end; String get showAs; bool get isAllDay; String? get location; String? get webLink;
/// Create a copy of OutlookEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookEventDtoCopyWith<OutlookEventDto> get copyWith => _$OutlookEventDtoCopyWithImpl<OutlookEventDto>(this as OutlookEventDto, _$identity);

  /// Serializes this OutlookEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.showAs, showAs) || other.showAs == showAs)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.location, location) || other.location == location)&&(identical(other.webLink, webLink) || other.webLink == webLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,start,end,showAs,isAllDay,location,webLink);

@override
String toString() {
  return 'OutlookEventDto(id: $id, subject: $subject, start: $start, end: $end, showAs: $showAs, isAllDay: $isAllDay, location: $location, webLink: $webLink)';
}


}

/// @nodoc
abstract mixin class $OutlookEventDtoCopyWith<$Res>  {
  factory $OutlookEventDtoCopyWith(OutlookEventDto value, $Res Function(OutlookEventDto) _then) = _$OutlookEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String start, String end, String showAs, bool isAllDay, String? location, String? webLink
});




}
/// @nodoc
class _$OutlookEventDtoCopyWithImpl<$Res>
    implements $OutlookEventDtoCopyWith<$Res> {
  _$OutlookEventDtoCopyWithImpl(this._self, this._then);

  final OutlookEventDto _self;
  final $Res Function(OutlookEventDto) _then;

/// Create a copy of OutlookEventDto
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


/// Adds pattern-matching-related methods to [OutlookEventDto].
extension OutlookEventDtoPatterns on OutlookEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookEventDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookEventDto() when $default != null:
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
case _OutlookEventDto() when $default != null:
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
case _OutlookEventDto():
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
case _OutlookEventDto() when $default != null:
return $default(_that.id,_that.subject,_that.start,_that.end,_that.showAs,_that.isAllDay,_that.location,_that.webLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookEventDto implements OutlookEventDto {
  const _OutlookEventDto({required this.id, required this.subject, required this.start, required this.end, this.showAs = 'busy', this.isAllDay = false, this.location, this.webLink});
  factory _OutlookEventDto.fromJson(Map<String, dynamic> json) => _$OutlookEventDtoFromJson(json);

@override final  String id;
@override final  String subject;
@override final  String start;
@override final  String end;
@override@JsonKey() final  String showAs;
@override@JsonKey() final  bool isAllDay;
@override final  String? location;
@override final  String? webLink;

/// Create a copy of OutlookEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookEventDtoCopyWith<_OutlookEventDto> get copyWith => __$OutlookEventDtoCopyWithImpl<_OutlookEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.showAs, showAs) || other.showAs == showAs)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.location, location) || other.location == location)&&(identical(other.webLink, webLink) || other.webLink == webLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,start,end,showAs,isAllDay,location,webLink);

@override
String toString() {
  return 'OutlookEventDto(id: $id, subject: $subject, start: $start, end: $end, showAs: $showAs, isAllDay: $isAllDay, location: $location, webLink: $webLink)';
}


}

/// @nodoc
abstract mixin class _$OutlookEventDtoCopyWith<$Res> implements $OutlookEventDtoCopyWith<$Res> {
  factory _$OutlookEventDtoCopyWith(_OutlookEventDto value, $Res Function(_OutlookEventDto) _then) = __$OutlookEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String start, String end, String showAs, bool isAllDay, String? location, String? webLink
});




}
/// @nodoc
class __$OutlookEventDtoCopyWithImpl<$Res>
    implements _$OutlookEventDtoCopyWith<$Res> {
  __$OutlookEventDtoCopyWithImpl(this._self, this._then);

  final _OutlookEventDto _self;
  final $Res Function(_OutlookEventDto) _then;

/// Create a copy of OutlookEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? start = null,Object? end = null,Object? showAs = null,Object? isAllDay = null,Object? location = freezed,Object? webLink = freezed,}) {
  return _then(_OutlookEventDto(
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
mixin _$OutlookMailDto {

 String get id; String get subject; String get from; String get receivedAt; String get preview; bool get isRead; bool get hasAttachments; String get importance; String? get body;
/// Create a copy of OutlookMailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookMailDtoCopyWith<OutlookMailDto> get copyWith => _$OutlookMailDtoCopyWithImpl<OutlookMailDto>(this as OutlookMailDto, _$identity);

  /// Serializes this OutlookMailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookMailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,from,receivedAt,preview,isRead,hasAttachments,importance,body);

@override
String toString() {
  return 'OutlookMailDto(id: $id, subject: $subject, from: $from, receivedAt: $receivedAt, preview: $preview, isRead: $isRead, hasAttachments: $hasAttachments, importance: $importance, body: $body)';
}


}

/// @nodoc
abstract mixin class $OutlookMailDtoCopyWith<$Res>  {
  factory $OutlookMailDtoCopyWith(OutlookMailDto value, $Res Function(OutlookMailDto) _then) = _$OutlookMailDtoCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String from, String receivedAt, String preview, bool isRead, bool hasAttachments, String importance, String? body
});




}
/// @nodoc
class _$OutlookMailDtoCopyWithImpl<$Res>
    implements $OutlookMailDtoCopyWith<$Res> {
  _$OutlookMailDtoCopyWithImpl(this._self, this._then);

  final OutlookMailDto _self;
  final $Res Function(OutlookMailDto) _then;

/// Create a copy of OutlookMailDto
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


/// Adds pattern-matching-related methods to [OutlookMailDto].
extension OutlookMailDtoPatterns on OutlookMailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookMailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookMailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookMailDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookMailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookMailDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookMailDto() when $default != null:
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
case _OutlookMailDto() when $default != null:
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
case _OutlookMailDto():
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
case _OutlookMailDto() when $default != null:
return $default(_that.id,_that.subject,_that.from,_that.receivedAt,_that.preview,_that.isRead,_that.hasAttachments,_that.importance,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookMailDto implements OutlookMailDto {
  const _OutlookMailDto({required this.id, required this.subject, required this.from, required this.receivedAt, required this.preview, required this.isRead, required this.hasAttachments, required this.importance, this.body});
  factory _OutlookMailDto.fromJson(Map<String, dynamic> json) => _$OutlookMailDtoFromJson(json);

@override final  String id;
@override final  String subject;
@override final  String from;
@override final  String receivedAt;
@override final  String preview;
@override final  bool isRead;
@override final  bool hasAttachments;
@override final  String importance;
@override final  String? body;

/// Create a copy of OutlookMailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookMailDtoCopyWith<_OutlookMailDto> get copyWith => __$OutlookMailDtoCopyWithImpl<_OutlookMailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookMailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookMailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,from,receivedAt,preview,isRead,hasAttachments,importance,body);

@override
String toString() {
  return 'OutlookMailDto(id: $id, subject: $subject, from: $from, receivedAt: $receivedAt, preview: $preview, isRead: $isRead, hasAttachments: $hasAttachments, importance: $importance, body: $body)';
}


}

/// @nodoc
abstract mixin class _$OutlookMailDtoCopyWith<$Res> implements $OutlookMailDtoCopyWith<$Res> {
  factory _$OutlookMailDtoCopyWith(_OutlookMailDto value, $Res Function(_OutlookMailDto) _then) = __$OutlookMailDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String from, String receivedAt, String preview, bool isRead, bool hasAttachments, String importance, String? body
});




}
/// @nodoc
class __$OutlookMailDtoCopyWithImpl<$Res>
    implements _$OutlookMailDtoCopyWith<$Res> {
  __$OutlookMailDtoCopyWithImpl(this._self, this._then);

  final _OutlookMailDto _self;
  final $Res Function(_OutlookMailDto) _then;

/// Create a copy of OutlookMailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? from = null,Object? receivedAt = null,Object? preview = null,Object? isRead = null,Object? hasAttachments = null,Object? importance = null,Object? body = freezed,}) {
  return _then(_OutlookMailDto(
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
mixin _$OutlookCalendarResponseDto {

 bool get configured; bool get connected; String? get microsoftEmail; List<OutlookEventDto> get events; String? get error;
/// Create a copy of OutlookCalendarResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookCalendarResponseDtoCopyWith<OutlookCalendarResponseDto> get copyWith => _$OutlookCalendarResponseDtoCopyWithImpl<OutlookCalendarResponseDto>(this as OutlookCalendarResponseDto, _$identity);

  /// Serializes this OutlookCalendarResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookCalendarResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,const DeepCollectionEquality().hash(events),error);

@override
String toString() {
  return 'OutlookCalendarResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, events: $events, error: $error)';
}


}

/// @nodoc
abstract mixin class $OutlookCalendarResponseDtoCopyWith<$Res>  {
  factory $OutlookCalendarResponseDtoCopyWith(OutlookCalendarResponseDto value, $Res Function(OutlookCalendarResponseDto) _then) = _$OutlookCalendarResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, List<OutlookEventDto> events, String? error
});




}
/// @nodoc
class _$OutlookCalendarResponseDtoCopyWithImpl<$Res>
    implements $OutlookCalendarResponseDtoCopyWith<$Res> {
  _$OutlookCalendarResponseDtoCopyWithImpl(this._self, this._then);

  final OutlookCalendarResponseDto _self;
  final $Res Function(OutlookCalendarResponseDto) _then;

/// Create a copy of OutlookCalendarResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? events = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<OutlookEventDto>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookCalendarResponseDto].
extension OutlookCalendarResponseDtoPatterns on OutlookCalendarResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookCalendarResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookCalendarResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookCalendarResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  List<OutlookEventDto> events,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.events,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  List<OutlookEventDto> events,  String? error)  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto():
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.events,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool configured,  bool connected,  String? microsoftEmail,  List<OutlookEventDto> events,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _OutlookCalendarResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.events,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookCalendarResponseDto implements OutlookCalendarResponseDto {
  const _OutlookCalendarResponseDto({required this.configured, required this.connected, this.microsoftEmail, final  List<OutlookEventDto> events = const <OutlookEventDto>[], this.error}): _events = events;
  factory _OutlookCalendarResponseDto.fromJson(Map<String, dynamic> json) => _$OutlookCalendarResponseDtoFromJson(json);

@override final  bool configured;
@override final  bool connected;
@override final  String? microsoftEmail;
 final  List<OutlookEventDto> _events;
@override@JsonKey() List<OutlookEventDto> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  String? error;

/// Create a copy of OutlookCalendarResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookCalendarResponseDtoCopyWith<_OutlookCalendarResponseDto> get copyWith => __$OutlookCalendarResponseDtoCopyWithImpl<_OutlookCalendarResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookCalendarResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookCalendarResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,const DeepCollectionEquality().hash(_events),error);

@override
String toString() {
  return 'OutlookCalendarResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, events: $events, error: $error)';
}


}

/// @nodoc
abstract mixin class _$OutlookCalendarResponseDtoCopyWith<$Res> implements $OutlookCalendarResponseDtoCopyWith<$Res> {
  factory _$OutlookCalendarResponseDtoCopyWith(_OutlookCalendarResponseDto value, $Res Function(_OutlookCalendarResponseDto) _then) = __$OutlookCalendarResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, List<OutlookEventDto> events, String? error
});




}
/// @nodoc
class __$OutlookCalendarResponseDtoCopyWithImpl<$Res>
    implements _$OutlookCalendarResponseDtoCopyWith<$Res> {
  __$OutlookCalendarResponseDtoCopyWithImpl(this._self, this._then);

  final _OutlookCalendarResponseDto _self;
  final $Res Function(_OutlookCalendarResponseDto) _then;

/// Create a copy of OutlookCalendarResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? events = null,Object? error = freezed,}) {
  return _then(_OutlookCalendarResponseDto(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<OutlookEventDto>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OutlookMailListResponseDto {

 bool get configured; bool get connected; String? get microsoftEmail; bool get unreadOnly; String? get from; String? get to; int get count; List<OutlookMailDto> get mails; String? get error;
/// Create a copy of OutlookMailListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookMailListResponseDtoCopyWith<OutlookMailListResponseDto> get copyWith => _$OutlookMailListResponseDtoCopyWithImpl<OutlookMailListResponseDto>(this as OutlookMailListResponseDto, _$identity);

  /// Serializes this OutlookMailListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookMailListResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.mails, mails)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,unreadOnly,from,to,count,const DeepCollectionEquality().hash(mails),error);

@override
String toString() {
  return 'OutlookMailListResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, unreadOnly: $unreadOnly, from: $from, to: $to, count: $count, mails: $mails, error: $error)';
}


}

/// @nodoc
abstract mixin class $OutlookMailListResponseDtoCopyWith<$Res>  {
  factory $OutlookMailListResponseDtoCopyWith(OutlookMailListResponseDto value, $Res Function(OutlookMailListResponseDto) _then) = _$OutlookMailListResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, bool unreadOnly, String? from, String? to, int count, List<OutlookMailDto> mails, String? error
});




}
/// @nodoc
class _$OutlookMailListResponseDtoCopyWithImpl<$Res>
    implements $OutlookMailListResponseDtoCopyWith<$Res> {
  _$OutlookMailListResponseDtoCopyWithImpl(this._self, this._then);

  final OutlookMailListResponseDto _self;
  final $Res Function(OutlookMailListResponseDto) _then;

/// Create a copy of OutlookMailListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? unreadOnly = null,Object? from = freezed,Object? to = freezed,Object? count = null,Object? mails = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,mails: null == mails ? _self.mails : mails // ignore: cast_nullable_to_non_nullable
as List<OutlookMailDto>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OutlookMailListResponseDto].
extension OutlookMailListResponseDtoPatterns on OutlookMailListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookMailListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookMailListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookMailListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookMailListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookMailListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookMailListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  bool unreadOnly,  String? from,  String? to,  int count,  List<OutlookMailDto> mails,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookMailListResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.unreadOnly,_that.from,_that.to,_that.count,_that.mails,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  bool unreadOnly,  String? from,  String? to,  int count,  List<OutlookMailDto> mails,  String? error)  $default,) {final _that = this;
switch (_that) {
case _OutlookMailListResponseDto():
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.unreadOnly,_that.from,_that.to,_that.count,_that.mails,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool configured,  bool connected,  String? microsoftEmail,  bool unreadOnly,  String? from,  String? to,  int count,  List<OutlookMailDto> mails,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _OutlookMailListResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.unreadOnly,_that.from,_that.to,_that.count,_that.mails,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookMailListResponseDto implements OutlookMailListResponseDto {
  const _OutlookMailListResponseDto({required this.configured, required this.connected, this.microsoftEmail, this.unreadOnly = false, this.from, this.to, this.count = 0, final  List<OutlookMailDto> mails = const <OutlookMailDto>[], this.error}): _mails = mails;
  factory _OutlookMailListResponseDto.fromJson(Map<String, dynamic> json) => _$OutlookMailListResponseDtoFromJson(json);

@override final  bool configured;
@override final  bool connected;
@override final  String? microsoftEmail;
@override@JsonKey() final  bool unreadOnly;
@override final  String? from;
@override final  String? to;
@override@JsonKey() final  int count;
 final  List<OutlookMailDto> _mails;
@override@JsonKey() List<OutlookMailDto> get mails {
  if (_mails is EqualUnmodifiableListView) return _mails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mails);
}

@override final  String? error;

/// Create a copy of OutlookMailListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookMailListResponseDtoCopyWith<_OutlookMailListResponseDto> get copyWith => __$OutlookMailListResponseDtoCopyWithImpl<_OutlookMailListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookMailListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookMailListResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.unreadOnly, unreadOnly) || other.unreadOnly == unreadOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._mails, _mails)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,unreadOnly,from,to,count,const DeepCollectionEquality().hash(_mails),error);

@override
String toString() {
  return 'OutlookMailListResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, unreadOnly: $unreadOnly, from: $from, to: $to, count: $count, mails: $mails, error: $error)';
}


}

/// @nodoc
abstract mixin class _$OutlookMailListResponseDtoCopyWith<$Res> implements $OutlookMailListResponseDtoCopyWith<$Res> {
  factory _$OutlookMailListResponseDtoCopyWith(_OutlookMailListResponseDto value, $Res Function(_OutlookMailListResponseDto) _then) = __$OutlookMailListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, bool unreadOnly, String? from, String? to, int count, List<OutlookMailDto> mails, String? error
});




}
/// @nodoc
class __$OutlookMailListResponseDtoCopyWithImpl<$Res>
    implements _$OutlookMailListResponseDtoCopyWith<$Res> {
  __$OutlookMailListResponseDtoCopyWithImpl(this._self, this._then);

  final _OutlookMailListResponseDto _self;
  final $Res Function(_OutlookMailListResponseDto) _then;

/// Create a copy of OutlookMailListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? unreadOnly = null,Object? from = freezed,Object? to = freezed,Object? count = null,Object? mails = null,Object? error = freezed,}) {
  return _then(_OutlookMailListResponseDto(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,unreadOnly: null == unreadOnly ? _self.unreadOnly : unreadOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,mails: null == mails ? _self._mails : mails // ignore: cast_nullable_to_non_nullable
as List<OutlookMailDto>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OutlookMailDetailResponseDto {

 bool get configured; bool get connected; String? get microsoftEmail; OutlookMailDto? get mail; String? get error;
/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutlookMailDetailResponseDtoCopyWith<OutlookMailDetailResponseDto> get copyWith => _$OutlookMailDetailResponseDtoCopyWithImpl<OutlookMailDetailResponseDto>(this as OutlookMailDetailResponseDto, _$identity);

  /// Serializes this OutlookMailDetailResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutlookMailDetailResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.mail, mail) || other.mail == mail)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,mail,error);

@override
String toString() {
  return 'OutlookMailDetailResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, mail: $mail, error: $error)';
}


}

/// @nodoc
abstract mixin class $OutlookMailDetailResponseDtoCopyWith<$Res>  {
  factory $OutlookMailDetailResponseDtoCopyWith(OutlookMailDetailResponseDto value, $Res Function(OutlookMailDetailResponseDto) _then) = _$OutlookMailDetailResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, OutlookMailDto? mail, String? error
});


$OutlookMailDtoCopyWith<$Res>? get mail;

}
/// @nodoc
class _$OutlookMailDetailResponseDtoCopyWithImpl<$Res>
    implements $OutlookMailDetailResponseDtoCopyWith<$Res> {
  _$OutlookMailDetailResponseDtoCopyWithImpl(this._self, this._then);

  final OutlookMailDetailResponseDto _self;
  final $Res Function(OutlookMailDetailResponseDto) _then;

/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? mail = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,mail: freezed == mail ? _self.mail : mail // ignore: cast_nullable_to_non_nullable
as OutlookMailDto?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OutlookMailDtoCopyWith<$Res>? get mail {
    if (_self.mail == null) {
    return null;
  }

  return $OutlookMailDtoCopyWith<$Res>(_self.mail!, (value) {
    return _then(_self.copyWith(mail: value));
  });
}
}


/// Adds pattern-matching-related methods to [OutlookMailDetailResponseDto].
extension OutlookMailDetailResponseDtoPatterns on OutlookMailDetailResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutlookMailDetailResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutlookMailDetailResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutlookMailDetailResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  OutlookMailDto? mail,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.mail,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool configured,  bool connected,  String? microsoftEmail,  OutlookMailDto? mail,  String? error)  $default,) {final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto():
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.mail,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool configured,  bool connected,  String? microsoftEmail,  OutlookMailDto? mail,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _OutlookMailDetailResponseDto() when $default != null:
return $default(_that.configured,_that.connected,_that.microsoftEmail,_that.mail,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutlookMailDetailResponseDto implements OutlookMailDetailResponseDto {
  const _OutlookMailDetailResponseDto({required this.configured, required this.connected, this.microsoftEmail, this.mail, this.error});
  factory _OutlookMailDetailResponseDto.fromJson(Map<String, dynamic> json) => _$OutlookMailDetailResponseDtoFromJson(json);

@override final  bool configured;
@override final  bool connected;
@override final  String? microsoftEmail;
@override final  OutlookMailDto? mail;
@override final  String? error;

/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutlookMailDetailResponseDtoCopyWith<_OutlookMailDetailResponseDto> get copyWith => __$OutlookMailDetailResponseDtoCopyWithImpl<_OutlookMailDetailResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutlookMailDetailResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutlookMailDetailResponseDto&&(identical(other.configured, configured) || other.configured == configured)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.microsoftEmail, microsoftEmail) || other.microsoftEmail == microsoftEmail)&&(identical(other.mail, mail) || other.mail == mail)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,configured,connected,microsoftEmail,mail,error);

@override
String toString() {
  return 'OutlookMailDetailResponseDto(configured: $configured, connected: $connected, microsoftEmail: $microsoftEmail, mail: $mail, error: $error)';
}


}

/// @nodoc
abstract mixin class _$OutlookMailDetailResponseDtoCopyWith<$Res> implements $OutlookMailDetailResponseDtoCopyWith<$Res> {
  factory _$OutlookMailDetailResponseDtoCopyWith(_OutlookMailDetailResponseDto value, $Res Function(_OutlookMailDetailResponseDto) _then) = __$OutlookMailDetailResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool configured, bool connected, String? microsoftEmail, OutlookMailDto? mail, String? error
});


@override $OutlookMailDtoCopyWith<$Res>? get mail;

}
/// @nodoc
class __$OutlookMailDetailResponseDtoCopyWithImpl<$Res>
    implements _$OutlookMailDetailResponseDtoCopyWith<$Res> {
  __$OutlookMailDetailResponseDtoCopyWithImpl(this._self, this._then);

  final _OutlookMailDetailResponseDto _self;
  final $Res Function(_OutlookMailDetailResponseDto) _then;

/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configured = null,Object? connected = null,Object? microsoftEmail = freezed,Object? mail = freezed,Object? error = freezed,}) {
  return _then(_OutlookMailDetailResponseDto(
configured: null == configured ? _self.configured : configured // ignore: cast_nullable_to_non_nullable
as bool,connected: null == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool,microsoftEmail: freezed == microsoftEmail ? _self.microsoftEmail : microsoftEmail // ignore: cast_nullable_to_non_nullable
as String?,mail: freezed == mail ? _self.mail : mail // ignore: cast_nullable_to_non_nullable
as OutlookMailDto?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OutlookMailDetailResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OutlookMailDtoCopyWith<$Res>? get mail {
    if (_self.mail == null) {
    return null;
  }

  return $OutlookMailDtoCopyWith<$Res>(_self.mail!, (value) {
    return _then(_self.copyWith(mail: value));
  });
}
}

// dart format on
