import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor_model.freezed.dart';
part 'visitor_model.g.dart';

@freezed
abstract class VisitorModel with _$VisitorModel {
  const factory VisitorModel({
    String? id, // Usually returned by the backend after creation
    required String hostId,
    String? hostName, // API might require/return this
    String? mobile, // Replaced phone with mobile based on API requirements
    required String name,
    String? email,
    required String purpose,
    String? company,
    String? photo, // Changed from photoBase64 to photo to match API
    @Default(true) bool consent, // Changed from consentGiven to consent
    String? checkInAt, // Changed from checkInTime
    String? status, // Added missing status field from API
    String? badgeCode, // Badge returned by API
  }) = _VisitorModel;

  factory VisitorModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorModelFromJson(json);
}
