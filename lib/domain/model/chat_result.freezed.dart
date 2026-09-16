// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingApprovals {

 List<LeaveRequest> get leaves; List<TripRequest> get trips;
/// Create a copy of PendingApprovals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingApprovalsCopyWith<PendingApprovals> get copyWith => _$PendingApprovalsCopyWithImpl<PendingApprovals>(this as PendingApprovals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingApprovals&&const DeepCollectionEquality().equals(other.leaves, leaves)&&const DeepCollectionEquality().equals(other.trips, trips));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leaves),const DeepCollectionEquality().hash(trips));

@override
String toString() {
  return 'PendingApprovals(leaves: $leaves, trips: $trips)';
}


}

/// @nodoc
abstract mixin class $PendingApprovalsCopyWith<$Res>  {
  factory $PendingApprovalsCopyWith(PendingApprovals value, $Res Function(PendingApprovals) _then) = _$PendingApprovalsCopyWithImpl;
@useResult
$Res call({
 List<LeaveRequest> leaves, List<TripRequest> trips
});




}
/// @nodoc
class _$PendingApprovalsCopyWithImpl<$Res>
    implements $PendingApprovalsCopyWith<$Res> {
  _$PendingApprovalsCopyWithImpl(this._self, this._then);

  final PendingApprovals _self;
  final $Res Function(PendingApprovals) _then;

/// Create a copy of PendingApprovals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaves = null,Object? trips = null,}) {
  return _then(_self.copyWith(
leaves: null == leaves ? _self.leaves : leaves // ignore: cast_nullable_to_non_nullable
as List<LeaveRequest>,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingApprovals].
extension PendingApprovalsPatterns on PendingApprovals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingApprovals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingApprovals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingApprovals value)  $default,){
final _that = this;
switch (_that) {
case _PendingApprovals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingApprovals value)?  $default,){
final _that = this;
switch (_that) {
case _PendingApprovals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaveRequest> leaves,  List<TripRequest> trips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingApprovals() when $default != null:
return $default(_that.leaves,_that.trips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaveRequest> leaves,  List<TripRequest> trips)  $default,) {final _that = this;
switch (_that) {
case _PendingApprovals():
return $default(_that.leaves,_that.trips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaveRequest> leaves,  List<TripRequest> trips)?  $default,) {final _that = this;
switch (_that) {
case _PendingApprovals() when $default != null:
return $default(_that.leaves,_that.trips);case _:
  return null;

}
}

}

/// @nodoc


class _PendingApprovals implements PendingApprovals {
  const _PendingApprovals({required final  List<LeaveRequest> leaves, required final  List<TripRequest> trips}): _leaves = leaves,_trips = trips;
  

 final  List<LeaveRequest> _leaves;
@override List<LeaveRequest> get leaves {
  if (_leaves is EqualUnmodifiableListView) return _leaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaves);
}

 final  List<TripRequest> _trips;
@override List<TripRequest> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}


/// Create a copy of PendingApprovals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingApprovalsCopyWith<_PendingApprovals> get copyWith => __$PendingApprovalsCopyWithImpl<_PendingApprovals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingApprovals&&const DeepCollectionEquality().equals(other._leaves, _leaves)&&const DeepCollectionEquality().equals(other._trips, _trips));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leaves),const DeepCollectionEquality().hash(_trips));

@override
String toString() {
  return 'PendingApprovals(leaves: $leaves, trips: $trips)';
}


}

/// @nodoc
abstract mixin class _$PendingApprovalsCopyWith<$Res> implements $PendingApprovalsCopyWith<$Res> {
  factory _$PendingApprovalsCopyWith(_PendingApprovals value, $Res Function(_PendingApprovals) _then) = __$PendingApprovalsCopyWithImpl;
@override @useResult
$Res call({
 List<LeaveRequest> leaves, List<TripRequest> trips
});




}
/// @nodoc
class __$PendingApprovalsCopyWithImpl<$Res>
    implements _$PendingApprovalsCopyWith<$Res> {
  __$PendingApprovalsCopyWithImpl(this._self, this._then);

  final _PendingApprovals _self;
  final $Res Function(_PendingApprovals) _then;

/// Create a copy of PendingApprovals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaves = null,Object? trips = null,}) {
  return _then(_PendingApprovals(
leaves: null == leaves ? _self._leaves : leaves // ignore: cast_nullable_to_non_nullable
as List<LeaveRequest>,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<TripRequest>,
  ));
}


}

