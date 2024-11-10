// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:license_server_rest/license_server_rest.dart';

part 'product_aggregate.freezed.dart';

/// Aggregates a product with its licenses and customers.
@freezed
class ProductAggregate with _$ProductAggregate {
  /// Aggregates a product with its licenses and customers.
  const factory ProductAggregate({
    /// The product.
    required Product product,

    /// Licenses associated with the product.
    required List<License> licenses,

    /// Customers who have licenses for the product.
    required List<Customer> customers,
  }) = _ProductAggregate;

  const ProductAggregate._();

  /// Creates a product aggregate from a product, licenses, and customers.
  factory ProductAggregate.join({
    required Product product,
    required List<License> licenses,
    required List<Customer> customers,
  }) =>
      ProductAggregate(
        product: product,
        licenses: licenses.where((license) => license.productId == product.id).toList(),
        customers: customers.where((customer) => licenses.any((l) => l.customerId == customer.id)).toList(),
      );
}

/// Extends [List] with a method to connect products with licenses and customers.
extension SmartProduct on List<Product> {
  /// Connects products with licenses and customers.
  List<ProductAggregate> connect(List<License> licenses, List<Customer> customers) {
    return map(
      (product) => ProductAggregate.join(
        product: product,
        licenses: licenses,
        customers: customers,
      ),
    ).toList();
  }
}
