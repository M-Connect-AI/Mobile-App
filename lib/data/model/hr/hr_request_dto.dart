import 'package:freezed_annotation/freezed_annotation.dart';

part 'hr_request_dto.freezed.dart';
part 'hr_request_dto.g.dart';

@freezed
abstract class LeaveRequestDto with _$LeaveRequestDto {
  const factory LeaveRequestDto({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') String? mongoId,
    String? id,
    required String employeeCode,
    String? employeeName,
    required String type,
    required String from,
    required String to,
    required int days,
    required String reason,
    required String status,
    String? createdAt,
  }) = _LeaveRequestDto;

  factory LeaveRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestDtoFromJson(json);
}

@freezed
abstract class TripRequestDto with _$TripRequestDto {
  const factory TripRequestDto({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') String? mongoId,
    String? id,
    required String employeeCode,
    String? employeeName,
    required String destination,
    required String from,
    required String to,
    required String purpose,
    required String status,
    String? createdAt,
  }) = _TripRequestDto;

  factory TripRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TripRequestDtoFromJson(json);
}