/// @nodoc
mixin _$LeaveBatchMutation {

 int get count; List<LeaveRequest> get items;
/// Create a copy of LeaveBatchMutation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBatchMutationCopyWith<LeaveBatchMutation> get copyWith => _$LeaveBatchMutationCopyWithImpl<LeaveBatchMutation>(this as LeaveBatchMutation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBatchMutation&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'LeaveBatchMutation(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class $LeaveBatchMutationCopyWith<$Res>  {
  factory $LeaveBatchMutationCopyWith(LeaveBatchMutation value, $Res Function(LeaveBatchMutation) _then) = _$LeaveBatchMutationCopyWithImpl;
@useResult
$Res call({
 int count, List<LeaveRequest> items
});




}
/// @nodoc
class _$LeaveBatchMutationCopyWithImpl<$Res>
    implements $LeaveBatchMutationCopyWith<$Res> {
  _$LeaveBatchMutationCopyWithImpl(this._self, this._then);

  final LeaveBatchMutation _self;
  final $Res Function(LeaveBatchMutation) _then;

/// Create a copy of LeaveBatchMutation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? items = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBatchMutation].
extension LeaveBatchMutationPatterns on LeaveBatchMutation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBatchMutation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBatchMutation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBatchMutation value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBatchMutation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBatchMutation value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBatchMutation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<LeaveRequest> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBatchMutation() when $default != null:
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<LeaveRequest> items)  $default,) {final _that = this;
switch (_that) {
case _LeaveBatchMutation():
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<LeaveRequest> items)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBatchMutation() when $default != null:
return $default(_that.count,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveBatchMutation implements LeaveBatchMutation {
  const _LeaveBatchMutation({required this.count, required final  List<LeaveRequest> items}): _items = items;
  

@override final  int count;
 final  List<LeaveRequest> _items;
@override List<LeaveRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of LeaveBatchMutation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBatchMutationCopyWith<_LeaveBatchMutation> get copyWith => __$LeaveBatchMutationCopyWithImpl<_LeaveBatchMutation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBatchMutation&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'LeaveBatchMutation(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class _$LeaveBatchMutationCopyWith<$Res> implements $LeaveBatchMutationCopyWith<$Res> {
  factory _$LeaveBatchMutationCopyWith(_LeaveBatchMutation value, $Res Function(_LeaveBatchMutation) _then) = __$LeaveBatchMutationCopyWithImpl;
@override @useResult
$Res call({
 int count, List<LeaveRequest> items
});




}
/// @nodoc
class __$LeaveBatchMutationCopyWithImpl<$Res>
    implements _$LeaveBatchMutationCopyWith<$Res> {
  __$LeaveBatchMutationCopyWithImpl(this._self, this._then);

  final _LeaveBatchMutation _self;
  final $Res Function(_LeaveBatchMutation) _then;

/// Create a copy of LeaveBatchMutation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? items = null,}) {
  return _then(_LeaveBatchMutation(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LeaveRequest>,
  ));
}


}

/// @nodoc
mixin _$TripBatchMutation {

 int get count; List<TripRequest> get items;
/// Create a copy of TripBatchMutation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripBatchMutationCopyWith<TripBatchMutation> get copyWith => _$TripBatchMutationCopyWithImpl<TripBatchMutation>(this as TripBatchMutation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripBatchMutation&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'TripBatchMutation(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class $TripBatchMutationCopyWith<$Res>  {
  factory $TripBatchMutationCopyWith(TripBatchMutation value, $Res Function(TripBatchMutation) _then) = _$TripBatchMutationCopyWithImpl;
@useResult
$Res call({
 int count, List<TripRequest> items
});




}
/// @nodoc
class _$TripBatchMutationCopyWithImpl<$Res>
    implements $TripBatchMutationCopyWith<$Res> {
  _$TripBatchMutationCopyWithImpl(this._self, this._then);

  final TripBatchMutation _self;
  final $Res Function(TripBatchMutation) _then;

/// Create a copy of TripBatchMutation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? items = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripBatchMutation].
extension TripBatchMutationPatterns on TripBatchMutation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripBatchMutation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripBatchMutation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripBatchMutation value)  $default,){
final _that = this;
switch (_that) {
case _TripBatchMutation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripBatchMutation value)?  $default,){
final _that = this;
switch (_that) {
case _TripBatchMutation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<TripRequest> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripBatchMutation() when $default != null:
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<TripRequest> items)  $default,) {final _that = this;
switch (_that) {
case _TripBatchMutation():
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<TripRequest> items)?  $default,) {final _that = this;
switch (_that) {
case _TripBatchMutation() when $default != null:
return $default(_that.count,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _TripBatchMutation implements TripBatchMutation {
  const _TripBatchMutation({required this.count, required final  List<TripRequest> items}): _items = items;
  

@override final  int count;
 final  List<TripRequest> _items;
@override List<TripRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TripBatchMutation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripBatchMutationCopyWith<_TripBatchMutation> get copyWith => __$TripBatchMutationCopyWithImpl<_TripBatchMutation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripBatchMutation&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'TripBatchMutation(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TripBatchMutationCopyWith<$Res> implements $TripBatchMutationCopyWith<$Res> {
  factory _$TripBatchMutationCopyWith(_TripBatchMutation value, $Res Function(_TripBatchMutation) _then) = __$TripBatchMutationCopyWithImpl;
@override @useResult
$Res call({
 int count, List<TripRequest> items
});




}
/// @nodoc
class __$TripBatchMutationCopyWithImpl<$Res>
    implements _$TripBatchMutationCopyWith<$Res> {
  __$TripBatchMutationCopyWithImpl(this._self, this._then);

  final _TripBatchMutation _self;
  final $Res Function(_TripBatchMutation) _then;

/// Create a copy of TripBatchMutation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? items = null,}) {
  return _then(_TripBatchMutation(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripRequest>,
  ));
}


}

/// @nodoc
mixin _$JiraIssue {

 String get key; String get summary; String get status; String get statusCategory; String get priority; String get issueType; String get projectKey; String get assignee; String? get dueDate; String? get updated; String? get url;
/// Create a copy of JiraIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JiraIssueCopyWith<JiraIssue> get copyWith => _$JiraIssueCopyWithImpl<JiraIssue>(this as JiraIssue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JiraIssue&&(identical(other.key, key) || other.key == key)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusCategory, statusCategory) || other.statusCategory == statusCategory)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.issueType, issueType) || other.issueType == issueType)&&(identical(other.projectKey, projectKey) || other.projectKey == projectKey)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,key,summary,status,statusCategory,priority,issueType,projectKey,assignee,dueDate,updated,url);

@override
String toString() {
  return 'JiraIssue(key: $key, summary: $summary, status: $status, statusCategory: $statusCategory, priority: $priority, issueType: $issueType, projectKey: $projectKey, assignee: $assignee, dueDate: $dueDate, updated: $updated, url: $url)';
}


}

/// @nodoc
abstract mixin class $JiraIssueCopyWith<$Res>  {
  factory $JiraIssueCopyWith(JiraIssue value, $Res Function(JiraIssue) _then) = _$JiraIssueCopyWithImpl;
@useResult
$Res call({
 String key, String summary, String status, String statusCategory, String priority, String issueType, String projectKey, String assignee, String? dueDate, String? updated, String? url
});




}
/// @nodoc
class _$JiraIssueCopyWithImpl<$Res>
    implements $JiraIssueCopyWith<$Res> {
  _$JiraIssueCopyWithImpl(this._self, this._then);

  final JiraIssue _self;
  final $Res Function(JiraIssue) _then;

/// Create a copy of JiraIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? summary = null,Object? status = null,Object? statusCategory = null,Object? priority = null,Object? issueType = null,Object? projectKey = null,Object? assignee = null,Object? dueDate = freezed,Object? updated = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusCategory: null == statusCategory ? _self.statusCategory : statusCategory // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,issueType: null == issueType ? _self.issueType : issueType // ignore: cast_nullable_to_non_nullable
as String,projectKey: null == projectKey ? _self.projectKey : projectKey // ignore: cast_nullable_to_non_nullable
as String,assignee: null == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JiraIssue].
extension JiraIssuePatterns on JiraIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JiraIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JiraIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JiraIssue value)  $default,){
final _that = this;
switch (_that) {
case _JiraIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JiraIssue value)?  $default,){
final _that = this;
switch (_that) {
case _JiraIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String summary,  String status,  String statusCategory,  String priority,  String issueType,  String projectKey,  String assignee,  String? dueDate,  String? updated,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JiraIssue() when $default != null:
return $default(_that.key,_that.summary,_that.status,_that.statusCategory,_that.priority,_that.issueType,_that.projectKey,_that.assignee,_that.dueDate,_that.updated,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String summary,  String status,  String statusCategory,  String priority,  String issueType,  String projectKey,  String assignee,  String? dueDate,  String? updated,  String? url)  $default,) {final _that = this;
switch (_that) {
case _JiraIssue():
return $default(_that.key,_that.summary,_that.status,_that.statusCategory,_that.priority,_that.issueType,_that.projectKey,_that.assignee,_that.dueDate,_that.updated,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String summary,  String status,  String statusCategory,  String priority,  String issueType,  String projectKey,  String assignee,  String? dueDate,  String? updated,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _JiraIssue() when $default != null:
return $default(_that.key,_that.summary,_that.status,_that.statusCategory,_that.priority,_that.issueType,_that.projectKey,_that.assignee,_that.dueDate,_that.updated,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _JiraIssue implements JiraIssue {
  const _JiraIssue({required this.key, required this.summary, required this.status, required this.statusCategory, required this.priority, required this.issueType, required this.projectKey, required this.assignee, this.dueDate, this.updated, this.url});
  

@override final  String key;
@override final  String summary;
@override final  String status;
@override final  String statusCategory;
@override final  String priority;
@override final  String issueType;
@override final  String projectKey;
@override final  String assignee;
@override final  String? dueDate;
@override final  String? updated;
@override final  String? url;

/// Create a copy of JiraIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JiraIssueCopyWith<_JiraIssue> get copyWith => __$JiraIssueCopyWithImpl<_JiraIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JiraIssue&&(identical(other.key, key) || other.key == key)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusCategory, statusCategory) || other.statusCategory == statusCategory)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.issueType, issueType) || other.issueType == issueType)&&(identical(other.projectKey, projectKey) || other.projectKey == projectKey)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,key,summary,status,statusCategory,priority,issueType,projectKey,assignee,dueDate,updated,url);

@override
String toString() {
  return 'JiraIssue(key: $key, summary: $summary, status: $status, statusCategory: $statusCategory, priority: $priority, issueType: $issueType, projectKey: $projectKey, assignee: $assignee, dueDate: $dueDate, updated: $updated, url: $url)';
}


}

/// @nodoc
abstract mixin class _$JiraIssueCopyWith<$Res> implements $JiraIssueCopyWith<$Res> {
  factory _$JiraIssueCopyWith(_JiraIssue value, $Res Function(_JiraIssue) _then) = __$JiraIssueCopyWithImpl;
@override @useResult
$Res call({
 String key, String summary, String status, String statusCategory, String priority, String issueType, String projectKey, String assignee, String? dueDate, String? updated, String? url
});




}
/// @nodoc
class __$JiraIssueCopyWithImpl<$Res>
    implements _$JiraIssueCopyWith<$Res> {
  __$JiraIssueCopyWithImpl(this._self, this._then);

  final _JiraIssue _self;
  final $Res Function(_JiraIssue) _then;

/// Create a copy of JiraIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? summary = null,Object? status = null,Object? statusCategory = null,Object? priority = null,Object? issueType = null,Object? projectKey = null,Object? assignee = null,Object? dueDate = freezed,Object? updated = freezed,Object? url = freezed,}) {
  return _then(_JiraIssue(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusCategory: null == statusCategory ? _self.statusCategory : statusCategory // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,issueType: null == issueType ? _self.issueType : issueType // ignore: cast_nullable_to_non_nullable
as String,projectKey: null == projectKey ? _self.projectKey : projectKey // ignore: cast_nullable_to_non_nullable
as String,assignee: null == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as String,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$JiraStats {

 int get total; int get toDo; int get inProgress; int get done; int get unknown; int get overdue; int get stale; int get withoutDueDate; Map<String, int> get byStatus; Map<String, int> get byPriority; Map<String, int> get byIssueType; Map<String, int> get byProject;
/// Create a copy of JiraStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JiraStatsCopyWith<JiraStats> get copyWith => _$JiraStatsCopyWithImpl<JiraStats>(this as JiraStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JiraStats&&(identical(other.total, total) || other.total == total)&&(identical(other.toDo, toDo) || other.toDo == toDo)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.done, done) || other.done == done)&&(identical(other.unknown, unknown) || other.unknown == unknown)&&(identical(other.overdue, overdue) || other.overdue == overdue)&&(identical(other.stale, stale) || other.stale == stale)&&(identical(other.withoutDueDate, withoutDueDate) || other.withoutDueDate == withoutDueDate)&&const DeepCollectionEquality().equals(other.byStatus, byStatus)&&const DeepCollectionEquality().equals(other.byPriority, byPriority)&&const DeepCollectionEquality().equals(other.byIssueType, byIssueType)&&const DeepCollectionEquality().equals(other.byProject, byProject));
}


@override
int get hashCode => Object.hash(runtimeType,total,toDo,inProgress,done,unknown,overdue,stale,withoutDueDate,const DeepCollectionEquality().hash(byStatus),const DeepCollectionEquality().hash(byPriority),const DeepCollectionEquality().hash(byIssueType),const DeepCollectionEquality().hash(byProject));

@override
String toString() {
  return 'JiraStats(total: $total, toDo: $toDo, inProgress: $inProgress, done: $done, unknown: $unknown, overdue: $overdue, stale: $stale, withoutDueDate: $withoutDueDate, byStatus: $byStatus, byPriority: $byPriority, byIssueType: $byIssueType, byProject: $byProject)';
}


}

/// @nodoc
abstract mixin class $JiraStatsCopyWith<$Res>  {
  factory $JiraStatsCopyWith(JiraStats value, $Res Function(JiraStats) _then) = _$JiraStatsCopyWithImpl;
@useResult
$Res call({
 int total, int toDo, int inProgress, int done, int unknown, int overdue, int stale, int withoutDueDate, Map<String, int> byStatus, Map<String, int> byPriority, Map<String, int> byIssueType, Map<String, int> byProject
});




}
/// @nodoc
class _$JiraStatsCopyWithImpl<$Res>
    implements $JiraStatsCopyWith<$Res> {
  _$JiraStatsCopyWithImpl(this._self, this._then);

  final JiraStats _self;
  final $Res Function(JiraStats) _then;

/// Create a copy of JiraStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? toDo = null,Object? inProgress = null,Object? done = null,Object? unknown = null,Object? overdue = null,Object? stale = null,Object? withoutDueDate = null,Object? byStatus = null,Object? byPriority = null,Object? byIssueType = null,Object? byProject = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,toDo: null == toDo ? _self.toDo : toDo // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as int,withoutDueDate: null == withoutDueDate ? _self.withoutDueDate : withoutDueDate // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self.byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byPriority: null == byPriority ? _self.byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byIssueType: null == byIssueType ? _self.byIssueType : byIssueType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byProject: null == byProject ? _self.byProject : byProject // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [JiraStats].
extension JiraStatsPatterns on JiraStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JiraStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JiraStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JiraStats value)  $default,){
final _that = this;
switch (_that) {
case _JiraStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JiraStats value)?  $default,){
final _that = this;
switch (_that) {
case _JiraStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int toDo,  int inProgress,  int done,  int unknown,  int overdue,  int stale,  int withoutDueDate,  Map<String, int> byStatus,  Map<String, int> byPriority,  Map<String, int> byIssueType,  Map<String, int> byProject)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JiraStats() when $default != null:
return $default(_that.total,_that.toDo,_that.inProgress,_that.done,_that.unknown,_that.overdue,_that.stale,_that.withoutDueDate,_that.byStatus,_that.byPriority,_that.byIssueType,_that.byProject);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int toDo,  int inProgress,  int done,  int unknown,  int overdue,  int stale,  int withoutDueDate,  Map<String, int> byStatus,  Map<String, int> byPriority,  Map<String, int> byIssueType,  Map<String, int> byProject)  $default,) {final _that = this;
switch (_that) {
case _JiraStats():
return $default(_that.total,_that.toDo,_that.inProgress,_that.done,_that.unknown,_that.overdue,_that.stale,_that.withoutDueDate,_that.byStatus,_that.byPriority,_that.byIssueType,_that.byProject);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int toDo,  int inProgress,  int done,  int unknown,  int overdue,  int stale,  int withoutDueDate,  Map<String, int> byStatus,  Map<String, int> byPriority,  Map<String, int> byIssueType,  Map<String, int> byProject)?  $default,) {final _that = this;
switch (_that) {
case _JiraStats() when $default != null:
return $default(_that.total,_that.toDo,_that.inProgress,_that.done,_that.unknown,_that.overdue,_that.stale,_that.withoutDueDate,_that.byStatus,_that.byPriority,_that.byIssueType,_that.byProject);case _:
  return null;

}
}

}

/// @nodoc


class _JiraStats implements JiraStats {
  const _JiraStats({required this.total, required this.toDo, required this.inProgress, required this.done, required this.unknown, required this.overdue, required this.stale, required this.withoutDueDate, required final  Map<String, int> byStatus, required final  Map<String, int> byPriority, required final  Map<String, int> byIssueType, required final  Map<String, int> byProject}): _byStatus = byStatus,_byPriority = byPriority,_byIssueType = byIssueType,_byProject = byProject;
  

@override final  int total;
@override final  int toDo;
@override final  int inProgress;
@override final  int done;
@override final  int unknown;
@override final  int overdue;
@override final  int stale;
@override final  int withoutDueDate;
 final  Map<String, int> _byStatus;
@override Map<String, int> get byStatus {
  if (_byStatus is EqualUnmodifiableMapView) return _byStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byStatus);
}

 final  Map<String, int> _byPriority;
@override Map<String, int> get byPriority {
  if (_byPriority is EqualUnmodifiableMapView) return _byPriority;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byPriority);
}

 final  Map<String, int> _byIssueType;
@override Map<String, int> get byIssueType {
  if (_byIssueType is EqualUnmodifiableMapView) return _byIssueType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byIssueType);
}

 final  Map<String, int> _byProject;
@override Map<String, int> get byProject {
  if (_byProject is EqualUnmodifiableMapView) return _byProject;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byProject);
}


/// Create a copy of JiraStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JiraStatsCopyWith<_JiraStats> get copyWith => __$JiraStatsCopyWithImpl<_JiraStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JiraStats&&(identical(other.total, total) || other.total == total)&&(identical(other.toDo, toDo) || other.toDo == toDo)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.done, done) || other.done == done)&&(identical(other.unknown, unknown) || other.unknown == unknown)&&(identical(other.overdue, overdue) || other.overdue == overdue)&&(identical(other.stale, stale) || other.stale == stale)&&(identical(other.withoutDueDate, withoutDueDate) || other.withoutDueDate == withoutDueDate)&&const DeepCollectionEquality().equals(other._byStatus, _byStatus)&&const DeepCollectionEquality().equals(other._byPriority, _byPriority)&&const DeepCollectionEquality().equals(other._byIssueType, _byIssueType)&&const DeepCollectionEquality().equals(other._byProject, _byProject));
}


