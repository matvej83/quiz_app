// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationModel {

 int get id; String get title; List<String> get text; int get level;
/// Create a copy of TranslationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationModelCopyWith<TranslationModel> get copyWith => _$TranslationModelCopyWithImpl<TranslationModel>(this as TranslationModel, _$identity);

  /// Serializes this TranslationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.text, text)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(text),level);

@override
String toString() {
  return 'TranslationModel(id: $id, title: $title, text: $text, level: $level)';
}


}

/// @nodoc
abstract mixin class $TranslationModelCopyWith<$Res>  {
  factory $TranslationModelCopyWith(TranslationModel value, $Res Function(TranslationModel) _then) = _$TranslationModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, List<String> text, int level
});




}
/// @nodoc
class _$TranslationModelCopyWithImpl<$Res>
    implements $TranslationModelCopyWith<$Res> {
  _$TranslationModelCopyWithImpl(this._self, this._then);

  final TranslationModel _self;
  final $Res Function(TranslationModel) _then;

/// Create a copy of TranslationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? text = null,Object? level = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as List<String>,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationModel].
extension TranslationModelPatterns on TranslationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationModel value)  $default,){
final _that = this;
switch (_that) {
case _TranslationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationModel value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  List<String> text,  int level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationModel() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  List<String> text,  int level)  $default,) {final _that = this;
switch (_that) {
case _TranslationModel():
return $default(_that.id,_that.title,_that.text,_that.level);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  List<String> text,  int level)?  $default,) {final _that = this;
switch (_that) {
case _TranslationModel() when $default != null:
return $default(_that.id,_that.title,_that.text,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationModel extends TranslationModel {
  const _TranslationModel({required this.id, required this.title, required final  List<String> text, required this.level}): _text = text,super._();
  factory _TranslationModel.fromJson(Map<String, dynamic> json) => _$TranslationModelFromJson(json);

@override final  int id;
@override final  String title;
 final  List<String> _text;
@override List<String> get text {
  if (_text is EqualUnmodifiableListView) return _text;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_text);
}

@override final  int level;

/// Create a copy of TranslationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationModelCopyWith<_TranslationModel> get copyWith => __$TranslationModelCopyWithImpl<_TranslationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._text, _text)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_text),level);

@override
String toString() {
  return 'TranslationModel(id: $id, title: $title, text: $text, level: $level)';
}


}

/// @nodoc
abstract mixin class _$TranslationModelCopyWith<$Res> implements $TranslationModelCopyWith<$Res> {
  factory _$TranslationModelCopyWith(_TranslationModel value, $Res Function(_TranslationModel) _then) = __$TranslationModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, List<String> text, int level
});




}
/// @nodoc
class __$TranslationModelCopyWithImpl<$Res>
    implements _$TranslationModelCopyWith<$Res> {
  __$TranslationModelCopyWithImpl(this._self, this._then);

  final _TranslationModel _self;
  final $Res Function(_TranslationModel) _then;

/// Create a copy of TranslationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? text = null,Object? level = null,}) {
  return _then(_TranslationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self._text : text // ignore: cast_nullable_to_non_nullable
as List<String>,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
