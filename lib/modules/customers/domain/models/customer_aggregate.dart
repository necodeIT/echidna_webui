// ignore_for_file: invalid_annotation_target

import 'package:echidna_dto/echidna_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:echidna_webui/modules/customers/customers.dart';

part 'customer_aggregate.freezed.dart';

@freezed
class CustomerAggregate with _$CustomerAggregate {
  const factory CustomerAggregate({
    required Customer customer,
    required List<Product> products,
    required List<License> licenses,
  }) = _CustomerAggregate;

  const CustomerAggregate._();

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

extension SmartCustomer on List<Customer> {
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