@override
int get hashCode => Object.hash(runtimeType,total,toDo,inProgress,done,unknown,overdue,stale,withoutDueDate,const DeepCollectionEquality().hash(_byStatus),const DeepCollectionEquality().hash(_byPriority),const DeepCollectionEquality().hash(_byIssueType),const DeepCollectionEquality().hash(_byProject));

@override
String toString() {
  return 'JiraStats(total: $total, toDo: $toDo, inProgress: $inProgress, done: $done, unknown: $unknown, overdue: $overdue, stale: $stale, withoutDueDate: $withoutDueDate, byStatus: $byStatus, byPriority: $byPriority, byIssueType: $byIssueType, byProject: $byProject)';
}


}

/// @nodoc
abstract mixin class _$JiraStatsCopyWith<$Res> implements $JiraStatsCopyWith<$Res> {
  factory _$JiraStatsCopyWith(_JiraStats value, $Res Function(_JiraStats) _then) = __$JiraStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, int toDo, int inProgress, int done, int unknown, int overdue, int stale, int withoutDueDate, Map<String, int> byStatus, Map<String, int> byPriority, Map<String, int> byIssueType, Map<String, int> byProject
});




}
/// @nodoc
class __$JiraStatsCopyWithImpl<$Res>
    implements _$JiraStatsCopyWith<$Res> {
  __$JiraStatsCopyWithImpl(this._self, this._then);

  final _JiraStats _self;
  final $Res Function(_JiraStats) _then;

/// Create a copy of JiraStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? toDo = null,Object? inProgress = null,Object? done = null,Object? unknown = null,Object? overdue = null,Object? stale = null,Object? withoutDueDate = null,Object? byStatus = null,Object? byPriority = null,Object? byIssueType = null,Object? byProject = null,}) {
  return _then(_JiraStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,toDo: null == toDo ? _self.toDo : toDo // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as int,withoutDueDate: null == withoutDueDate ? _self.withoutDueDate : withoutDueDate // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self._byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byPriority: null == byPriority ? _self._byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byIssueType: null == byIssueType ? _self._byIssueType : byIssueType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,byProject: null == byProject ? _self._byProject : byProject // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

/// @nodoc
mixin _$JiraIssueList {

 List<JiraIssue> get issues; JiraStats get stats; bool get mayBeTruncated;
/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JiraIssueListCopyWith<JiraIssueList> get copyWith => _$JiraIssueListCopyWithImpl<JiraIssueList>(this as JiraIssueList, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JiraIssueList&&const DeepCollectionEquality().equals(other.issues, issues)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.mayBeTruncated, mayBeTruncated) || other.mayBeTruncated == mayBeTruncated));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(issues),stats,mayBeTruncated);

