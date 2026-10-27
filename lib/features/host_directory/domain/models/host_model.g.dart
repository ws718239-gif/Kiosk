// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HostModel _$HostModelFromJson(Map<String, dynamic> json) => _HostModel(
  id: json['id'] as String,
  name: json['name'] as String,
  department: json['department'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  designation: json['designation'] as String?,
  floor: json['floor'] as String?,
  available: json['available'] as bool? ?? true,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$HostModelToJson(_HostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'department': instance.department,
      'email': instance.email,
      'phone': instance.phone,
      'designation': instance.designation,
      'floor': instance.floor,
      'available': instance.available,
      'avatarUrl': instance.avatarUrl,
    };
