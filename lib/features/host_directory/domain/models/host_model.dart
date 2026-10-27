import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_model.freezed.dart';
part 'host_model.g.dart';

@freezed
abstract class HostModel with _$HostModel {
  const factory HostModel({
    required String id,
    required String name,
    required String department,
    required String email,
    String? phone, // Made optional because API response does not have phone
    String? designation, // Added from API
    String? floor, // Added from API
    @Default(true) bool available, // Added from API
    String? avatarUrl,
  }) = _HostModel;

  factory HostModel.fromJson(Map<String, dynamic> json) =>
      _$HostModelFromJson(json);
}