@override
String toString() {
  return 'JiraIssueList(issues: $issues, stats: $stats, mayBeTruncated: $mayBeTruncated)';
}


}

/// @nodoc
abstract mixin class $JiraIssueListCopyWith<$Res>  {
  factory $JiraIssueListCopyWith(JiraIssueList value, $Res Function(JiraIssueList) _then) = _$JiraIssueListCopyWithImpl;
@useResult
$Res call({
 List<JiraIssue> issues, JiraStats stats, bool mayBeTruncated
});


$JiraStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$JiraIssueListCopyWithImpl<$Res>
    implements $JiraIssueListCopyWith<$Res> {
  _$JiraIssueListCopyWithImpl(this._self, this._then);

  final JiraIssueList _self;
  final $Res Function(JiraIssueList) _then;

/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? issues = null,Object? stats = null,Object? mayBeTruncated = null,}) {
  return _then(_self.copyWith(
issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<JiraIssue>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as JiraStats,mayBeTruncated: null == mayBeTruncated ? _self.mayBeTruncated : mayBeTruncated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JiraStatsCopyWith<$Res> get stats {
  
  return $JiraStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [JiraIssueList].
extension JiraIssueListPatterns on JiraIssueList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JiraIssueList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JiraIssueList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JiraIssueList value)  $default,){
final _that = this;
switch (_that) {
case _JiraIssueList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JiraIssueList value)?  $default,){
final _that = this;
switch (_that) {
case _JiraIssueList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<JiraIssue> issues,  JiraStats stats,  bool mayBeTruncated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JiraIssueList() when $default != null:
return $default(_that.issues,_that.stats,_that.mayBeTruncated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<JiraIssue> issues,  JiraStats stats,  bool mayBeTruncated)  $default,) {final _that = this;
switch (_that) {
case _JiraIssueList():
return $default(_that.issues,_that.stats,_that.mayBeTruncated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<JiraIssue> issues,  JiraStats stats,  bool mayBeTruncated)?  $default,) {final _that = this;
switch (_that) {
case _JiraIssueList() when $default != null:
return $default(_that.issues,_that.stats,_that.mayBeTruncated);case _:
  return null;

}
}

}

/// @nodoc


class _JiraIssueList implements JiraIssueList {
  const _JiraIssueList({required final  List<JiraIssue> issues, required this.stats, this.mayBeTruncated = false}): _issues = issues;
  

 final  List<JiraIssue> _issues;
@override List<JiraIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}

@override final  JiraStats stats;
@override@JsonKey() final  bool mayBeTruncated;

/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JiraIssueListCopyWith<_JiraIssueList> get copyWith => __$JiraIssueListCopyWithImpl<_JiraIssueList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JiraIssueList&&const DeepCollectionEquality().equals(other._issues, _issues)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.mayBeTruncated, mayBeTruncated) || other.mayBeTruncated == mayBeTruncated));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_issues),stats,mayBeTruncated);

@override
String toString() {
  return 'JiraIssueList(issues: $issues, stats: $stats, mayBeTruncated: $mayBeTruncated)';
}


}

