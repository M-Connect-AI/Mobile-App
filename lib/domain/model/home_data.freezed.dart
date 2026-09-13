// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveBalance {

 String get employeeCode; int get annualRemaining; int get annualTotal; int get sickRemaining;
/// Create a copy of LeaveBalance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceCopyWith<LeaveBalance> get copyWith => _$LeaveBalanceCopyWithImpl<LeaveBalance>(this as LeaveBalance, _$identity);

  /// Serializes this LeaveBalance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalance&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.annualRemaining, annualRemaining) || other.annualRemaining == annualRemaining)&&(identical(other.annualTotal, annualTotal) || other.annualTotal == annualTotal)&&(identical(other.sickRemaining, sickRemaining) || other.sickRemaining == sickRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeCode,annualRemaining,annualTotal,sickRemaining);

@override
String toString() {
  return 'LeaveBalance(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceCopyWith<$Res>  {
  factory $LeaveBalanceCopyWith(LeaveBalance value, $Res Function(LeaveBalance) _then) = _$LeaveBalanceCopyWithImpl;
@useResult
$Res call({
 String employeeCode, int annualRemaining, int annualTotal, int sickRemaining
});




}
/// @nodoc
class _$LeaveBalanceCopyWithImpl<$Res>
    implements $LeaveBalanceCopyWith<$Res> {
  _$LeaveBalanceCopyWithImpl(this._self, this._then);

  final LeaveBalance _self;
  final $Res Function(LeaveBalance) _then;

/// Create a copy of LeaveBalance
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


/// Adds pattern-matching-related methods to [LeaveBalance].
extension LeaveBalancePatterns on LeaveBalance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalance value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalance value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalance() when $default != null:
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
case _LeaveBalance() when $default != null:
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
case _LeaveBalance():
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
case _LeaveBalance() when $default != null:
return $default(_that.employeeCode,_that.annualRemaining,_that.annualTotal,_that.sickRemaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalance implements LeaveBalance {
  const _LeaveBalance({required this.employeeCode, required this.annualRemaining, required this.annualTotal, required this.sickRemaining});
  factory _LeaveBalance.fromJson(Map<String, dynamic> json) => _$LeaveBalanceFromJson(json);

@override final  String employeeCode;
@override final  int annualRemaining;
@override final  int annualTotal;
@override final  int sickRemaining;

/// Create a copy of LeaveBalance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceCopyWith<_LeaveBalance> get copyWith => __$LeaveBalanceCopyWithImpl<_LeaveBalance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveBalanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalance&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.annualRemaining, annualRemaining) || other.annualRemaining == annualRemaining)&&(identical(other.annualTotal, annualTotal) || other.annualTotal == annualTotal)&&(identical(other.sickRemaining, sickRemaining) || other.sickRemaining == sickRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeCode,annualRemaining,annualTotal,sickRemaining);

@override
String toString() {
  return 'LeaveBalance(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceCopyWith<$Res> implements $LeaveBalanceCopyWith<$Res> {
  factory _$LeaveBalanceCopyWith(_LeaveBalance value, $Res Function(_LeaveBalance) _then) = __$LeaveBalanceCopyWithImpl;
@override @useResult
$Res call({
 String employeeCode, int annualRemaining, int annualTotal, int sickRemaining
});




}
/// @nodoc
class __$LeaveBalanceCopyWithImpl<$Res>
    implements _$LeaveBalanceCopyWith<$Res> {
  __$LeaveBalanceCopyWithImpl(this._self, this._then);

  final _LeaveBalance _self;
  final $Res Function(_LeaveBalance) _then;

/// Create a copy of LeaveBalance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeCode = null,Object? annualRemaining = null,Object? annualTotal = null,Object? sickRemaining = null,}) {
  return _then(_LeaveBalance(
employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,annualRemaining: null == annualRemaining ? _self.annualRemaining : annualRemaining // ignore: cast_nullable_to_non_nullable
as int,annualTotal: null == annualTotal ? _self.annualTotal : annualTotal // ignore: cast_nullable_to_non_nullable
as int,sickRemaining: null == sickRemaining ? _self.sickRemaining : sickRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BusinessTrip {

 String get id; String get employeeCode; String get destination; DateTime get from; DateTime get to; String get purpose; RequestStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of BusinessTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessTripCopyWith<BusinessTrip> get copyWith => _$BusinessTripCopyWithImpl<BusinessTrip>(this as BusinessTrip, _$identity);

  /// Serializes this BusinessTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,destination,from,to,purpose,status,createdAt,updatedAt);

@override
String toString() {
  return 'BusinessTrip(id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BusinessTripCopyWith<$Res>  {
  factory $BusinessTripCopyWith(BusinessTrip value, $Res Function(BusinessTrip) _then) = _$BusinessTripCopyWithImpl;
@useResult
$Res call({
 String id, String employeeCode, String destination, DateTime from, DateTime to, String purpose, RequestStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$BusinessTripCopyWithImpl<$Res>
    implements $BusinessTripCopyWith<$Res> {
  _$BusinessTripCopyWithImpl(this._self, this._then);

  final BusinessTrip _self;
  final $Res Function(BusinessTrip) _then;

/// Create a copy of BusinessTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeCode = null,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessTrip].
extension BusinessTripPatterns on BusinessTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessTrip value)  $default,){
final _that = this;
switch (_that) {
case _BusinessTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessTrip value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String employeeCode,  String destination,  DateTime from,  DateTime to,  String purpose,  RequestStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessTrip() when $default != null:
return $default(_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String employeeCode,  String destination,  DateTime from,  DateTime to,  String purpose,  RequestStatus status,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BusinessTrip():
return $default(_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String employeeCode,  String destination,  DateTime from,  DateTime to,  String purpose,  RequestStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BusinessTrip() when $default != null:
return $default(_that.id,_that.employeeCode,_that.destination,_that.from,_that.to,_that.purpose,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessTrip implements BusinessTrip {
  const _BusinessTrip({required this.id, required this.employeeCode, required this.destination, required this.from, required this.to, required this.purpose, required this.status, this.createdAt, this.updatedAt});
  factory _BusinessTrip.fromJson(Map<String, dynamic> json) => _$BusinessTripFromJson(json);

@override final  String id;
@override final  String employeeCode;
@override final  String destination;
@override final  DateTime from;
@override final  DateTime to;
@override final  String purpose;
@override final  RequestStatus status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of BusinessTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessTripCopyWith<_BusinessTrip> get copyWith => __$BusinessTripCopyWithImpl<_BusinessTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessTripToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,employeeCode,destination,from,to,purpose,status,createdAt,updatedAt);

@override
String toString() {
  return 'BusinessTrip(id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessTripCopyWith<$Res> implements $BusinessTripCopyWith<$Res> {
  factory _$BusinessTripCopyWith(_BusinessTrip value, $Res Function(_BusinessTrip) _then) = __$BusinessTripCopyWithImpl;
@override @useResult
$Res call({
 String id, String employeeCode, String destination, DateTime from, DateTime to, String purpose, RequestStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$BusinessTripCopyWithImpl<$Res>
    implements _$BusinessTripCopyWith<$Res> {
  __$BusinessTripCopyWithImpl(this._self, this._then);

  final _BusinessTrip _self;
  final $Res Function(_BusinessTrip) _then;

/// Create a copy of BusinessTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeCode = null,Object? destination = null,Object? from = null,Object? to = null,Object? purpose = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BusinessTrip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$HomeData {

 AuthUser get user; LeaveBalance get leaveBalance; List<BusinessTrip> get upcomingTrips;
/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeDataCopyWith<HomeData> get copyWith => _$HomeDataCopyWithImpl<HomeData>(this as HomeData, _$identity);

  /// Serializes this HomeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeData&&(identical(other.user, user) || other.user == user)&&(identical(other.leaveBalance, leaveBalance) || other.leaveBalance == leaveBalance)&&const DeepCollectionEquality().equals(other.upcomingTrips, upcomingTrips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,leaveBalance,const DeepCollectionEquality().hash(upcomingTrips));

@override
String toString() {
  return 'HomeData(user: $user, leaveBalance: $leaveBalance, upcomingTrips: $upcomingTrips)';
}


}

/// @nodoc
abstract mixin class $HomeDataCopyWith<$Res>  {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) _then) = _$HomeDataCopyWithImpl;
@useResult
$Res call({
 AuthUser user, LeaveBalance leaveBalance, List<BusinessTrip> upcomingTrips
});


$AuthUserCopyWith<$Res> get user;$LeaveBalanceCopyWith<$Res> get leaveBalance;

}
/// @nodoc
class _$HomeDataCopyWithImpl<$Res>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._self, this._then);

  final HomeData _self;
  final $Res Function(HomeData) _then;

/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? leaveBalance = null,Object? upcomingTrips = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,leaveBalance: null == leaveBalance ? _self.leaveBalance : leaveBalance // ignore: cast_nullable_to_non_nullable
as LeaveBalance,upcomingTrips: null == upcomingTrips ? _self.upcomingTrips : upcomingTrips // ignore: cast_nullable_to_non_nullable
as List<BusinessTrip>,
  ));
}
/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBalanceCopyWith<$Res> get leaveBalance {
  
  return $LeaveBalanceCopyWith<$Res>(_self.leaveBalance, (value) {
    return _then(_self.copyWith(leaveBalance: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeData].
extension HomeDataPatterns on HomeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeData value)  $default,){
final _that = this;
switch (_that) {
case _HomeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthUser user,  LeaveBalance leaveBalance,  List<BusinessTrip> upcomingTrips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeData() when $default != null:
return $default(_that.user,_that.leaveBalance,_that.upcomingTrips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthUser user,  LeaveBalance leaveBalance,  List<BusinessTrip> upcomingTrips)  $default,) {final _that = this;
switch (_that) {
case _HomeData():
return $default(_that.user,_that.leaveBalance,_that.upcomingTrips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthUser user,  LeaveBalance leaveBalance,  List<BusinessTrip> upcomingTrips)?  $default,) {final _that = this;
switch (_that) {
case _HomeData() when $default != null:
return $default(_that.user,_that.leaveBalance,_that.upcomingTrips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeData implements HomeData {
  const _HomeData({required this.user, required this.leaveBalance, required final  List<BusinessTrip> upcomingTrips}): _upcomingTrips = upcomingTrips;
  factory _HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);

@override final  AuthUser user;
@override final  LeaveBalance leaveBalance;
 final  List<BusinessTrip> _upcomingTrips;
@override List<BusinessTrip> get upcomingTrips {
  if (_upcomingTrips is EqualUnmodifiableListView) return _upcomingTrips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingTrips);
}


/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeDataCopyWith<_HomeData> get copyWith => __$HomeDataCopyWithImpl<_HomeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeData&&(identical(other.user, user) || other.user == user)&&(identical(other.leaveBalance, leaveBalance) || other.leaveBalance == leaveBalance)&&const DeepCollectionEquality().equals(other._upcomingTrips, _upcomingTrips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,leaveBalance,const DeepCollectionEquality().hash(_upcomingTrips));

@override
String toString() {
  return 'HomeData(user: $user, leaveBalance: $leaveBalance, upcomingTrips: $upcomingTrips)';
}


}

/// @nodoc
abstract mixin class _$HomeDataCopyWith<$Res> implements $HomeDataCopyWith<$Res> {
  factory _$HomeDataCopyWith(_HomeData value, $Res Function(_HomeData) _then) = __$HomeDataCopyWithImpl;
@override @useResult
$Res call({
 AuthUser user, LeaveBalance leaveBalance, List<BusinessTrip> upcomingTrips
});


@override $AuthUserCopyWith<$Res> get user;@override $LeaveBalanceCopyWith<$Res> get leaveBalance;

}
/// @nodoc
class __$HomeDataCopyWithImpl<$Res>
    implements _$HomeDataCopyWith<$Res> {
  __$HomeDataCopyWithImpl(this._self, this._then);

  final _HomeData _self;
  final $Res Function(_HomeData) _then;

/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? leaveBalance = null,Object? upcomingTrips = null,}) {
  return _then(_HomeData(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,leaveBalance: null == leaveBalance ? _self.leaveBalance : leaveBalance // ignore: cast_nullable_to_non_nullable
as LeaveBalance,upcomingTrips: null == upcomingTrips ? _self._upcomingTrips : upcomingTrips // ignore: cast_nullable_to_non_nullable
as List<BusinessTrip>,
  ));
}

/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of HomeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBalanceCopyWith<$Res> get leaveBalance {
  
  return $LeaveBalanceCopyWith<$Res>(_self.leaveBalance, (value) {
    return _then(_self.copyWith(leaveBalance: value));
  });
}
}

// dart format on
