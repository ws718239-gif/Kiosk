// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisitorModel _$VisitorModelFromJson(Map<String, dynamic> json) =>
    _VisitorModel(
      id: json['id'] as String?,
      hostId: json['hostId'] as String,
      hostName: json['hostName'] as String?,
      mobile: json['mobile'] as String?,
      name: json['name'] as String,
      email: json['email'] as String?,
      purpose: json['purpose'] as String,
      company: json['company'] as String?,
      photo: json['photo'] as String?,
      consent: json['consent'] as bool? ?? true,
      checkInAt: json['checkInAt'] as String?,
      status: json['status'] as String?,
      badgeCode: json['badgeCode'] as String?,
    );

Map<String, dynamic> _$VisitorModelToJson(_VisitorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostId': instance.hostId,
      'hostName': instance.hostName,
      'mobile': instance.mobile,
      'name': instance.name,
      'email': instance.email,
      'purpose': instance.purpose,
      'company': instance.company,
      'photo': instance.photo,
      'consent': instance.consent,
      'checkInAt': instance.checkInAt,
      'status': instance.status,
      'badgeCode': instance.badgeCode,
    };
