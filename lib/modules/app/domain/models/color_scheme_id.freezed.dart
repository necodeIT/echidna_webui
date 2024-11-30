// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_scheme_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ColorSchemeSerialization _$ColorSchemeSerializationFromJson(
    Map<String, dynamic> json) {
  return _ColorSchemeSerialization.fromJson(json);
}

/// @nodoc
mixin _$ColorSchemeSerialization {
  ColorSchemeId get id => throw _privateConstructorUsedError;

  /// Serializes this ColorSchemeSerialization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorSchemeSerialization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColorSchemeSerializationCopyWith<ColorSchemeSerialization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorSchemeSerializationCopyWith<$Res> {
  factory $ColorSchemeSerializationCopyWith(ColorSchemeSerialization value,
          $Res Function(ColorSchemeSerialization) then) =
      _$ColorSchemeSerializationCopyWithImpl<$Res, ColorSchemeSerialization>;
  @useResult
  $Res call({ColorSchemeId id});
}

/// @nodoc
class _$ColorSchemeSerializationCopyWithImpl<$Res,
        $Val extends ColorSchemeSerialization>
    implements $ColorSchemeSerializationCopyWith<$Res> {
  _$ColorSchemeSerializationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorSchemeSerialization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ColorSchemeId,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColorSchemeSerializationImplCopyWith<$Res>
    implements $ColorSchemeSerializationCopyWith<$Res> {
  factory _$$ColorSchemeSerializationImplCopyWith(
          _$ColorSchemeSerializationImpl value,
          $Res Function(_$ColorSchemeSerializationImpl) then) =
      __$$ColorSchemeSerializationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ColorSchemeId id});
}

/// @nodoc
class __$$ColorSchemeSerializationImplCopyWithImpl<$Res>
    extends _$ColorSchemeSerializationCopyWithImpl<$Res,
        _$ColorSchemeSerializationImpl>
    implements _$$ColorSchemeSerializationImplCopyWith<$Res> {
  __$$ColorSchemeSerializationImplCopyWithImpl(
      _$ColorSchemeSerializationImpl _value,
      $Res Function(_$ColorSchemeSerializationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColorSchemeSerialization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ColorSchemeSerializationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ColorSchemeId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorSchemeSerializationImpl extends _ColorSchemeSerialization {
  const _$ColorSchemeSerializationImpl({required this.id}) : super._();

  factory _$ColorSchemeSerializationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorSchemeSerializationImplFromJson(json);

  @override
  final ColorSchemeId id;

  @override
  String toString() {
    return 'ColorSchemeSerialization(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorSchemeSerializationImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ColorSchemeSerialization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorSchemeSerializationImplCopyWith<_$ColorSchemeSerializationImpl>
      get copyWith => __$$ColorSchemeSerializationImplCopyWithImpl<
          _$ColorSchemeSerializationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorSchemeSerializationImplToJson(
      this,
    );
  }
}

abstract class _ColorSchemeSerialization extends ColorSchemeSerialization {
  const factory _ColorSchemeSerialization({required final ColorSchemeId id}) =
      _$ColorSchemeSerializationImpl;
  const _ColorSchemeSerialization._() : super._();

  factory _ColorSchemeSerialization.fromJson(Map<String, dynamic> json) =
      _$ColorSchemeSerializationImpl.fromJson;

  @override
  ColorSchemeId get id;

  /// Create a copy of ColorSchemeSerialization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorSchemeSerializationImplCopyWith<_$ColorSchemeSerializationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
