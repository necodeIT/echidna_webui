// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductAggregate {
  /// The product.
  Product get product => throw _privateConstructorUsedError;

  /// Licenses associated with the product.
  List<License> get licenses => throw _privateConstructorUsedError;

  /// Customers who have licenses for the product.
  List<Customer> get customers => throw _privateConstructorUsedError;

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductAggregateCopyWith<ProductAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductAggregateCopyWith<$Res> {
  factory $ProductAggregateCopyWith(
          ProductAggregate value, $Res Function(ProductAggregate) then) =
      _$ProductAggregateCopyWithImpl<$Res, ProductAggregate>;
  @useResult
  $Res call(
      {Product product, List<License> licenses, List<Customer> customers});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$ProductAggregateCopyWithImpl<$Res, $Val extends ProductAggregate>
    implements $ProductAggregateCopyWith<$Res> {
  _$ProductAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? licenses = null,
    Object? customers = null,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      licenses: null == licenses
          ? _value.licenses
          : licenses // ignore: cast_nullable_to_non_nullable
              as List<License>,
      customers: null == customers
          ? _value.customers
          : customers // ignore: cast_nullable_to_non_nullable
              as List<Customer>,
    ) as $Val);
  }

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductAggregateImplCopyWith<$Res>
    implements $ProductAggregateCopyWith<$Res> {
  factory _$$ProductAggregateImplCopyWith(_$ProductAggregateImpl value,
          $Res Function(_$ProductAggregateImpl) then) =
      __$$ProductAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Product product, List<License> licenses, List<Customer> customers});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$ProductAggregateImplCopyWithImpl<$Res>
    extends _$ProductAggregateCopyWithImpl<$Res, _$ProductAggregateImpl>
    implements _$$ProductAggregateImplCopyWith<$Res> {
  __$$ProductAggregateImplCopyWithImpl(_$ProductAggregateImpl _value,
      $Res Function(_$ProductAggregateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? licenses = null,
    Object? customers = null,
  }) {
    return _then(_$ProductAggregateImpl(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      licenses: null == licenses
          ? _value._licenses
          : licenses // ignore: cast_nullable_to_non_nullable
              as List<License>,
      customers: null == customers
          ? _value._customers
          : customers // ignore: cast_nullable_to_non_nullable
              as List<Customer>,
    ));
  }
}

/// @nodoc

class _$ProductAggregateImpl extends _ProductAggregate {
  const _$ProductAggregateImpl(
      {required this.product,
      required final List<License> licenses,
      required final List<Customer> customers})
      : _licenses = licenses,
        _customers = customers,
        super._();

  /// The product.
  @override
  final Product product;

  /// Licenses associated with the product.
  final List<License> _licenses;

  /// Licenses associated with the product.
  @override
  List<License> get licenses {
    if (_licenses is EqualUnmodifiableListView) return _licenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_licenses);
  }

  /// Customers who have licenses for the product.
  final List<Customer> _customers;

  /// Customers who have licenses for the product.
  @override
  List<Customer> get customers {
    if (_customers is EqualUnmodifiableListView) return _customers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customers);
  }

  @override
  String toString() {
    return 'ProductAggregate(product: $product, licenses: $licenses, customers: $customers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductAggregateImpl &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality().equals(other._licenses, _licenses) &&
            const DeepCollectionEquality()
                .equals(other._customers, _customers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      product,
      const DeepCollectionEquality().hash(_licenses),
      const DeepCollectionEquality().hash(_customers));

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductAggregateImplCopyWith<_$ProductAggregateImpl> get copyWith =>
      __$$ProductAggregateImplCopyWithImpl<_$ProductAggregateImpl>(
          this, _$identity);
}

abstract class _ProductAggregate extends ProductAggregate {
  const factory _ProductAggregate(
      {required final Product product,
      required final List<License> licenses,
      required final List<Customer> customers}) = _$ProductAggregateImpl;
  const _ProductAggregate._() : super._();

  /// The product.
  @override
  Product get product;

  /// Licenses associated with the product.
  @override
  List<License> get licenses;

  /// Customers who have licenses for the product.
  @override
  List<Customer> get customers;

  /// Create a copy of ProductAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductAggregateImplCopyWith<_$ProductAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
