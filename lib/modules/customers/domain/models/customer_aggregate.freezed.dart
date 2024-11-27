// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomerAggregate {
  Customer get customer => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  List<License> get licenses => throw _privateConstructorUsedError;

  /// Create a copy of CustomerAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerAggregateCopyWith<CustomerAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerAggregateCopyWith<$Res> {
  factory $CustomerAggregateCopyWith(
          CustomerAggregate value, $Res Function(CustomerAggregate) then) =
      _$CustomerAggregateCopyWithImpl<$Res, CustomerAggregate>;
  @useResult
  $Res call(
      {Customer customer, List<Product> products, List<License> licenses});

  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class _$CustomerAggregateCopyWithImpl<$Res, $Val extends CustomerAggregate>
    implements $CustomerAggregateCopyWith<$Res> {
  _$CustomerAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = null,
    Object? products = null,
    Object? licenses = null,
  }) {
    return _then(_value.copyWith(
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      licenses: null == licenses
          ? _value.licenses
          : licenses // ignore: cast_nullable_to_non_nullable
              as List<License>,
    ) as $Val);
  }

  /// Create a copy of CustomerAggregate
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
abstract class _$$CustomerAggregateImplCopyWith<$Res>
    implements $CustomerAggregateCopyWith<$Res> {
  factory _$$CustomerAggregateImplCopyWith(_$CustomerAggregateImpl value,
          $Res Function(_$CustomerAggregateImpl) then) =
      __$$CustomerAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Customer customer, List<Product> products, List<License> licenses});

  @override
  $CustomerCopyWith<$Res> get customer;
}

/// @nodoc
class __$$CustomerAggregateImplCopyWithImpl<$Res>
    extends _$CustomerAggregateCopyWithImpl<$Res, _$CustomerAggregateImpl>
    implements _$$CustomerAggregateImplCopyWith<$Res> {
  __$$CustomerAggregateImplCopyWithImpl(_$CustomerAggregateImpl _value,
      $Res Function(_$CustomerAggregateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = null,
    Object? products = null,
    Object? licenses = null,
  }) {
    return _then(_$CustomerAggregateImpl(
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      licenses: null == licenses
          ? _value._licenses
          : licenses // ignore: cast_nullable_to_non_nullable
              as List<License>,
    ));
  }
}

/// @nodoc

class _$CustomerAggregateImpl extends _CustomerAggregate {
  const _$CustomerAggregateImpl(
      {required this.customer,
      required final List<Product> products,
      required final List<License> licenses})
      : _products = products,
        _licenses = licenses,
        super._();

  @override
  final Customer customer;
  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<License> _licenses;
  @override
  List<License> get licenses {
    if (_licenses is EqualUnmodifiableListView) return _licenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_licenses);
  }

  @override
  String toString() {
    return 'CustomerAggregate(customer: $customer, products: $products, licenses: $licenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerAggregateImpl &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._licenses, _licenses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      customer,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_licenses));

  /// Create a copy of CustomerAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerAggregateImplCopyWith<_$CustomerAggregateImpl> get copyWith =>
      __$$CustomerAggregateImplCopyWithImpl<_$CustomerAggregateImpl>(
          this, _$identity);
}

abstract class _CustomerAggregate extends CustomerAggregate {
  const factory _CustomerAggregate(
      {required final Customer customer,
      required final List<Product> products,
      required final List<License> licenses}) = _$CustomerAggregateImpl;
  const _CustomerAggregate._() : super._();

  @override
  Customer get customer;
  @override
  List<Product> get products;
  @override
  List<License> get licenses;

  /// Create a copy of CustomerAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerAggregateImplCopyWith<_$CustomerAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
