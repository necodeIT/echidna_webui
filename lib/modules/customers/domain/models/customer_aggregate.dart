// ignore_for_file: invalid_annotation_target

import 'package:echidna_dto/echidna_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_aggregate.freezed.dart';

/// An aggregate of a customer and their products and licenses.
@freezed
class CustomerAggregate with _$CustomerAggregate {
  /// An aggregate of a customer and their products and licenses.
  const factory CustomerAggregate({
    required Customer customer,
    required List<Product> products,
    required List<License> licenses,
  }) = _CustomerAggregate;

  const CustomerAggregate._();

  /// Joins the customer with their products and licenses.
  factory CustomerAggregate.join({
    required Customer customer,
    required List<Product> products,
    required List<License> licenses,
  }) =>
      CustomerAggregate(
        customer: customer,
        products: products.where((product) => licenses.any((l) => l.productId == product.id)).toList(),
        licenses: licenses.where((license) => license.customerId == customer.id).toList(),
      );
}

/// Extension methods for [List<Customer>].
extension SmartCustomer on List<Customer> {
  /// Connects the customers with their products and licenses.
  List<CustomerAggregate> connect(List<Product> products, List<License> licenses) {
    return map(
      (customer) => CustomerAggregate.join(
        customer: customer,
        products: products,
        licenses: licenses,
      ),
    ).toList();
  }
}
