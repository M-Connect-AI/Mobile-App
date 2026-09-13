import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_models.freezed.dart';
part 'home_models.g.dart';

@freezed
abstract class LeaveBalanceDto with _$LeaveBalanceDto {
  const factory LeaveBalanceDto({
    required String employeeCode,
    required int annualRemaining,
    required int annualTotal,
    required int sickRemaining,
  }) = _LeaveBalanceDto;

  factory LeaveBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceDtoFromJson(json);
}

@freezed
abstract class BusinessTripDto with _$BusinessTripDto {
  const factory BusinessTripDto({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') String? mongoId,
    String? id,
    required String employeeCode,
    required String destination,
    required String from,
    required String to,
    required String purpose,
    required String status,
    String? createdAt,
    String? updatedAt,
  }) = _BusinessTripDto;

  factory BusinessTripDto.fromJson(Map<String, dynamic> json) =>
      _$BusinessTripDtoFromJson(json);
}