/// @nodoc
abstract mixin class _$JiraIssueListCopyWith<$Res> implements $JiraIssueListCopyWith<$Res> {
  factory _$JiraIssueListCopyWith(_JiraIssueList value, $Res Function(_JiraIssueList) _then) = __$JiraIssueListCopyWithImpl;
@override @useResult
$Res call({
 List<JiraIssue> issues, JiraStats stats, bool mayBeTruncated
});


@override $JiraStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$JiraIssueListCopyWithImpl<$Res>
    implements _$JiraIssueListCopyWith<$Res> {
  __$JiraIssueListCopyWithImpl(this._self, this._then);

  final _JiraIssueList _self;
  final $Res Function(_JiraIssueList) _then;

/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? issues = null,Object? stats = null,Object? mayBeTruncated = null,}) {
  return _then(_JiraIssueList(
issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<JiraIssue>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as JiraStats,mayBeTruncated: null == mayBeTruncated ? _self.mayBeTruncated : mayBeTruncated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of JiraIssueList
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JiraStatsCopyWith<$Res> get stats {
  
  return $JiraStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc
mixin _$JiraCreateResult {

 String get key; String get summary; String get projectKey; String get issueType; String get assigneeEmail; String? get url; String get message;
/// Create a copy of JiraCreateResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JiraCreateResultCopyWith<JiraCreateResult> get copyWith => _$JiraCreateResultCopyWithImpl<JiraCreateResult>(this as JiraCreateResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JiraCreateResult&&(identical(other.key, key) || other.key == key)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.projectKey, projectKey) || other.projectKey == projectKey)&&(identical(other.issueType, issueType) || other.issueType == issueType)&&(identical(other.assigneeEmail, assigneeEmail) || other.assigneeEmail == assigneeEmail)&&(identical(other.url, url) || other.url == url)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,key,summary,projectKey,issueType,assigneeEmail,url,message);

@override
String toString() {
  return 'JiraCreateResult(key: $key, summary: $summary, projectKey: $projectKey, issueType: $issueType, assigneeEmail: $assigneeEmail, url: $url, message: $message)';
}


}

/// @nodoc
abstract mixin class $JiraCreateResultCopyWith<$Res>  {
  factory $JiraCreateResultCopyWith(JiraCreateResult value, $Res Function(JiraCreateResult) _then) = _$JiraCreateResultCopyWithImpl;
@useResult
$Res call({
 String key, String summary, String projectKey, String issueType, String assigneeEmail, String? url, String message
});




}
/// @nodoc
class _$JiraCreateResultCopyWithImpl<$Res>
    implements $JiraCreateResultCopyWith<$Res> {
  _$JiraCreateResultCopyWithImpl(this._self, this._then);

  final JiraCreateResult _self;
  final $Res Function(JiraCreateResult) _then;

/// Create a copy of JiraCreateResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? summary = null,Object? projectKey = null,Object? issueType = null,Object? assigneeEmail = null,Object? url = freezed,Object? message = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,projectKey: null == projectKey ? _self.projectKey : projectKey // ignore: cast_nullable_to_non_nullable
as String,issueType: null == issueType ? _self.issueType : issueType // ignore: cast_nullable_to_non_nullable
as String,assigneeEmail: null == assigneeEmail ? _self.assigneeEmail : assigneeEmail // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JiraCreateResult].
extension JiraCreateResultPatterns on JiraCreateResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JiraCreateResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JiraCreateResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JiraCreateResult value)  $default,){
final _that = this;
switch (_that) {
case _JiraCreateResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JiraCreateResult value)?  $default,){
final _that = this;
switch (_that) {
case _JiraCreateResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String summary,  String projectKey,  String issueType,  String assigneeEmail,  String? url,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JiraCreateResult() when $default != null:
return $default(_that.key,_that.summary,_that.projectKey,_that.issueType,_that.assigneeEmail,_that.url,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String summary,  String projectKey,  String issueType,  String assigneeEmail,  String? url,  String message)  $default,) {final _that = this;
switch (_that) {
case _JiraCreateResult():
return $default(_that.key,_that.summary,_that.projectKey,_that.issueType,_that.assigneeEmail,_that.url,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String summary,  String projectKey,  String issueType,  String assigneeEmail,  String? url,  String message)?  $default,) {final _that = this;
switch (_that) {
case _JiraCreateResult() when $default != null:
return $default(_that.key,_that.summary,_that.projectKey,_that.issueType,_that.assigneeEmail,_that.url,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _JiraCreateResult implements JiraCreateResult {
  const _JiraCreateResult({required this.key, required this.summary, required this.projectKey, required this.issueType, required this.assigneeEmail, this.url, required this.message});
  

@override final  String key;
@override final  String summary;
@override final  String projectKey;
@override final  String issueType;
@override final  String assigneeEmail;
@override final  String? url;
@override final  String message;

/// Create a copy of JiraCreateResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JiraCreateResultCopyWith<_JiraCreateResult> get copyWith => __$JiraCreateResultCopyWithImpl<_JiraCreateResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JiraCreateResult&&(identical(other.key, key) || other.key == key)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.projectKey, projectKey) || other.projectKey == projectKey)&&(identical(other.issueType, issueType) || other.issueType == issueType)&&(identical(other.assigneeEmail, assigneeEmail) || other.assigneeEmail == assigneeEmail)&&(identical(other.url, url) || other.url == url)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,key,summary,projectKey,issueType,assigneeEmail,url,message);

@override
String toString() {
  return 'JiraCreateResult(key: $key, summary: $summary, projectKey: $projectKey, issueType: $issueType, assigneeEmail: $assigneeEmail, url: $url, message: $message)';
}


}

/// @nodoc
abstract mixin class _$JiraCreateResultCopyWith<$Res> implements $JiraCreateResultCopyWith<$Res> {
  factory _$JiraCreateResultCopyWith(_JiraCreateResult value, $Res Function(_JiraCreateResult) _then) = __$JiraCreateResultCopyWithImpl;
@override @useResult
$Res call({
 String key, String summary, String projectKey, String issueType, String assigneeEmail, String? url, String message
});




}
/// @nodoc
class __$JiraCreateResultCopyWithImpl<$Res>
    implements _$JiraCreateResultCopyWith<$Res> {
  __$JiraCreateResultCopyWithImpl(this._self, this._then);

  final _JiraCreateResult _self;
  final $Res Function(_JiraCreateResult) _then;

/// Create a copy of JiraCreateResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? summary = null,Object? projectKey = null,Object? issueType = null,Object? assigneeEmail = null,Object? url = freezed,Object? message = null,}) {
  return _then(_JiraCreateResult(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,projectKey: null == projectKey ? _self.projectKey : projectKey // ignore: cast_nullable_to_non_nullable
as String,issueType: null == issueType ? _self.issueType : issueType // ignore: cast_nullable_to_non_nullable
as String,assigneeEmail: null == assigneeEmail ? _self.assigneeEmail : assigneeEmail // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChatResultEnvelope {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatResultEnvelope);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatResultEnvelope()';
}


}

/// @nodoc
class $ChatResultEnvelopeCopyWith<$Res>  {
$ChatResultEnvelopeCopyWith(ChatResultEnvelope _, $Res Function(ChatResultEnvelope) __);
}


/// Adds pattern-matching-related methods to [ChatResultEnvelope].
extension ChatResultEnvelopePatterns on ChatResultEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatLeaveBalanceResult value)?  leaveBalance,TResult Function( ChatLeaveListResult value)?  leaveList,TResult Function( ChatTripListResult value)?  tripList,TResult Function( ChatPendingApprovalsResult value)?  pendingApprovals,TResult Function( ChatJiraIssuesResult value)?  jiraIssues,TResult Function( ChatLeaveMutationResult value)?  leaveMutation,TResult Function( ChatTripMutationResult value)?  tripMutation,TResult Function( ChatLeaveBatchMutationResult value)?  leaveBatchMutation,TResult Function( ChatTripBatchMutationResult value)?  tripBatchMutation,TResult Function( ChatJiraMutationResult value)?  jiraMutation,TResult Function( ChatUnknownResult value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatLeaveBalanceResult() when leaveBalance != null:
return leaveBalance(_that);case ChatLeaveListResult() when leaveList != null:
return leaveList(_that);case ChatTripListResult() when tripList != null:
return tripList(_that);case ChatPendingApprovalsResult() when pendingApprovals != null:
return pendingApprovals(_that);case ChatJiraIssuesResult() when jiraIssues != null:
return jiraIssues(_that);case ChatLeaveMutationResult() when leaveMutation != null:
return leaveMutation(_that);case ChatTripMutationResult() when tripMutation != null:
return tripMutation(_that);case ChatLeaveBatchMutationResult() when leaveBatchMutation != null:
return leaveBatchMutation(_that);case ChatTripBatchMutationResult() when tripBatchMutation != null:
return tripBatchMutation(_that);case ChatJiraMutationResult() when jiraMutation != null:
return jiraMutation(_that);case ChatUnknownResult() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatLeaveBalanceResult value)  leaveBalance,required TResult Function( ChatLeaveListResult value)  leaveList,required TResult Function( ChatTripListResult value)  tripList,required TResult Function( ChatPendingApprovalsResult value)  pendingApprovals,required TResult Function( ChatJiraIssuesResult value)  jiraIssues,required TResult Function( ChatLeaveMutationResult value)  leaveMutation,required TResult Function( ChatTripMutationResult value)  tripMutation,required TResult Function( ChatLeaveBatchMutationResult value)  leaveBatchMutation,required TResult Function( ChatTripBatchMutationResult value)  tripBatchMutation,required TResult Function( ChatJiraMutationResult value)  jiraMutation,required TResult Function( ChatUnknownResult value)  unknown,}){
final _that = this;
switch (_that) {
case ChatLeaveBalanceResult():
return leaveBalance(_that);case ChatLeaveListResult():
return leaveList(_that);case ChatTripListResult():
return tripList(_that);case ChatPendingApprovalsResult():
return pendingApprovals(_that);case ChatJiraIssuesResult():
return jiraIssues(_that);case ChatLeaveMutationResult():
return leaveMutation(_that);case ChatTripMutationResult():
return tripMutation(_that);case ChatLeaveBatchMutationResult():
return leaveBatchMutation(_that);case ChatTripBatchMutationResult():
return tripBatchMutation(_that);case ChatJiraMutationResult():
return jiraMutation(_that);case ChatUnknownResult():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatLeaveBalanceResult value)?  leaveBalance,TResult? Function( ChatLeaveListResult value)?  leaveList,TResult? Function( ChatTripListResult value)?  tripList,TResult? Function( ChatPendingApprovalsResult value)?  pendingApprovals,TResult? Function( ChatJiraIssuesResult value)?  jiraIssues,TResult? Function( ChatLeaveMutationResult value)?  leaveMutation,TResult? Function( ChatTripMutationResult value)?  tripMutation,TResult? Function( ChatLeaveBatchMutationResult value)?  leaveBatchMutation,TResult? Function( ChatTripBatchMutationResult value)?  tripBatchMutation,TResult? Function( ChatJiraMutationResult value)?  jiraMutation,TResult? Function( ChatUnknownResult value)?  unknown,}){
final _that = this;
switch (_that) {
case ChatLeaveBalanceResult() when leaveBalance != null:
return leaveBalance(_that);case ChatLeaveListResult() when leaveList != null:
return leaveList(_that);case ChatTripListResult() when tripList != null:
return tripList(_that);case ChatPendingApprovalsResult() when pendingApprovals != null:
return pendingApprovals(_that);case ChatJiraIssuesResult() when jiraIssues != null:
return jiraIssues(_that);case ChatLeaveMutationResult() when leaveMutation != null:
return leaveMutation(_that);case ChatTripMutationResult() when tripMutation != null:
return tripMutation(_that);case ChatLeaveBatchMutationResult() when leaveBatchMutation != null:
return leaveBatchMutation(_that);case ChatTripBatchMutationResult() when tripBatchMutation != null:
return tripBatchMutation(_that);case ChatJiraMutationResult() when jiraMutation != null:
return jiraMutation(_that);case ChatUnknownResult() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LeaveBalance data)?  leaveBalance,TResult Function( List<LeaveRequest> data)?  leaveList,TResult Function( List<TripRequest> data)?  tripList,TResult Function( PendingApprovals data)?  pendingApprovals,TResult Function( JiraIssueList data)?  jiraIssues,TResult Function( ChatMutationType mutation,  LeaveRequest data)?  leaveMutation,TResult Function( ChatMutationType mutation,  TripRequest data)?  tripMutation,TResult Function( ChatMutationType mutation,  LeaveBatchMutation data)?  leaveBatchMutation,TResult Function( ChatMutationType mutation,  TripBatchMutation data)?  tripBatchMutation,TResult Function( ChatMutationType mutation,  JiraCreateResult data)?  jiraMutation,TResult Function( Object? raw)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatLeaveBalanceResult() when leaveBalance != null:
return leaveBalance(_that.data);case ChatLeaveListResult() when leaveList != null:
return leaveList(_that.data);case ChatTripListResult() when tripList != null:
return tripList(_that.data);case ChatPendingApprovalsResult() when pendingApprovals != null:
return pendingApprovals(_that.data);case ChatJiraIssuesResult() when jiraIssues != null:
return jiraIssues(_that.data);case ChatLeaveMutationResult() when leaveMutation != null:
return leaveMutation(_that.mutation,_that.data);case ChatTripMutationResult() when tripMutation != null:
return tripMutation(_that.mutation,_that.data);case ChatLeaveBatchMutationResult() when leaveBatchMutation != null:
return leaveBatchMutation(_that.mutation,_that.data);case ChatTripBatchMutationResult() when tripBatchMutation != null:
return tripBatchMutation(_that.mutation,_that.data);case ChatJiraMutationResult() when jiraMutation != null:
return jiraMutation(_that.mutation,_that.data);case ChatUnknownResult() when unknown != null:
return unknown(_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LeaveBalance data)  leaveBalance,required TResult Function( List<LeaveRequest> data)  leaveList,required TResult Function( List<TripRequest> data)  tripList,required TResult Function( PendingApprovals data)  pendingApprovals,required TResult Function( JiraIssueList data)  jiraIssues,required TResult Function( ChatMutationType mutation,  LeaveRequest data)  leaveMutation,required TResult Function( ChatMutationType mutation,  TripRequest data)  tripMutation,required TResult Function( ChatMutationType mutation,  LeaveBatchMutation data)  leaveBatchMutation,required TResult Function( ChatMutationType mutation,  TripBatchMutation data)  tripBatchMutation,required TResult Function( ChatMutationType mutation,  JiraCreateResult data)  jiraMutation,required TResult Function( Object? raw)  unknown,}) {final _that = this;
switch (_that) {
case ChatLeaveBalanceResult():
return leaveBalance(_that.data);case ChatLeaveListResult():
return leaveList(_that.data);case ChatTripListResult():
return tripList(_that.data);case ChatPendingApprovalsResult():
return pendingApprovals(_that.data);case ChatJiraIssuesResult():
return jiraIssues(_that.data);case ChatLeaveMutationResult():
return leaveMutation(_that.mutation,_that.data);case ChatTripMutationResult():
return tripMutation(_that.mutation,_that.data);case ChatLeaveBatchMutationResult():
return leaveBatchMutation(_that.mutation,_that.data);case ChatTripBatchMutationResult():
return tripBatchMutation(_that.mutation,_that.data);case ChatJiraMutationResult():
return jiraMutation(_that.mutation,_that.data);case ChatUnknownResult():
return unknown(_that.raw);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LeaveBalance data)?  leaveBalance,TResult? Function( List<LeaveRequest> data)?  leaveList,TResult? Function( List<TripRequest> data)?  tripList,TResult? Function( PendingApprovals data)?  pendingApprovals,TResult? Function( JiraIssueList data)?  jiraIssues,TResult? Function( ChatMutationType mutation,  LeaveRequest data)?  leaveMutation,TResult? Function( ChatMutationType mutation,  TripRequest data)?  tripMutation,TResult? Function( ChatMutationType mutation,  LeaveBatchMutation data)?  leaveBatchMutation,TResult? Function( ChatMutationType mutation,  TripBatchMutation data)?  tripBatchMutation,TResult? Function( ChatMutationType mutation,  JiraCreateResult data)?  jiraMutation,TResult? Function( Object? raw)?  unknown,}) {final _that = this;
switch (_that) {
case ChatLeaveBalanceResult() when leaveBalance != null:
return leaveBalance(_that.data);case ChatLeaveListResult() when leaveList != null:
return leaveList(_that.data);case ChatTripListResult() when tripList != null:
return tripList(_that.data);case ChatPendingApprovalsResult() when pendingApprovals != null:
return pendingApprovals(_that.data);case ChatJiraIssuesResult() when jiraIssues != null:
return jiraIssues(_that.data);case ChatLeaveMutationResult() when leaveMutation != null:
return leaveMutation(_that.mutation,_that.data);case ChatTripMutationResult() when tripMutation != null:
return tripMutation(_that.mutation,_that.data);case ChatLeaveBatchMutationResult() when leaveBatchMutation != null:
return leaveBatchMutation(_that.mutation,_that.data);case ChatTripBatchMutationResult() when tripBatchMutation != null:
return tripBatchMutation(_that.mutation,_that.data);case ChatJiraMutationResult() when jiraMutation != null:
return jiraMutation(_that.mutation,_that.data);case ChatUnknownResult() when unknown != null:
return unknown(_that.raw);case _:
  return null;

}
}

}

/// @nodoc


class ChatLeaveBalanceResult extends ChatResultEnvelope {
  const ChatLeaveBalanceResult(this.data): super._();
  

 final  LeaveBalance data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLeaveBalanceResultCopyWith<ChatLeaveBalanceResult> get copyWith => _$ChatLeaveBalanceResultCopyWithImpl<ChatLeaveBalanceResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLeaveBalanceResult&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ChatResultEnvelope.leaveBalance(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatLeaveBalanceResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatLeaveBalanceResultCopyWith(ChatLeaveBalanceResult value, $Res Function(ChatLeaveBalanceResult) _then) = _$ChatLeaveBalanceResultCopyWithImpl;
@useResult
$Res call({
 LeaveBalance data
});


$LeaveBalanceCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatLeaveBalanceResultCopyWithImpl<$Res>
    implements $ChatLeaveBalanceResultCopyWith<$Res> {
  _$ChatLeaveBalanceResultCopyWithImpl(this._self, this._then);

  final ChatLeaveBalanceResult _self;
  final $Res Function(ChatLeaveBalanceResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatLeaveBalanceResult(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LeaveBalance,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBalanceCopyWith<$Res> get data {
  
  return $LeaveBalanceCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatLeaveListResult extends ChatResultEnvelope {
  const ChatLeaveListResult(final  List<LeaveRequest> data): _data = data,super._();
  

 final  List<LeaveRequest> _data;
 List<LeaveRequest> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLeaveListResultCopyWith<ChatLeaveListResult> get copyWith => _$ChatLeaveListResultCopyWithImpl<ChatLeaveListResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLeaveListResult&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ChatResultEnvelope.leaveList(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatLeaveListResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatLeaveListResultCopyWith(ChatLeaveListResult value, $Res Function(ChatLeaveListResult) _then) = _$ChatLeaveListResultCopyWithImpl;
@useResult
$Res call({
 List<LeaveRequest> data
});




}
/// @nodoc
class _$ChatLeaveListResultCopyWithImpl<$Res>
    implements $ChatLeaveListResultCopyWith<$Res> {
  _$ChatLeaveListResultCopyWithImpl(this._self, this._then);

  final ChatLeaveListResult _self;
  final $Res Function(ChatLeaveListResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatLeaveListResult(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<LeaveRequest>,
  ));
}


}

/// @nodoc


class ChatTripListResult extends ChatResultEnvelope {
  const ChatTripListResult(final  List<TripRequest> data): _data = data,super._();
  

 final  List<TripRequest> _data;
 List<TripRequest> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTripListResultCopyWith<ChatTripListResult> get copyWith => _$ChatTripListResultCopyWithImpl<ChatTripListResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTripListResult&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ChatResultEnvelope.tripList(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatTripListResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatTripListResultCopyWith(ChatTripListResult value, $Res Function(ChatTripListResult) _then) = _$ChatTripListResultCopyWithImpl;
@useResult
$Res call({
 List<TripRequest> data
});




}
/// @nodoc
class _$ChatTripListResultCopyWithImpl<$Res>
    implements $ChatTripListResultCopyWith<$Res> {
  _$ChatTripListResultCopyWithImpl(this._self, this._then);

  final ChatTripListResult _self;
  final $Res Function(ChatTripListResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatTripListResult(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<TripRequest>,
  ));
}


}

/// @nodoc


class ChatPendingApprovalsResult extends ChatResultEnvelope {
  const ChatPendingApprovalsResult(this.data): super._();
  

 final  PendingApprovals data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPendingApprovalsResultCopyWith<ChatPendingApprovalsResult> get copyWith => _$ChatPendingApprovalsResultCopyWithImpl<ChatPendingApprovalsResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPendingApprovalsResult&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ChatResultEnvelope.pendingApprovals(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatPendingApprovalsResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatPendingApprovalsResultCopyWith(ChatPendingApprovalsResult value, $Res Function(ChatPendingApprovalsResult) _then) = _$ChatPendingApprovalsResultCopyWithImpl;
@useResult
$Res call({
 PendingApprovals data
});


$PendingApprovalsCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatPendingApprovalsResultCopyWithImpl<$Res>
    implements $ChatPendingApprovalsResultCopyWith<$Res> {
  _$ChatPendingApprovalsResultCopyWithImpl(this._self, this._then);

  final ChatPendingApprovalsResult _self;
  final $Res Function(ChatPendingApprovalsResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatPendingApprovalsResult(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PendingApprovals,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingApprovalsCopyWith<$Res> get data {
  
  return $PendingApprovalsCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatJiraIssuesResult extends ChatResultEnvelope {
  const ChatJiraIssuesResult(this.data): super._();
  

 final  JiraIssueList data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatJiraIssuesResultCopyWith<ChatJiraIssuesResult> get copyWith => _$ChatJiraIssuesResultCopyWithImpl<ChatJiraIssuesResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatJiraIssuesResult&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ChatResultEnvelope.jiraIssues(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatJiraIssuesResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatJiraIssuesResultCopyWith(ChatJiraIssuesResult value, $Res Function(ChatJiraIssuesResult) _then) = _$ChatJiraIssuesResultCopyWithImpl;
@useResult
$Res call({
 JiraIssueList data
});


$JiraIssueListCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatJiraIssuesResultCopyWithImpl<$Res>
    implements $ChatJiraIssuesResultCopyWith<$Res> {
  _$ChatJiraIssuesResultCopyWithImpl(this._self, this._then);

  final ChatJiraIssuesResult _self;
  final $Res Function(ChatJiraIssuesResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatJiraIssuesResult(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as JiraIssueList,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JiraIssueListCopyWith<$Res> get data {
  
  return $JiraIssueListCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatLeaveMutationResult extends ChatResultEnvelope {
  const ChatLeaveMutationResult({required this.mutation, required this.data}): super._();
  

 final  ChatMutationType mutation;
 final  LeaveRequest data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLeaveMutationResultCopyWith<ChatLeaveMutationResult> get copyWith => _$ChatLeaveMutationResultCopyWithImpl<ChatLeaveMutationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLeaveMutationResult&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,mutation,data);

@override
String toString() {
  return 'ChatResultEnvelope.leaveMutation(mutation: $mutation, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatLeaveMutationResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatLeaveMutationResultCopyWith(ChatLeaveMutationResult value, $Res Function(ChatLeaveMutationResult) _then) = _$ChatLeaveMutationResultCopyWithImpl;
@useResult
$Res call({
 ChatMutationType mutation, LeaveRequest data
});


$LeaveRequestCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatLeaveMutationResultCopyWithImpl<$Res>
    implements $ChatLeaveMutationResultCopyWith<$Res> {
  _$ChatLeaveMutationResultCopyWithImpl(this._self, this._then);

  final ChatLeaveMutationResult _self;
  final $Res Function(ChatLeaveMutationResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mutation = null,Object? data = null,}) {
  return _then(ChatLeaveMutationResult(
mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as ChatMutationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LeaveRequest,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveRequestCopyWith<$Res> get data {
  
  return $LeaveRequestCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatTripMutationResult extends ChatResultEnvelope {
  const ChatTripMutationResult({required this.mutation, required this.data}): super._();
  

 final  ChatMutationType mutation;
 final  TripRequest data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTripMutationResultCopyWith<ChatTripMutationResult> get copyWith => _$ChatTripMutationResultCopyWithImpl<ChatTripMutationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTripMutationResult&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,mutation,data);

@override
String toString() {
  return 'ChatResultEnvelope.tripMutation(mutation: $mutation, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatTripMutationResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatTripMutationResultCopyWith(ChatTripMutationResult value, $Res Function(ChatTripMutationResult) _then) = _$ChatTripMutationResultCopyWithImpl;
@useResult
$Res call({
 ChatMutationType mutation, TripRequest data
});


$TripRequestCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatTripMutationResultCopyWithImpl<$Res>
    implements $ChatTripMutationResultCopyWith<$Res> {
  _$ChatTripMutationResultCopyWithImpl(this._self, this._then);

  final ChatTripMutationResult _self;
  final $Res Function(ChatTripMutationResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mutation = null,Object? data = null,}) {
  return _then(ChatTripMutationResult(
mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as ChatMutationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TripRequest,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripRequestCopyWith<$Res> get data {
  
  return $TripRequestCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatLeaveBatchMutationResult extends ChatResultEnvelope {
  const ChatLeaveBatchMutationResult({required this.mutation, required this.data}): super._();
  

 final  ChatMutationType mutation;
 final  LeaveBatchMutation data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLeaveBatchMutationResultCopyWith<ChatLeaveBatchMutationResult> get copyWith => _$ChatLeaveBatchMutationResultCopyWithImpl<ChatLeaveBatchMutationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLeaveBatchMutationResult&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,mutation,data);

@override
String toString() {
  return 'ChatResultEnvelope.leaveBatchMutation(mutation: $mutation, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatLeaveBatchMutationResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatLeaveBatchMutationResultCopyWith(ChatLeaveBatchMutationResult value, $Res Function(ChatLeaveBatchMutationResult) _then) = _$ChatLeaveBatchMutationResultCopyWithImpl;
@useResult
$Res call({
 ChatMutationType mutation, LeaveBatchMutation data
});


$LeaveBatchMutationCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatLeaveBatchMutationResultCopyWithImpl<$Res>
    implements $ChatLeaveBatchMutationResultCopyWith<$Res> {
  _$ChatLeaveBatchMutationResultCopyWithImpl(this._self, this._then);

  final ChatLeaveBatchMutationResult _self;
  final $Res Function(ChatLeaveBatchMutationResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mutation = null,Object? data = null,}) {
  return _then(ChatLeaveBatchMutationResult(
mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as ChatMutationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LeaveBatchMutation,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBatchMutationCopyWith<$Res> get data {
  
  return $LeaveBatchMutationCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatTripBatchMutationResult extends ChatResultEnvelope {
  const ChatTripBatchMutationResult({required this.mutation, required this.data}): super._();
  

 final  ChatMutationType mutation;
 final  TripBatchMutation data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTripBatchMutationResultCopyWith<ChatTripBatchMutationResult> get copyWith => _$ChatTripBatchMutationResultCopyWithImpl<ChatTripBatchMutationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTripBatchMutationResult&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,mutation,data);

@override
String toString() {
  return 'ChatResultEnvelope.tripBatchMutation(mutation: $mutation, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatTripBatchMutationResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatTripBatchMutationResultCopyWith(ChatTripBatchMutationResult value, $Res Function(ChatTripBatchMutationResult) _then) = _$ChatTripBatchMutationResultCopyWithImpl;
@useResult
$Res call({
 ChatMutationType mutation, TripBatchMutation data
});


$TripBatchMutationCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatTripBatchMutationResultCopyWithImpl<$Res>
    implements $ChatTripBatchMutationResultCopyWith<$Res> {
  _$ChatTripBatchMutationResultCopyWithImpl(this._self, this._then);

  final ChatTripBatchMutationResult _self;
  final $Res Function(ChatTripBatchMutationResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mutation = null,Object? data = null,}) {
  return _then(ChatTripBatchMutationResult(
mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as ChatMutationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TripBatchMutation,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripBatchMutationCopyWith<$Res> get data {
  
  return $TripBatchMutationCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatJiraMutationResult extends ChatResultEnvelope {
  const ChatJiraMutationResult({required this.mutation, required this.data}): super._();
  

 final  ChatMutationType mutation;
 final  JiraCreateResult data;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatJiraMutationResultCopyWith<ChatJiraMutationResult> get copyWith => _$ChatJiraMutationResultCopyWithImpl<ChatJiraMutationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatJiraMutationResult&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,mutation,data);

@override
String toString() {
  return 'ChatResultEnvelope.jiraMutation(mutation: $mutation, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatJiraMutationResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatJiraMutationResultCopyWith(ChatJiraMutationResult value, $Res Function(ChatJiraMutationResult) _then) = _$ChatJiraMutationResultCopyWithImpl;
@useResult
$Res call({
 ChatMutationType mutation, JiraCreateResult data
});


$JiraCreateResultCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatJiraMutationResultCopyWithImpl<$Res>
    implements $ChatJiraMutationResultCopyWith<$Res> {
  _$ChatJiraMutationResultCopyWithImpl(this._self, this._then);

  final ChatJiraMutationResult _self;
  final $Res Function(ChatJiraMutationResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mutation = null,Object? data = null,}) {
  return _then(ChatJiraMutationResult(
mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as ChatMutationType,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as JiraCreateResult,
  ));
}

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JiraCreateResultCopyWith<$Res> get data {
  
  return $JiraCreateResultCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class ChatUnknownResult extends ChatResultEnvelope {
  const ChatUnknownResult(this.raw): super._();
  

 final  Object? raw;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatUnknownResultCopyWith<ChatUnknownResult> get copyWith => _$ChatUnknownResultCopyWithImpl<ChatUnknownResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatUnknownResult&&const DeepCollectionEquality().equals(other.raw, raw));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(raw));

@override
String toString() {
  return 'ChatResultEnvelope.unknown(raw: $raw)';
}


}

/// @nodoc
abstract mixin class $ChatUnknownResultCopyWith<$Res> implements $ChatResultEnvelopeCopyWith<$Res> {
  factory $ChatUnknownResultCopyWith(ChatUnknownResult value, $Res Function(ChatUnknownResult) _then) = _$ChatUnknownResultCopyWithImpl;
@useResult
$Res call({
 Object? raw
});




}
/// @nodoc
class _$ChatUnknownResultCopyWithImpl<$Res>
    implements $ChatUnknownResultCopyWith<$Res> {
  _$ChatUnknownResultCopyWithImpl(this._self, this._then);

  final ChatUnknownResult _self;
  final $Res Function(ChatUnknownResult) _then;

/// Create a copy of ChatResultEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? raw = freezed,}) {
  return _then(ChatUnknownResult(
freezed == raw ? _self.raw : raw ,
  ));
}


}

// dart format on
