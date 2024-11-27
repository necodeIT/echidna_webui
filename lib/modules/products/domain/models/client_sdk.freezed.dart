// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_sdk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientSdk _$ClientSdkFromJson(Map<String, dynamic> json) {
  return _ClientSdk.fromJson(json);
}

/// @nodoc
mixin _$ClientSdk {
  /// Name of this client SDK.
  String get name => throw _privateConstructorUsedError;

  /// The framework this client SDK is for.
  ClientSdkFramework get framework => throw _privateConstructorUsedError;

  /// Installation instructions for this client SDK.
  ///
  /// Language -> Installation instructions (markdown format).
  @JsonKey(name: 'gettingStarted')
  Map<String, String> get guides => throw _privateConstructorUsedError;

  /// Serializes this ClientSdk to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientSdk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientSdkCopyWith<ClientSdk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientSdkCopyWith<$Res> {
  factory $ClientSdkCopyWith(ClientSdk value, $Res Function(ClientSdk) then) =
      _$ClientSdkCopyWithImpl<$Res, ClientSdk>;
  @useResult
  $Res call(
      {String name,
      ClientSdkFramework framework,
      @JsonKey(name: 'gettingStarted') Map<String, String> guides});
}

/// @nodoc
class _$ClientSdkCopyWithImpl<$Res, $Val extends ClientSdk>
    implements $ClientSdkCopyWith<$Res> {
  _$ClientSdkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientSdk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? framework = null,
    Object? guides = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      framework: null == framework
          ? _value.framework
          : framework // ignore: cast_nullable_to_non_nullable
              as ClientSdkFramework,
      guides: null == guides
          ? _value.guides
          : guides // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientSdkImplCopyWith<$Res>
    implements $ClientSdkCopyWith<$Res> {
  factory _$$ClientSdkImplCopyWith(
          _$ClientSdkImpl value, $Res Function(_$ClientSdkImpl) then) =
      __$$ClientSdkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      ClientSdkFramework framework,
      @JsonKey(name: 'gettingStarted') Map<String, String> guides});
}

/// @nodoc
class __$$ClientSdkImplCopyWithImpl<$Res>
    extends _$ClientSdkCopyWithImpl<$Res, _$ClientSdkImpl>
    implements _$$ClientSdkImplCopyWith<$Res> {
  __$$ClientSdkImplCopyWithImpl(
      _$ClientSdkImpl _value, $Res Function(_$ClientSdkImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClientSdk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? framework = null,
    Object? guides = null,
  }) {
    return _then(_$ClientSdkImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      framework: null == framework
          ? _value.framework
          : framework // ignore: cast_nullable_to_non_nullable
              as ClientSdkFramework,
      guides: null == guides
          ? _value._guides
          : guides // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientSdkImpl extends _ClientSdk {
  const _$ClientSdkImpl(
      {required this.name,
      required this.framework,
      @JsonKey(name: 'gettingStarted')
      required final Map<String, String> guides})
      : _guides = guides,
        super._();

  factory _$ClientSdkImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientSdkImplFromJson(json);

  /// Name of this client SDK.
  @override
  final String name;

  /// The framework this client SDK is for.
  @override
  final ClientSdkFramework framework;

  /// Installation instructions for this client SDK.
  ///
  /// Language -> Installation instructions (markdown format).
  final Map<String, String> _guides;

  /// Installation instructions for this client SDK.
  ///
  /// Language -> Installation instructions (markdown format).
  @override
  @JsonKey(name: 'gettingStarted')
  Map<String, String> get guides {
    if (_guides is EqualUnmodifiableMapView) return _guides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_guides);
  }

  @override
  String toString() {
    return 'ClientSdk(name: $name, framework: $framework, guides: $guides)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientSdkImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.framework, framework) ||
                other.framework == framework) &&
            const DeepCollectionEquality().equals(other._guides, _guides));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, framework,
      const DeepCollectionEquality().hash(_guides));

  /// Create a copy of ClientSdk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientSdkImplCopyWith<_$ClientSdkImpl> get copyWith =>
      __$$ClientSdkImplCopyWithImpl<_$ClientSdkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientSdkImplToJson(
      this,
    );
  }
}

abstract class _ClientSdk extends ClientSdk {
  const factory _ClientSdk(
      {required final String name,
      required final ClientSdkFramework framework,
      @JsonKey(name: 'gettingStarted')
      required final Map<String, String> guides}) = _$ClientSdkImpl;
  const _ClientSdk._() : super._();

  factory _ClientSdk.fromJson(Map<String, dynamic> json) =
      _$ClientSdkImpl.fromJson;

  /// Name of this client SDK.
  @override
  String get name;

  /// The framework this client SDK is for.
  @override
  ClientSdkFramework get framework;

  /// Installation instructions for this client SDK.
  ///
  /// Language -> Installation instructions (markdown format).
  @override
  @JsonKey(name: 'gettingStarted')
  Map<String, String> get guides;

  /// Create a copy of ClientSdk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientSdkImplCopyWith<_$ClientSdkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
