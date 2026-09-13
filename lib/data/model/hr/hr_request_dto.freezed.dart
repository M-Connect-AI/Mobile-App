// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hr_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveRequestDto {

// ignore: invalid_annotation_target
@JsonKey(name: '_id') String? get mongoId; String? get id; String get employeeCode; String? get employeeName; String get type; String get from; String get to; int get days; String get reason; String get status; String? get createdAt;
/// Create a copy of LeaveRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveRequestDtoCopyWith<LeaveRequestDto> get copyWith => _$LeaveRequestDtoCopyWithImpl<LeaveRequestDto>(this as LeaveRequestDto, _$identity);

  /// Serializes this LeaveRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveRequestDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.type, type) || other.type == type)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.days, days) || other.days == days)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,employeeName,type,from,to,days,reason,status,createdAt);

@override
String toString() {
  return 'LeaveRequestDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, employeeName: $employeeName, type: $type, from: $from, to: $to, days: $days, reason: $reason, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LeaveRequestDtoCopyWith<$Res>  {
  factory $LeaveRequestDtoCopyWith(LeaveRequestDto value, $Res Function(LeaveRequestDto) _then) = _$LeaveRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String? employeeName, String type, String from, String to, int days, String reason, String status, String? createdAt
});




}
/// @nodoc
class _$LeaveRequestDtoCopyWithImpl<$Res>
    implements $LeaveRequestDtoCopyWith<$Res> {
  _$LeaveRequestDtoCopyWithImpl(this._self, this._then);

  final LeaveRequestDto _self;
  final $Res Function(LeaveRequestDto) _then;

/// Create a copy of LeaveRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? employeeName = freezed,Object? type = null,Object? from = null,Object? to = null,Object? days = null,Object? reason = null,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveRequestDto].
extension LeaveRequestDtoPatterns on LeaveRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String type,  String from,  String to,  int days,  String reason,  String status,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveRequestDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.type,_that.from,_that.to,_that.days,_that.reason,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String type,  String from,  String to,  int days,  String reason,  String status,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestDto():
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.type,_that.from,_that.to,_that.days,_that.reason,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String type,  String from,  String to,  int days,  String reason,  String status,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LeaveRequestDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.type,_that.from,_that.to,_that.days,_that.reason,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveRequestDto implements LeaveRequestDto {
  const _LeaveRequestDto({@JsonKey(name: '_id') this.mongoId, this.id, required this.employeeCode, this.employeeName, required this.type, required this.from, required this.to, required this.days, required this.reason, required this.status, this.createdAt});
  factory _LeaveRequestDto.fromJson(Map<String, dynamic> json) => _$LeaveRequestDtoFromJson(json);

// ignore: invalid_annotation_target
@override@JsonKey(name: '_id') final  String? mongoId;
@override final  String? id;
@override final  String employeeCode;
@override final  String? employeeName;
@override final  String type;
@override final  String from;
@override final  String to;
@override final  int days;
@override final  String reason;
@override final  String status;
@override final  String? createdAt;

/// Create a copy of LeaveRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveRequestDtoCopyWith<_LeaveRequestDto> get copyWith => __$LeaveRequestDtoCopyWithImpl<_LeaveRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveRequestDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.type, type) || other.type == type)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.days, days) || other.days == days)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,employeeName,type,from,to,days,reason,status,createdAt);

@override
String toString() {
  return 'LeaveRequestDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, employeeName: $employeeName, type: $type, from: $from, to: $to, days: $days, reason: $reason, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LeaveRequestDtoCopyWith<$Res> implements $LeaveRequestDtoCopyWith<$Res> {
  factory _$LeaveRequestDtoCopyWith(_LeaveRequestDto value, $Res Function(_LeaveRequestDto) _then) = __$LeaveRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String? employeeName, String type, String from, String to, int days, String reason, String status, String? createdAt
});




}
/// @nodoc
class __$LeaveRequestDtoCopyWithImpl<$Res>
    implements _$LeaveRequestDtoCopyWith<$Res> {
  __$LeaveRequestDtoCopyWithImpl(this._self, this._then);

  final _LeaveRequestDto _self;
  final $Res Function(_LeaveRequestDto) _then;

/// Create a copy of LeaveRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? employeeName = freezed,Object? type = null,Object? from = null,Object? to = null,Object? days = null,Object? reason = null,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_LeaveRequestDto(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripRequestDto {

// ignore: invalid_annotation_target
@JsonKey(name: '_id') String? get mongoId; String? get id; String get employeeCode; String? get employeeName; String get destination; String get from; String get to; String get purpose; String get status; String? get createdAt;
/// Create a copy of TripRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripRequestDtoCopyWith<TripRequestDto> get copyWith => _$TripRequestDtoCopyWithImpl<TripRequestDto>(this as TripRequestDto, _$identity);

  /// Serializes this TripRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripRequestDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,employeeName,destination,from,to,purpose,status,createdAt);

@override
String toString() {
  return 'TripRequestDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, employeeName: $employeeName, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TripRequestDtoCopyWith<$Res>  {
  factory $TripRequestDtoCopyWith(TripRequestDto value, $Res Function(TripRequestDto) _then) = _$TripRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String? employeeName, String destination, String from, String to, String purpose, String status, String? createdAt
});




}
/// @nodoc
class _$TripRequestDtoCopyWithImpl<$Res>
    implements $TripRequestDtoCopyWith<$Res> {
  _$TripRequestDtoCopyWithImpl(this._self, this._then);

  final TripRequestDto _self;
  final $Res Function(TripRequestDto) _then;

/// Create a copy of TripRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? employeeName = freezed,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripRequestDto].
extension TripRequestDtoPatterns on TripRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _TripRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _TripRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripRequestDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TripRequestDto():
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String? employeeName,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TripRequestDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.employeeName,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripRequestDto implements TripRequestDto {
  const _TripRequestDto({@JsonKey(name: '_id') this.mongoId, this.id, required this.employeeCode, this.employeeName, required this.destination, required this.from, required this.to, required this.purpose, required this.status, this.createdAt});
  factory _TripRequestDto.fromJson(Map<String, dynamic> json) => _$TripRequestDtoFromJson(json);

// ignore: invalid_annotation_target
@override@JsonKey(name: '_id') final  String? mongoId;
@override final  String? id;
@override final  String employeeCode;
@override final  String? employeeName;
@override final  String destination;
@override final  String from;
@override final  String to;
@override final  String purpose;
@override final  String status;
@override final  String? createdAt;

/// Create a copy of TripRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripRequestDtoCopyWith<_TripRequestDto> get copyWith => __$TripRequestDtoCopyWithImpl<_TripRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripRequestDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,employeeName,destination,from,to,purpose,status,createdAt);

@override
String toString() {
  return 'TripRequestDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, employeeName: $employeeName, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TripRequestDtoCopyWith<$Res> implements $TripRequestDtoCopyWith<$Res> {
  factory _$TripRequestDtoCopyWith(_TripRequestDto value, $Res Function(_TripRequestDto) _then) = __$TripRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String? employeeName, String destination, String from, String to, String purpose, String status, String? createdAt
});




}
/// @nodoc
class __$TripRequestDtoCopyWithImpl<$Res>
    implements _$TripRequestDtoCopyWith<$Res> {
  __$TripRequestDtoCopyWithImpl(this._self, this._then);

  final _TripRequestDto _self;
  final $Res Function(_TripRequestDto) _then;

/// Create a copy of TripRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? employeeName = freezed,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,}) {
  return _then(_TripRequestDto(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,employeeName: freezed == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String?,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
