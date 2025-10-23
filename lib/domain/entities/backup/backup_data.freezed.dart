// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupData {

 String get version; DateTime get backupDate; BackupUser get user; BackupSettings get settings; BackupStat? get stat; List<BackupJournal> get journals; List<BackupActivity> get activities; Map<String, String> get images;
/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupDataCopyWith<BackupData> get copyWith => _$BackupDataCopyWithImpl<BackupData>(this as BackupData, _$identity);

  /// Serializes this BackupData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupData&&(identical(other.version, version) || other.version == version)&&(identical(other.backupDate, backupDate) || other.backupDate == backupDate)&&(identical(other.user, user) || other.user == user)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stat, stat) || other.stat == stat)&&const DeepCollectionEquality().equals(other.journals, journals)&&const DeepCollectionEquality().equals(other.activities, activities)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,backupDate,user,settings,stat,const DeepCollectionEquality().hash(journals),const DeepCollectionEquality().hash(activities),const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'BackupData(version: $version, backupDate: $backupDate, user: $user, settings: $settings, stat: $stat, journals: $journals, activities: $activities, images: $images)';
}


}

/// @nodoc
abstract mixin class $BackupDataCopyWith<$Res>  {
  factory $BackupDataCopyWith(BackupData value, $Res Function(BackupData) _then) = _$BackupDataCopyWithImpl;
@useResult
$Res call({
 String version, DateTime backupDate, BackupUser user, BackupSettings settings, BackupStat? stat, List<BackupJournal> journals, List<BackupActivity> activities, Map<String, String> images
});


$BackupUserCopyWith<$Res> get user;$BackupSettingsCopyWith<$Res> get settings;$BackupStatCopyWith<$Res>? get stat;

}
/// @nodoc
class _$BackupDataCopyWithImpl<$Res>
    implements $BackupDataCopyWith<$Res> {
  _$BackupDataCopyWithImpl(this._self, this._then);

  final BackupData _self;
  final $Res Function(BackupData) _then;

/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? backupDate = null,Object? user = null,Object? settings = null,Object? stat = freezed,Object? journals = null,Object? activities = null,Object? images = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,backupDate: null == backupDate ? _self.backupDate : backupDate // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as BackupUser,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as BackupSettings,stat: freezed == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as BackupStat?,journals: null == journals ? _self.journals : journals // ignore: cast_nullable_to_non_nullable
as List<BackupJournal>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<BackupActivity>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupUserCopyWith<$Res> get user {
  
  return $BackupUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<$Res> get settings {
  
  return $BackupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupStatCopyWith<$Res>? get stat {
    if (_self.stat == null) {
    return null;
  }

  return $BackupStatCopyWith<$Res>(_self.stat!, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}


/// Adds pattern-matching-related methods to [BackupData].
extension BackupDataPatterns on BackupData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupData value)  $default,){
final _that = this;
switch (_that) {
case _BackupData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupData value)?  $default,){
final _that = this;
switch (_that) {
case _BackupData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  DateTime backupDate,  BackupUser user,  BackupSettings settings,  BackupStat? stat,  List<BackupJournal> journals,  List<BackupActivity> activities,  Map<String, String> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupData() when $default != null:
return $default(_that.version,_that.backupDate,_that.user,_that.settings,_that.stat,_that.journals,_that.activities,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  DateTime backupDate,  BackupUser user,  BackupSettings settings,  BackupStat? stat,  List<BackupJournal> journals,  List<BackupActivity> activities,  Map<String, String> images)  $default,) {final _that = this;
switch (_that) {
case _BackupData():
return $default(_that.version,_that.backupDate,_that.user,_that.settings,_that.stat,_that.journals,_that.activities,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  DateTime backupDate,  BackupUser user,  BackupSettings settings,  BackupStat? stat,  List<BackupJournal> journals,  List<BackupActivity> activities,  Map<String, String> images)?  $default,) {final _that = this;
switch (_that) {
case _BackupData() when $default != null:
return $default(_that.version,_that.backupDate,_that.user,_that.settings,_that.stat,_that.journals,_that.activities,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupData implements BackupData {
  const _BackupData({required this.version, required this.backupDate, required this.user, required this.settings, this.stat, required final  List<BackupJournal> journals, required final  List<BackupActivity> activities, required final  Map<String, String> images}): _journals = journals,_activities = activities,_images = images;
  factory _BackupData.fromJson(Map<String, dynamic> json) => _$BackupDataFromJson(json);

@override final  String version;
@override final  DateTime backupDate;
@override final  BackupUser user;
@override final  BackupSettings settings;
@override final  BackupStat? stat;
 final  List<BackupJournal> _journals;
@override List<BackupJournal> get journals {
  if (_journals is EqualUnmodifiableListView) return _journals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_journals);
}

 final  List<BackupActivity> _activities;
@override List<BackupActivity> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

 final  Map<String, String> _images;
@override Map<String, String> get images {
  if (_images is EqualUnmodifiableMapView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_images);
}


/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupDataCopyWith<_BackupData> get copyWith => __$BackupDataCopyWithImpl<_BackupData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupData&&(identical(other.version, version) || other.version == version)&&(identical(other.backupDate, backupDate) || other.backupDate == backupDate)&&(identical(other.user, user) || other.user == user)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.stat, stat) || other.stat == stat)&&const DeepCollectionEquality().equals(other._journals, _journals)&&const DeepCollectionEquality().equals(other._activities, _activities)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,backupDate,user,settings,stat,const DeepCollectionEquality().hash(_journals),const DeepCollectionEquality().hash(_activities),const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'BackupData(version: $version, backupDate: $backupDate, user: $user, settings: $settings, stat: $stat, journals: $journals, activities: $activities, images: $images)';
}


}

/// @nodoc
abstract mixin class _$BackupDataCopyWith<$Res> implements $BackupDataCopyWith<$Res> {
  factory _$BackupDataCopyWith(_BackupData value, $Res Function(_BackupData) _then) = __$BackupDataCopyWithImpl;
@override @useResult
$Res call({
 String version, DateTime backupDate, BackupUser user, BackupSettings settings, BackupStat? stat, List<BackupJournal> journals, List<BackupActivity> activities, Map<String, String> images
});


@override $BackupUserCopyWith<$Res> get user;@override $BackupSettingsCopyWith<$Res> get settings;@override $BackupStatCopyWith<$Res>? get stat;

}
/// @nodoc
class __$BackupDataCopyWithImpl<$Res>
    implements _$BackupDataCopyWith<$Res> {
  __$BackupDataCopyWithImpl(this._self, this._then);

  final _BackupData _self;
  final $Res Function(_BackupData) _then;

/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? backupDate = null,Object? user = null,Object? settings = null,Object? stat = freezed,Object? journals = null,Object? activities = null,Object? images = null,}) {
  return _then(_BackupData(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,backupDate: null == backupDate ? _self.backupDate : backupDate // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as BackupUser,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as BackupSettings,stat: freezed == stat ? _self.stat : stat // ignore: cast_nullable_to_non_nullable
as BackupStat?,journals: null == journals ? _self._journals : journals // ignore: cast_nullable_to_non_nullable
as List<BackupJournal>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<BackupActivity>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupUserCopyWith<$Res> get user {
  
  return $BackupUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<$Res> get settings {
  
  return $BackupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of BackupData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupStatCopyWith<$Res>? get stat {
    if (_self.stat == null) {
    return null;
  }

  return $BackupStatCopyWith<$Res>(_self.stat!, (value) {
    return _then(_self.copyWith(stat: value));
  });
}
}

// dart format on
