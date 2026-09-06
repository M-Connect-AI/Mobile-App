// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveBalance _$LeaveBalanceFromJson(Map<String, dynamic> json) {
  return _LeaveBalance.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalance {
  String get employeeCode => throw _privateConstructorUsedError;
  int get annualRemaining => throw _privateConstructorUsedError;
  int get annualTotal => throw _privateConstructorUsedError;
  int get sickRemaining => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceCopyWith<LeaveBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceCopyWith<$Res> {
  factory $LeaveBalanceCopyWith(
    LeaveBalance value,
    $Res Function(LeaveBalance) then,
  ) = _$LeaveBalanceCopyWithImpl<$Res, LeaveBalance>;
  @useResult
  $Res call({
    String employeeCode,
    int annualRemaining,
    int annualTotal,
    int sickRemaining,
  });
}

/// @nodoc
class _$LeaveBalanceCopyWithImpl<$Res, $Val extends LeaveBalance>
    implements $LeaveBalanceCopyWith<$Res> {
  _$LeaveBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeCode = null,
    Object? annualRemaining = null,
    Object? annualTotal = null,
    Object? sickRemaining = null,
  }) {
    return _then(
      _value.copyWith(
            employeeCode: null == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            annualRemaining: null == annualRemaining
                ? _value.annualRemaining
                : annualRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            annualTotal: null == annualTotal
                ? _value.annualTotal
                : annualTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            sickRemaining: null == sickRemaining
                ? _value.sickRemaining
                : sickRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveBalanceImplCopyWith<$Res>
    implements $LeaveBalanceCopyWith<$Res> {
  factory _$$LeaveBalanceImplCopyWith(
    _$LeaveBalanceImpl value,
    $Res Function(_$LeaveBalanceImpl) then,
  ) = __$$LeaveBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String employeeCode,
    int annualRemaining,
    int annualTotal,
    int sickRemaining,
  });
}

/// @nodoc
class __$$LeaveBalanceImplCopyWithImpl<$Res>
    extends _$LeaveBalanceCopyWithImpl<$Res, _$LeaveBalanceImpl>
    implements _$$LeaveBalanceImplCopyWith<$Res> {
  __$$LeaveBalanceImplCopyWithImpl(
    _$LeaveBalanceImpl _value,
    $Res Function(_$LeaveBalanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeCode = null,
    Object? annualRemaining = null,
    Object? annualTotal = null,
    Object? sickRemaining = null,
  }) {
    return _then(
      _$LeaveBalanceImpl(
        employeeCode: null == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        annualRemaining: null == annualRemaining
            ? _value.annualRemaining
            : annualRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        annualTotal: null == annualTotal
            ? _value.annualTotal
            : annualTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        sickRemaining: null == sickRemaining
            ? _value.sickRemaining
            : sickRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveBalanceImpl implements _LeaveBalance {
  const _$LeaveBalanceImpl({
    required this.employeeCode,
    required this.annualRemaining,
    required this.annualTotal,
    required this.sickRemaining,
  });

  factory _$LeaveBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceImplFromJson(json);

  @override
  final String employeeCode;
  @override
  final int annualRemaining;
  @override
  final int annualTotal;
  @override
  final int sickRemaining;

  @override
  String toString() {
    return 'LeaveBalance(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceImpl &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.annualRemaining, annualRemaining) ||
                other.annualRemaining == annualRemaining) &&
            (identical(other.annualTotal, annualTotal) ||
                other.annualTotal == annualTotal) &&
            (identical(other.sickRemaining, sickRemaining) ||
                other.sickRemaining == sickRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    employeeCode,
    annualRemaining,
    annualTotal,
    sickRemaining,
  );

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceImplCopyWith<_$LeaveBalanceImpl> get copyWith =>
      __$$LeaveBalanceImplCopyWithImpl<_$LeaveBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceImplToJson(this);
  }
}

abstract class _LeaveBalance implements LeaveBalance {
  const factory _LeaveBalance({
    required final String employeeCode,
    required final int annualRemaining,
    required final int annualTotal,
    required final int sickRemaining,
  }) = _$LeaveBalanceImpl;

  factory _LeaveBalance.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceImpl.fromJson;

  @override
  String get employeeCode;
  @override
  int get annualRemaining;
  @override
  int get annualTotal;
  @override
  int get sickRemaining;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceImplCopyWith<_$LeaveBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessTrip _$BusinessTripFromJson(Map<String, dynamic> json) {
  return _BusinessTrip.fromJson(json);
}

/// @nodoc
mixin _$BusinessTrip {
  String get id => throw _privateConstructorUsedError;
  String get employeeCode => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  DateTime get from => throw _privateConstructorUsedError;
  DateTime get to => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessTrip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessTrip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessTripCopyWith<BusinessTrip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessTripCopyWith<$Res> {
  factory $BusinessTripCopyWith(
    BusinessTrip value,
    $Res Function(BusinessTrip) then,
  ) = _$BusinessTripCopyWithImpl<$Res, BusinessTrip>;
  @useResult
  $Res call({
    String id,
    String employeeCode,
    String destination,
    DateTime from,
    DateTime to,
    String purpose,
    RequestStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$BusinessTripCopyWithImpl<$Res, $Val extends BusinessTrip>
    implements $BusinessTripCopyWith<$Res> {
  _$BusinessTripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessTrip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeCode = null,
    Object? destination = null,
    Object? from = null,
    Object? to = null,
    Object? purpose = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeCode: null == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String,
            destination: null == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RequestStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessTripImplCopyWith<$Res>
    implements $BusinessTripCopyWith<$Res> {
  factory _$$BusinessTripImplCopyWith(
    _$BusinessTripImpl value,
    $Res Function(_$BusinessTripImpl) then,
  ) = __$$BusinessTripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String employeeCode,
    String destination,
    DateTime from,
    DateTime to,
    String purpose,
    RequestStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$BusinessTripImplCopyWithImpl<$Res>
    extends _$BusinessTripCopyWithImpl<$Res, _$BusinessTripImpl>
    implements _$$BusinessTripImplCopyWith<$Res> {
  __$$BusinessTripImplCopyWithImpl(
    _$BusinessTripImpl _value,
    $Res Function(_$BusinessTripImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessTrip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeCode = null,
    Object? destination = null,
    Object? from = null,
    Object? to = null,
    Object? purpose = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BusinessTripImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeCode: null == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String,
        destination: null == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RequestStatus,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessTripImpl implements _BusinessTrip {
  const _$BusinessTripImpl({
    required this.id,
    required this.employeeCode,
    required this.destination,
    required this.from,
    required this.to,
    required this.purpose,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory _$BusinessTripImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessTripImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeCode;
  @override
  final String destination;
  @override
  final DateTime from;
  @override
  final DateTime to;
  @override
  final String purpose;
  @override
  final RequestStatus status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'BusinessTrip(id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessTripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    employeeCode,
    destination,
    from,
    to,
    purpose,
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of BusinessTrip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessTripImplCopyWith<_$BusinessTripImpl> get copyWith =>
      __$$BusinessTripImplCopyWithImpl<_$BusinessTripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessTripImplToJson(this);
  }
}

abstract class _BusinessTrip implements BusinessTrip {
  const factory _BusinessTrip({
    required final String id,
    required final String employeeCode,
    required final String destination,
    required final DateTime from,
    required final DateTime to,
    required final String purpose,
    required final RequestStatus status,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$BusinessTripImpl;

  factory _BusinessTrip.fromJson(Map<String, dynamic> json) =
      _$BusinessTripImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeCode;
  @override
  String get destination;
  @override
  DateTime get from;
  @override
  DateTime get to;
  @override
  String get purpose;
  @override
  RequestStatus get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of BusinessTrip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessTripImplCopyWith<_$BusinessTripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeData _$HomeDataFromJson(Map<String, dynamic> json) {
  return _HomeData.fromJson(json);
}

/// @nodoc
mixin _$HomeData {
  AuthUser get user => throw _privateConstructorUsedError;
  LeaveBalance get leaveBalance => throw _privateConstructorUsedError;
  List<BusinessTrip> get upcomingTrips => throw _privateConstructorUsedError;

  /// Serializes this HomeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataCopyWith<HomeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) then) =
      _$HomeDataCopyWithImpl<$Res, HomeData>;
  @useResult
  $Res call({
    AuthUser user,
    LeaveBalance leaveBalance,
    List<BusinessTrip> upcomingTrips,
  });

  $AuthUserCopyWith<$Res> get user;
  $LeaveBalanceCopyWith<$Res> get leaveBalance;
}

/// @nodoc
class _$HomeDataCopyWithImpl<$Res, $Val extends HomeData>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? leaveBalance = null,
    Object? upcomingTrips = null,
  }) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthUser,
            leaveBalance: null == leaveBalance
                ? _value.leaveBalance
                : leaveBalance // ignore: cast_nullable_to_non_nullable
                      as LeaveBalance,
            upcomingTrips: null == upcomingTrips
                ? _value.upcomingTrips
                : upcomingTrips // ignore: cast_nullable_to_non_nullable
                      as List<BusinessTrip>,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res> get user {
    return $AuthUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<$Res> get leaveBalance {
    return $LeaveBalanceCopyWith<$Res>(_value.leaveBalance, (value) {
      return _then(_value.copyWith(leaveBalance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDataImplCopyWith<$Res>
    implements $HomeDataCopyWith<$Res> {
  factory _$$HomeDataImplCopyWith(
    _$HomeDataImpl value,
    $Res Function(_$HomeDataImpl) then,
  ) = __$$HomeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthUser user,
    LeaveBalance leaveBalance,
    List<BusinessTrip> upcomingTrips,
  });

  @override
  $AuthUserCopyWith<$Res> get user;
  @override
  $LeaveBalanceCopyWith<$Res> get leaveBalance;
}

/// @nodoc
class __$$HomeDataImplCopyWithImpl<$Res>
    extends _$HomeDataCopyWithImpl<$Res, _$HomeDataImpl>
    implements _$$HomeDataImplCopyWith<$Res> {
  __$$HomeDataImplCopyWithImpl(
    _$HomeDataImpl _value,
    $Res Function(_$HomeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? leaveBalance = null,
    Object? upcomingTrips = null,
  }) {
    return _then(
      _$HomeDataImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthUser,
        leaveBalance: null == leaveBalance
            ? _value.leaveBalance
            : leaveBalance // ignore: cast_nullable_to_non_nullable
                  as LeaveBalance,
        upcomingTrips: null == upcomingTrips
            ? _value._upcomingTrips
            : upcomingTrips // ignore: cast_nullable_to_non_nullable
                  as List<BusinessTrip>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDataImpl implements _HomeData {
  const _$HomeDataImpl({
    required this.user,
    required this.leaveBalance,
    required final List<BusinessTrip> upcomingTrips,
  }) : _upcomingTrips = upcomingTrips;

  factory _$HomeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDataImplFromJson(json);

  @override
  final AuthUser user;
  @override
  final LeaveBalance leaveBalance;
  final List<BusinessTrip> _upcomingTrips;
  @override
  List<BusinessTrip> get upcomingTrips {
    if (_upcomingTrips is EqualUnmodifiableListView) return _upcomingTrips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingTrips);
  }

  @override
  String toString() {
    return 'HomeData(user: $user, leaveBalance: $leaveBalance, upcomingTrips: $upcomingTrips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.leaveBalance, leaveBalance) ||
                other.leaveBalance == leaveBalance) &&
            const DeepCollectionEquality().equals(
              other._upcomingTrips,
              _upcomingTrips,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    user,
    leaveBalance,
    const DeepCollectionEquality().hash(_upcomingTrips),
  );

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDataImplToJson(this);
  }
}

abstract class _HomeData implements HomeData {
  const factory _HomeData({
    required final AuthUser user,
    required final LeaveBalance leaveBalance,
    required final List<BusinessTrip> upcomingTrips,
  }) = _$HomeDataImpl;

  factory _HomeData.fromJson(Map<String, dynamic> json) =
      _$HomeDataImpl.fromJson;

  @override
  AuthUser get user;
  @override
  LeaveBalance get leaveBalance;
  @override
  List<BusinessTrip> get upcomingTrips;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
