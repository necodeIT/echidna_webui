// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:license_server_rest/license_server_rest.dart';

part 'license_aggregate.freezed.dart';

/// Wraps a license with its product and customer.
@freezed
class LicenseAggregate with _$LicenseAggregate {
  /// Wraps a license with its product and customer.
  const factory LicenseAggregate({
    /// The license.
    required License license,

    /// The product associated with this license.
    required Product product,

    /// The customer associated with this license.
    required Customer customer,
  }) = _LicenseAggregate;

  const LicenseAggregate._();
}

/// Extension methods for [List<License>].
extension SmartLicense on List<License> {
  /// Joins the licenses with the given products and customers.
  List<LicenseAggregate> connect(List<Product> products, List<Customer> customers) {
    final productMap = Map.fromEntries(products.map((product) => MapEntry(product.id, product)));
    final customerMap = Map.fromEntries(customers.map((customer) => MapEntry(customer.id, customer)));

    return map(
      (license) => LicenseAggregate(
        license: license,
        product: productMap[license.productId]!,
        customer: customerMap[license.customerId]!,
      ),
    ).toList();
  }
}
