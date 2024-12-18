// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LicenseAggregate {
  /// The license.
  License get license => throw _privateConstructorUsedError;

  /// The product associated with this license.
  Product get product => throw _privateConstructorUsedError;

  /// The customer associated with this license.
  Customer get customer => throw _privateConstructorUsedError;

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LicenseAggregateCopyWith<LicenseAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LicenseAggregateCopyWith<$Res> {
  factory $LicenseAggregateCopyWith(
          LicenseAggregate value, $Res Function(LicenseAggregate) then) =
      _$LicenseAggregateCopyWithImpl<$Res, LicenseAggregate>;
  @useResult
  $Res call({License license, Product product, Customer customer});

  $LicenseCopyWith<$Res> get license;
  $ProductCopyWith<$Res> get product;
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$LicenseAggregateCopyWithImpl<$Res, $Val extends LicenseAggregate>
    implements $LicenseAggregateCopyWith<$Res> {
  _$LicenseAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? license = null,
    Object? product = null,
    Object? customer = null,
  }) {
    return _then(_value.copyWith(
      license: null == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as License,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
    ) as $Val);
  }

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LicenseCopyWith<$Res> get license {
    return $LicenseCopyWith<$Res>(_value.license, (value) {
      return _then(_value.copyWith(license: value) as $Val);
    });
  }

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res> get customer {
    return $CustomerCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LicenseAggregateImplCopyWith<$Res>
    implements $LicenseAggregateCopyWith<$Res> {
  factory _$$LicenseAggregateImplCopyWith(_$LicenseAggregateImpl value,
          $Res Function(_$LicenseAggregateImpl) then) =
      __$$LicenseAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({License license, Product product, Customer customer});

  @override
  $LicenseCopyWith<$Res> get license;
  @override
  $ProductCopyWith<$Res> get product;
  @override
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$LicenseAggregateImplCopyWithImpl<$Res>
    extends _$LicenseAggregateCopyWithImpl<$Res, _$LicenseAggregateImpl>
    implements _$$LicenseAggregateImplCopyWith<$Res> {
  __$$LicenseAggregateImplCopyWithImpl(_$LicenseAggregateImpl _value,
      $Res Function(_$LicenseAggregateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? license = null,
    Object? product = null,
    Object? customer = null,
  }) {
    return _then(_$LicenseAggregateImpl(
      license: null == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as License,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
    ));
  }
}

/// @nodoc

class _$LicenseAggregateImpl extends _LicenseAggregate {
  const _$LicenseAggregateImpl(
      {required this.license, required this.product, required this.customer})
      : super._();

  /// The license.
  @override
  final License license;

  /// The product associated with this license.
  @override
  final Product product;

  /// The customer associated with this license.
  @override
  final Customer customer;

  @override
  String toString() {
    return 'LicenseAggregate(license: $license, product: $product, customer: $customer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LicenseAggregateImpl &&
            (identical(other.license, license) || other.license == license) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.customer, customer) ||
                other.customer == customer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, license, product, customer);

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LicenseAggregateImplCopyWith<_$LicenseAggregateImpl> get copyWith =>
      __$$LicenseAggregateImplCopyWithImpl<_$LicenseAggregateImpl>(
          this, _$identity);
}

abstract class _LicenseAggregate extends LicenseAggregate {
  const factory _LicenseAggregate(
      {required final License license,
      required final Product product,
      required final Customer customer}) = _$LicenseAggregateImpl;
  const _LicenseAggregate._() : super._();

  /// The license.
  @override
  License get license;

  /// The product associated with this license.
  @override
  Product get product;

  /// The customer associated with this license.
  @override
  Customer get customer;

  /// Create a copy of LicenseAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LicenseAggregateImplCopyWith<_$LicenseAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
