// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HostModel {

 String get id; String get name; String get department; String get email; String? get phone; String? get designation; String? get floor; bool get available; String? get avatarUrl;
/// Create a copy of HostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostModelCopyWith<HostModel> get copyWith => _$HostModelCopyWithImpl<HostModel>(this as HostModel, _$identity);

  /// Serializes this HostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HostModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.department, _this.department) || other.department == _this.department)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.designation, _this.designation) || other.designation == _this.designation)&&(identical(other.floor, _this.floor) || other.floor == _this.floor)&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HostModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.department,_this.email,_this.phone,_this.designation,_this.floor,_this.available,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as HostModel;
  return 'HostModel(id: ${_this.id}, name: ${_this.name}, department: ${_this.department}, email: ${_this.email}, phone: ${_this.phone}, designation: ${_this.designation}, floor: ${_this.floor}, available: ${_this.available}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $HostModelCopyWith<$Res>  {
  factory $HostModelCopyWith(HostModel value, $Res Function(HostModel) _then) = _$HostModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String department, String email, String? phone, String? designation, String? floor, bool available, String? avatarUrl
});




}
/// @nodoc
class _$HostModelCopyWithImpl<$Res>
    implements $HostModelCopyWith<$Res> {
  _$HostModelCopyWithImpl(this._self, this._then);

  final HostModel _self;
  final $Res Function(HostModel) _then;

/// Create a copy of HostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? department = null,Object? email = null,Object? phone = freezed,Object? designation = freezed,Object? floor = freezed,Object? available = null,Object? avatarUrl = freezed,}) {
  return _then(HostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HostModel].
extension HostModelPatterns on HostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HostModel value)  $default,){
final _that = this;
switch (_that) {
case _HostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HostModel value)?  $default,){
final _that = this;
switch (_that) {
case _HostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String department,  String email,  String? phone,  String? designation,  String? floor,  bool available,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HostModel() when $default != null:
return $default(_that.id,_that.name,_that.department,_that.email,_that.phone,_that.designation,_that.floor,_that.available,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String department,  String email,  String? phone,  String? designation,  String? floor,  bool available,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _HostModel():
return $default(_that.id,_that.name,_that.department,_that.email,_that.phone,_that.designation,_that.floor,_that.available,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String department,  String email,  String? phone,  String? designation,  String? floor,  bool available,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _HostModel() when $default != null:
return $default(_that.id,_that.name,_that.department,_that.email,_that.phone,_that.designation,_that.floor,_that.available,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HostModel implements HostModel {
  const _HostModel({required this.id, required this.name, required this.department, required this.email, this.phone, this.designation, this.floor, this.available = true, this.avatarUrl});
  factory _HostModel.fromJson(Map<String, dynamic> json) => _$HostModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String department;
@override final  String email;
@override final  String? phone;
@override final  String? designation;
@override final  String? floor;
@override@JsonKey() final  bool available;
@override final  String? avatarUrl;

/// Create a copy of HostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostModelCopyWith<_HostModel> get copyWith => __$HostModelCopyWithImpl<_HostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.department, department) || other.department == department)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.available, available) || other.available == available)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,department,email,phone,designation,floor,available,avatarUrl);
}

@override
String toString() {
    return 'HostModel(id: $id, name: $name, department: $department, email: $email, phone: $phone, designation: $designation, floor: $floor, available: $available, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$HostModelCopyWith<$Res> implements $HostModelCopyWith<$Res> {
  factory _$HostModelCopyWith(_HostModel value, $Res Function(_HostModel) _then) = __$HostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String department, String email, String? phone, String? designation, String? floor, bool available, String? avatarUrl
});




}
/// @nodoc
class __$HostModelCopyWithImpl<$Res>
    implements _$HostModelCopyWith<$Res> {
  __$HostModelCopyWithImpl(this._self, this._then);

  final _HostModel _self;
  final $Res Function(_HostModel) _then;

/// Create a copy of HostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? department = null,Object? email = null,Object? phone = freezed,Object? designation = freezed,Object? floor = freezed,Object? available = null,Object? avatarUrl = freezed,}) {
  return _then(_HostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
