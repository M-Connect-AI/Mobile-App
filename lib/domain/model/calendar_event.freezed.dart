// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarEventDraft {

 String get title; String? get description; DateTime get start; DateTime get end; bool get isAllDay; Duration? get reminderBefore;
/// Create a copy of CalendarEventDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventDraftCopyWith<CalendarEventDraft> get copyWith => _$CalendarEventDraftCopyWithImpl<CalendarEventDraft>(this as CalendarEventDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.reminderBefore, reminderBefore) || other.reminderBefore == reminderBefore));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,start,end,isAllDay,reminderBefore);

@override
String toString() {
  return 'CalendarEventDraft(title: $title, description: $description, start: $start, end: $end, isAllDay: $isAllDay, reminderBefore: $reminderBefore)';
}


}

/// @nodoc
abstract mixin class $CalendarEventDraftCopyWith<$Res>  {
  factory $CalendarEventDraftCopyWith(CalendarEventDraft value, $Res Function(CalendarEventDraft) _then) = _$CalendarEventDraftCopyWithImpl;
@useResult
$Res call({
 String title, String? description, DateTime start, DateTime end, bool isAllDay, Duration? reminderBefore
});




}
/// @nodoc
class _$CalendarEventDraftCopyWithImpl<$Res>
    implements $CalendarEventDraftCopyWith<$Res> {
  _$CalendarEventDraftCopyWithImpl(this._self, this._then);

  final CalendarEventDraft _self;
  final $Res Function(CalendarEventDraft) _then;

/// Create a copy of CalendarEventDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? start = null,Object? end = null,Object? isAllDay = null,Object? reminderBefore = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,reminderBefore: freezed == reminderBefore ? _self.reminderBefore : reminderBefore // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEventDraft].
extension CalendarEventDraftPatterns on CalendarEventDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEventDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEventDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEventDraft value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEventDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEventDraft value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEventDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime start,  DateTime end,  bool isAllDay,  Duration? reminderBefore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEventDraft() when $default != null:
return $default(_that.title,_that.description,_that.start,_that.end,_that.isAllDay,_that.reminderBefore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime start,  DateTime end,  bool isAllDay,  Duration? reminderBefore)  $default,) {final _that = this;
switch (_that) {
case _CalendarEventDraft():
return $default(_that.title,_that.description,_that.start,_that.end,_that.isAllDay,_that.reminderBefore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  DateTime start,  DateTime end,  bool isAllDay,  Duration? reminderBefore)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEventDraft() when $default != null:
return $default(_that.title,_that.description,_that.start,_that.end,_that.isAllDay,_that.reminderBefore);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarEventDraft implements CalendarEventDraft {
  const _CalendarEventDraft({required this.title, this.description, required this.start, required this.end, required this.isAllDay, this.reminderBefore});
  

@override final  String title;
@override final  String? description;
@override final  DateTime start;
@override final  DateTime end;
@override final  bool isAllDay;
@override final  Duration? reminderBefore;

/// Create a copy of CalendarEventDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventDraftCopyWith<_CalendarEventDraft> get copyWith => __$CalendarEventDraftCopyWithImpl<_CalendarEventDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.isAllDay, isAllDay) || other.isAllDay == isAllDay)&&(identical(other.reminderBefore, reminderBefore) || other.reminderBefore == reminderBefore));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,start,end,isAllDay,reminderBefore);

@override
String toString() {
  return 'CalendarEventDraft(title: $title, description: $description, start: $start, end: $end, isAllDay: $isAllDay, reminderBefore: $reminderBefore)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventDraftCopyWith<$Res> implements $CalendarEventDraftCopyWith<$Res> {
  factory _$CalendarEventDraftCopyWith(_CalendarEventDraft value, $Res Function(_CalendarEventDraft) _then) = __$CalendarEventDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, DateTime start, DateTime end, bool isAllDay, Duration? reminderBefore
});




}
/// @nodoc
class __$CalendarEventDraftCopyWithImpl<$Res>
    implements _$CalendarEventDraftCopyWith<$Res> {
  __$CalendarEventDraftCopyWithImpl(this._self, this._then);

  final _CalendarEventDraft _self;
  final $Res Function(_CalendarEventDraft) _then;

/// Create a copy of CalendarEventDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? start = null,Object? end = null,Object? isAllDay = null,Object? reminderBefore = freezed,}) {
  return _then(_CalendarEventDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,isAllDay: null == isAllDay ? _self.isAllDay : isAllDay // ignore: cast_nullable_to_non_nullable
as bool,reminderBefore: freezed == reminderBefore ? _self.reminderBefore : reminderBefore // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
