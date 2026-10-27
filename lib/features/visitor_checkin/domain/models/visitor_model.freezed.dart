// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitorModel {

 String? get id; String get hostId; String? get hostName; String? get mobile; String get name; String? get email; String get purpose; String? get company; String? get photo; bool get consent; String? get checkInAt; String? get status; String? get badgeCode;
/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitorModelCopyWith<VisitorModel> get copyWith => _$VisitorModelCopyWithImpl<VisitorModel>(this as VisitorModel, _$identity);

  /// Serializes this VisitorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VisitorModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitorModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.hostId, _this.hostId) || other.hostId == _this.hostId)&&(identical(other.hostName, _this.hostName) || other.hostName == _this.hostName)&&(identical(other.mobile, _this.mobile) || other.mobile == _this.mobile)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.purpose, _this.purpose) || other.purpose == _this.purpose)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.photo, _this.photo) || other.photo == _this.photo)&&(identical(other.consent, _this.consent) || other.consent == _this.consent)&&(identical(other.checkInAt, _this.checkInAt) || other.checkInAt == _this.checkInAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.badgeCode, _this.badgeCode) || other.badgeCode == _this.badgeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VisitorModel;
  return Object.hash(runtimeType,_this.id,_this.hostId,_this.hostName,_this.mobile,_this.name,_this.email,_this.purpose,_this.company,_this.photo,_this.consent,_this.checkInAt,_this.status,_this.badgeCode);
}

@override
String toString() {
  final _this = this as VisitorModel;
  return 'VisitorModel(id: ${_this.id}, hostId: ${_this.hostId}, hostName: ${_this.hostName}, mobile: ${_this.mobile}, name: ${_this.name}, email: ${_this.email}, purpose: ${_this.purpose}, company: ${_this.company}, photo: ${_this.photo}, consent: ${_this.consent}, checkInAt: ${_this.checkInAt}, status: ${_this.status}, badgeCode: ${_this.badgeCode})';
}


}

