// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveBalanceDto _$LeaveBalanceDtoFromJson(Map<String, dynamic> json) {
  return _LeaveBalanceDto.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalanceDto {
  String get employeeCode => throw _privateConstructorUsedError;
  int get annualRemaining => throw _privateConstructorUsedError;
  int get annualTotal => throw _privateConstructorUsedError;
  int get sickRemaining => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalanceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceDtoCopyWith<LeaveBalanceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceDtoCopyWith<$Res> {
  factory $LeaveBalanceDtoCopyWith(
    LeaveBalanceDto value,
    $Res Function(LeaveBalanceDto) then,
  ) = _$LeaveBalanceDtoCopyWithImpl<$Res, LeaveBalanceDto>;
  @useResult
  $Res call({
    String employeeCode,
    int annualRemaining,
    int annualTotal,
    int sickRemaining,
  });
}

/// @nodoc
class _$LeaveBalanceDtoCopyWithImpl<$Res, $Val extends LeaveBalanceDto>
    implements $LeaveBalanceDtoCopyWith<$Res> {
  _$LeaveBalanceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalanceDto
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
abstract class _$$LeaveBalanceDtoImplCopyWith<$Res>
    implements $LeaveBalanceDtoCopyWith<$Res> {
  factory _$$LeaveBalanceDtoImplCopyWith(
    _$LeaveBalanceDtoImpl value,
    $Res Function(_$LeaveBalanceDtoImpl) then,
  ) = __$$LeaveBalanceDtoImplCopyWithImpl<$Res>;
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
class __$$LeaveBalanceDtoImplCopyWithImpl<$Res>
    extends _$LeaveBalanceDtoCopyWithImpl<$Res, _$LeaveBalanceDtoImpl>
    implements _$$LeaveBalanceDtoImplCopyWith<$Res> {
  __$$LeaveBalanceDtoImplCopyWithImpl(
    _$LeaveBalanceDtoImpl _value,
    $Res Function(_$LeaveBalanceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveBalanceDto
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
      _$LeaveBalanceDtoImpl(
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
class _$LeaveBalanceDtoImpl implements _LeaveBalanceDto {
  const _$LeaveBalanceDtoImpl({
    required this.employeeCode,
    required this.annualRemaining,
    required this.annualTotal,
    required this.sickRemaining,
  });

  factory _$LeaveBalanceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceDtoImplFromJson(json);

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
    return 'LeaveBalanceDto(employeeCode: $employeeCode, annualRemaining: $annualRemaining, annualTotal: $annualTotal, sickRemaining: $sickRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceDtoImpl &&
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

  /// Create a copy of LeaveBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceDtoImplCopyWith<_$LeaveBalanceDtoImpl> get copyWith =>
      __$$LeaveBalanceDtoImplCopyWithImpl<_$LeaveBalanceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceDtoImplToJson(this);
  }
}

abstract class _LeaveBalanceDto implements LeaveBalanceDto {
  const factory _LeaveBalanceDto({
    required final String employeeCode,
    required final int annualRemaining,
    required final int annualTotal,
    required final int sickRemaining,
  }) = _$LeaveBalanceDtoImpl;

  factory _LeaveBalanceDto.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceDtoImpl.fromJson;

  @override
  String get employeeCode;
  @override
  int get annualRemaining;
  @override
  int get annualTotal;
  @override
  int get sickRemaining;

  /// Create a copy of LeaveBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceDtoImplCopyWith<_$LeaveBalanceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessTripDto _$BusinessTripDtoFromJson(Map<String, dynamic> json) {
  return _BusinessTripDto.fromJson(json);
}

/// @nodoc
mixin _$BusinessTripDto {
  // ignore: invalid_annotation_target
  @JsonKey(name: '_id')
  String? get mongoId => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String get employeeCode => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessTripDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessTripDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessTripDtoCopyWith<BusinessTripDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessTripDtoCopyWith<$Res> {
  factory $BusinessTripDtoCopyWith(
    BusinessTripDto value,
    $Res Function(BusinessTripDto) then,
  ) = _$BusinessTripDtoCopyWithImpl<$Res, BusinessTripDto>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? mongoId,
    String? id,
    String employeeCode,
    String destination,
    String from,
    String to,
    String purpose,
    String status,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$BusinessTripDtoCopyWithImpl<$Res, $Val extends BusinessTripDto>
    implements $BusinessTripDtoCopyWith<$Res> {
  _$BusinessTripDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessTripDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mongoId = freezed,
    Object? id = freezed,
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
            mongoId: freezed == mongoId
                ? _value.mongoId
                : mongoId // ignore: cast_nullable_to_non_nullable
                      as String?,
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
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
                      as String,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as String,
            purpose: null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessTripDtoImplCopyWith<$Res>
    implements $BusinessTripDtoCopyWith<$Res> {
  factory _$$BusinessTripDtoImplCopyWith(
    _$BusinessTripDtoImpl value,
    $Res Function(_$BusinessTripDtoImpl) then,
  ) = __$$BusinessTripDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String? mongoId,
    String? id,
    String employeeCode,
    String destination,
    String from,
    String to,
    String purpose,
    String status,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$BusinessTripDtoImplCopyWithImpl<$Res>
    extends _$BusinessTripDtoCopyWithImpl<$Res, _$BusinessTripDtoImpl>
    implements _$$BusinessTripDtoImplCopyWith<$Res> {
  __$$BusinessTripDtoImplCopyWithImpl(
    _$BusinessTripDtoImpl _value,
    $Res Function(_$BusinessTripDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessTripDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mongoId = freezed,
    Object? id = freezed,
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
      _$BusinessTripDtoImpl(
        mongoId: freezed == mongoId
            ? _value.mongoId
            : mongoId // ignore: cast_nullable_to_non_nullable
                  as String?,
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as String,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String,
        purpose: null == purpose
            ? _value.purpose
            : purpose // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessTripDtoImpl implements _BusinessTripDto {
  const _$BusinessTripDtoImpl({
    @JsonKey(name: '_id') this.mongoId,
    this.id,
    required this.employeeCode,
    required this.destination,
    required this.from,
    required this.to,
    required this.purpose,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory _$BusinessTripDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessTripDtoImplFromJson(json);

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: '_id')
  final String? mongoId;
  @override
  final String? id;
  @override
  final String employeeCode;
  @override
  final String destination;
  @override
  final String from;
  @override
  final String to;
  @override
  final String purpose;
  @override
  final String status;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'BusinessTripDto(mongoId: $mongoId, id: $id, employeeCode: $employeeCode, destination: $destination, from: $from, to: $to, purpose: $purpose, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessTripDtoImpl &&
            (identical(other.mongoId, mongoId) || other.mongoId == mongoId) &&
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
    mongoId,
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

  /// Create a copy of BusinessTripDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessTripDtoImplCopyWith<_$BusinessTripDtoImpl> get copyWith =>
      __$$BusinessTripDtoImplCopyWithImpl<_$BusinessTripDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessTripDtoImplToJson(this);
  }
}

abstract class _BusinessTripDto implements BusinessTripDto {
  const factory _BusinessTripDto({
    @JsonKey(name: '_id') final String? mongoId,
    final String? id,
    required final String employeeCode,
    required final String destination,
    required final String from,
    required final String to,
    required final String purpose,
    required final String status,
    final String? createdAt,
    final String? updatedAt,
  }) = _$BusinessTripDtoImpl;

  factory _BusinessTripDto.fromJson(Map<String, dynamic> json) =
      _$BusinessTripDtoImpl.fromJson;

  // ignore: invalid_annotation_target
  @override
  @JsonKey(name: '_id')
  String? get mongoId;
  @override
  String? get id;
  @override
  String get employeeCode;
  @override
  String get destination;
  @override
  String get from;
  @override
  String get to;
  @override
  String get purpose;
  @override
  String get status;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of BusinessTripDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessTripDtoImplCopyWith<_$BusinessTripDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
