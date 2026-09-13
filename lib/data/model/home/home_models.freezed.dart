// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveBalanceDto {

 String get employeeCode; int get annualRemaining; int get annualTotal; int get sickRemaining;
/// Create a copy of LeaveBalanceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceDtoCopyWith<LeaveBalanceDto> get copyWith => _$LeaveBalanceDtoCopyWithImpl<LeaveBalanceDto>(this as LeaveBalanceDto, _$identity);

  /// Serializes this LeaveBalanceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceDto&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.annualRemaining, annualRemaining) || other.annualRemaining == annualRemaining)&&(identical(other.annualTotal, annualTotal) || other.annualTotal == annualTotal)&&(identical(other.sickRemaining, sickRemaining) || other.sickRemaining == sickRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeCode,annualRemaining,annualTotal,sickRemaining);

@override
String toString() {
  return 'LeaveBalanceDto(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceDtoCopyWith<$Res>  {
  factory $LeaveBalanceDtoCopyWith(LeaveBalanceDto value, $Res Function(LeaveBalanceDto) _then) = _$LeaveBalanceDtoCopyWithImpl;
@useResult
$Res call({
 String employeeCode, int annualRemaining, int annualTotal, int sickRemaining
});




}
/// @nodoc
class _$LeaveBalanceDtoCopyWithImpl<$Res>
    implements $LeaveBalanceDtoCopyWith<$Res> {
  _$LeaveBalanceDtoCopyWithImpl(this._self, this._then);

  final LeaveBalanceDto _self;
  final $Res Function(LeaveBalanceDto) _then;

/// Create a copy of LeaveBalanceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeCode = null,Object? annualRemaining = null,Object? annualTotal = null,Object? sickRemaining = null,}) {
  return _then(_self.copyWith(
employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,annualRemaining: null == annualRemaining ? _self.annualRemaining : annualRemaining // ignore: cast_nullable_to_non_nullable
as int,annualTotal: null == annualTotal ? _self.annualTotal : annualTotal // ignore: cast_nullable_to_non_nullable
as int,sickRemaining: null == sickRemaining ? _self.sickRemaining : sickRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBalanceDto].
extension LeaveBalanceDtoPatterns on LeaveBalanceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalanceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalanceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalanceDto value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalanceDto value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String employeeCode,  int annualRemaining,  int annualTotal,  int sickRemaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceDto() when $default != null:
return $default(_that.employeeCode,_that.annualRemaining,_that.annualTotal,_that.sickRemaining);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String employeeCode,  int annualRemaining,  int annualTotal,  int sickRemaining)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceDto():
return $default(_that.employeeCode,_that.annualRemaining,_that.annualTotal,_that.sickRemaining);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String employeeCode,  int annualRemaining,  int annualTotal,  int sickRemaining)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceDto() when $default != null:
return $default(_that.employeeCode,_that.annualRemaining,_that.annualTotal,_that.sickRemaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalanceDto implements LeaveBalanceDto {
  const _LeaveBalanceDto({required this.employeeCode, required this.annualRemaining, required this.annualTotal, required this.sickRemaining});
  factory _LeaveBalanceDto.fromJson(Map<String, dynamic> json) => _$LeaveBalanceDtoFromJson(json);

@override final  String employeeCode;
@override final  int annualRemaining;
@override final  int annualTotal;
@override final  int sickRemaining;

/// Create a copy of LeaveBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceDtoCopyWith<_LeaveBalanceDto> get copyWith => __$LeaveBalanceDtoCopyWithImpl<_LeaveBalanceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveBalanceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceDto&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.annualRemaining, annualRemaining) || other.annualRemaining == annualRemaining)&&(identical(other.annualTotal, annualTotal) || other.annualTotal == annualTotal)&&(identical(other.sickRemaining, sickRemaining) || other.sickRemaining == sickRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeCode,annualRemaining,annualTotal,sickRemaining);

@override
String toString() {
  return 'LeaveBalanceDto(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceDtoCopyWith<$Res> implements $LeaveBalanceDtoCopyWith<$Res> {
  factory _$LeaveBalanceDtoCopyWith(_LeaveBalanceDto value, $Res Function(_LeaveBalanceDto) _then) = __$LeaveBalanceDtoCopyWithImpl;
@override @useResult
$Res call({
 String employeeCode, int annualRemaining, int annualTotal, int sickRemaining
});




}
/// @nodoc
class __$LeaveBalanceDtoCopyWithImpl<$Res>
    implements _$LeaveBalanceDtoCopyWith<$Res> {
  __$LeaveBalanceDtoCopyWithImpl(this._self, this._then);

  final _LeaveBalanceDto _self;
  final $Res Function(_LeaveBalanceDto) _then;

/// Create a copy of LeaveBalanceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeCode = null,Object? annualRemaining = null,Object? annualTotal = null,Object? sickRemaining = null,}) {
  return _then(_LeaveBalanceDto(
employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,annualRemaining: null == annualRemaining ? _self.annualRemaining : annualRemaining // ignore: cast_nullable_to_non_nullable
as int,annualTotal: null == annualTotal ? _self.annualTotal : annualTotal // ignore: cast_nullable_to_non_nullable
as int,sickRemaining: null == sickRemaining ? _self.sickRemaining : sickRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BusinessTripDto {

// ignore: invalid_annotation_target
@JsonKey(name: '_id') String? get mongoId; String? get id; String get employeeCode; String get destination; String get from; String get to; String get purpose; String get status; String? get createdAt; String? get updatedAt;
/// Create a copy of BusinessTripDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessTripDtoCopyWith<BusinessTripDto> get copyWith => _$BusinessTripDtoCopyWithImpl<BusinessTripDto>(this as BusinessTripDto, _$identity);

  /// Serializes this BusinessTripDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessTripDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,destination,from,to,purpose,status,createdAt,updatedAt);

@override
String toString() {
  return 'BusinessTripDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BusinessTripDtoCopyWith<$Res>  {
  factory $BusinessTripDtoCopyWith(BusinessTripDto value, $Res Function(BusinessTripDto) _then) = _$BusinessTripDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String destination, String from, String to, String purpose, String status, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$BusinessTripDtoCopyWithImpl<$Res>
    implements $BusinessTripDtoCopyWith<$Res> {
  _$BusinessTripDtoCopyWithImpl(this._self, this._then);

  final BusinessTripDto _self;
  final $Res Function(BusinessTripDto) _then;

/// Create a copy of BusinessTripDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessTripDto].
extension BusinessTripDtoPatterns on BusinessTripDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessTripDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessTripDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessTripDto value)  $default,){
final _that = this;
switch (_that) {
case _BusinessTripDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessTripDto value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessTripDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessTripDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BusinessTripDto():
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? mongoId,  String? id,  String employeeCode,  String destination,  String from,  String to,  String purpose,  String status,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BusinessTripDto() when $default != null:
return $default(_that.mongoId,_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessTripDto implements BusinessTripDto {
  const _BusinessTripDto({@JsonKey(name: '_id') this.mongoId, this.id, required this.employeeCode, required this.destination, required this.from, required this.to, required this.purpose, required this.status, this.createdAt, this.updatedAt});
  factory _BusinessTripDto.fromJson(Map<String, dynamic> json) => _$BusinessTripDtoFromJson(json);

// ignore: invalid_annotation_target
@override@JsonKey(name: '_id') final  String? mongoId;
@override final  String? id;
@override final  String employeeCode;
@override final  String destination;
@override final  String from;
@override final  String to;
@override final  String purpose;
@override final  String status;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of BusinessTripDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessTripDtoCopyWith<_BusinessTripDto> get copyWith => __$BusinessTripDtoCopyWithImpl<_BusinessTripDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessTripDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessTripDto&&(identical(other.mongoId, mongoId) || other.mongoId == mongoId)&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mongoId,id,employeeCode,destination,from,to,purpose,status,createdAt,updatedAt);

@override
String toString() {
  return 'BusinessTripDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessTripDtoCopyWith<$Res> implements $BusinessTripDtoCopyWith<$Res> {
  factory _$BusinessTripDtoCopyWith(_BusinessTripDto value, $Res Function(_BusinessTripDto) _then) = __$BusinessTripDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? mongoId, String? id, String employeeCode, String destination, String from, String to, String purpose, String status, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$BusinessTripDtoCopyWithImpl<$Res>
    implements _$BusinessTripDtoCopyWith<$Res> {
  __$BusinessTripDtoCopyWithImpl(this._self, this._then);

  final _BusinessTripDto _self;
  final $Res Function(_BusinessTripDto) _then;

/// Create a copy of BusinessTripDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mongoId = freezed,Object? id = freezed,Object? employeeCode = null,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BusinessTripDto(
mongoId: freezed == mongoId ? _self.mongoId : mongoId // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