/// @nodoc
abstract mixin class $VisitorModelCopyWith<$Res>  {
  factory $VisitorModelCopyWith(VisitorModel value, $Res Function(VisitorModel) _then) = _$VisitorModelCopyWithImpl;
@useResult
$Res call({
 String? id, String hostId, String? hostName, String? mobile, String name, String? email, String purpose, String? company, String? photo, bool consent, String? checkInAt, String? status, String? badgeCode
});




}
/// @nodoc
class _$VisitorModelCopyWithImpl<$Res>
    implements $VisitorModelCopyWith<$Res> {
  _$VisitorModelCopyWithImpl(this._self, this._then);

  final VisitorModel _self;
  final $Res Function(VisitorModel) _then;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? hostId = null,Object? hostName = freezed,Object? mobile = freezed,Object? name = null,Object? email = freezed,Object? purpose = null,Object? company = freezed,Object? photo = freezed,Object? consent = null,Object? checkInAt = freezed,Object? status = freezed,Object? badgeCode = freezed,}) {
  return _then(VisitorModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,hostName: freezed == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,consent: null == consent ? _self.consent : consent // ignore: cast_nullable_to_non_nullable
as bool,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,badgeCode: freezed == badgeCode ? _self.badgeCode : badgeCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitorModel].
extension VisitorModelPatterns on VisitorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitorModel value)  $default,){
final _that = this;
switch (_that) {
case _VisitorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitorModel value)?  $default,){
final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String hostId,  String? hostName,  String? mobile,  String name,  String? email,  String purpose,  String? company,  String? photo,  bool consent,  String? checkInAt,  String? status,  String? badgeCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
return $default(_that.id,_that.hostId,_that.hostName,_that.mobile,_that.name,_that.email,_that.purpose,_that.company,_that.photo,_that.consent,_that.checkInAt,_that.status,_that.badgeCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String hostId,  String? hostName,  String? mobile,  String name,  String? email,  String purpose,  String? company,  String? photo,  bool consent,  String? checkInAt,  String? status,  String? badgeCode)  $default,) {final _that = this;
switch (_that) {
case _VisitorModel():
return $default(_that.id,_that.hostId,_that.hostName,_that.mobile,_that.name,_that.email,_that.purpose,_that.company,_that.photo,_that.consent,_that.checkInAt,_that.status,_that.badgeCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String hostId,  String? hostName,  String? mobile,  String name,  String? email,  String purpose,  String? company,  String? photo,  bool consent,  String? checkInAt,  String? status,  String? badgeCode)?  $default,) {final _that = this;
switch (_that) {
case _VisitorModel() when $default != null:
return $default(_that.id,_that.hostId,_that.hostName,_that.mobile,_that.name,_that.email,_that.purpose,_that.company,_that.photo,_that.consent,_that.checkInAt,_that.status,_that.badgeCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisitorModel implements VisitorModel {
  const _VisitorModel({this.id, required this.hostId, this.hostName, this.mobile, required this.name, this.email, required this.purpose, this.company, this.photo, this.consent = true, this.checkInAt, this.status, this.badgeCode});
  factory _VisitorModel.fromJson(Map<String, dynamic> json) => _$VisitorModelFromJson(json);

@override final  String? id;
@override final  String hostId;
@override final  String? hostName;
@override final  String? mobile;
@override final  String name;
@override final  String? email;
@override final  String purpose;
@override final  String? company;
@override final  String? photo;
@override@JsonKey() final  bool consent;
@override final  String? checkInAt;
@override final  String? status;
@override final  String? badgeCode;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitorModelCopyWith<_VisitorModel> get copyWith => __$VisitorModelCopyWithImpl<_VisitorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitorModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.hostId, hostId) || other.hostId == hostId)&&(identical(other.hostName, hostName) || other.hostName == hostName)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.company, company) || other.company == company)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.consent, consent) || other.consent == consent)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.badgeCode, badgeCode) || other.badgeCode == badgeCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,hostId,hostName,mobile,name,email,purpose,company,photo,consent,checkInAt,status,badgeCode);
}

@override
String toString() {
    return 'VisitorModel(id: $id, hostId: $hostId, hostName: $hostName, mobile: $mobile, name: $name, email: $email, purpose: $purpose, company: $company, photo: $photo, consent: $consent, checkInAt: $checkInAt, status: $status, badgeCode: $badgeCode)';
}


}

/// @nodoc
abstract mixin class _$VisitorModelCopyWith<$Res> implements $VisitorModelCopyWith<$Res> {
  factory _$VisitorModelCopyWith(_VisitorModel value, $Res Function(_VisitorModel) _then) = __$VisitorModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String hostId, String? hostName, String? mobile, String name, String? email, String purpose, String? company, String? photo, bool consent, String? checkInAt, String? status, String? badgeCode
});




}
/// @nodoc
class __$VisitorModelCopyWithImpl<$Res>
    implements _$VisitorModelCopyWith<$Res> {
  __$VisitorModelCopyWithImpl(this._self, this._then);

  final _VisitorModel _self;
  final $Res Function(_VisitorModel) _then;

/// Create a copy of VisitorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? hostId = null,Object? hostName = freezed,Object? mobile = freezed,Object? name = null,Object? email = freezed,Object? purpose = null,Object? company = freezed,Object? photo = freezed,Object? consent = null,Object? checkInAt = freezed,Object? status = freezed,Object? badgeCode = freezed,}) {
  return _then(_VisitorModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,hostId: null == hostId ? _self.hostId : hostId // ignore: cast_nullable_to_non_nullable
as String,hostName: freezed == hostName ? _self.hostName : hostName // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,consent: null == consent ? _self.consent : consent // ignore: cast_nullable_to_non_nullable
as bool,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,badgeCode: freezed == badgeCode ? _self.badgeCode : badgeCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
