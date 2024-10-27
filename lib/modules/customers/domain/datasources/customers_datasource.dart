import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides access to the customers stored in the database.
abstract class CustomersDatasource extends Datasource {
  @override
  String get name => 'Customers';

  /// Returns a list of all customers from the license server.
  Future<List<Customer>> getCustomers(String token);

  /// Returns a customer with the given [id] from the license server.
  Future<Customer> getCustomer(String token, {required int id});

  /// Creates a new customer on the license server.
  Future<Customer> createCustomer(String token, {required String name, required String email});

  /// Updates a customer on the license server.
  Future<Customer> updateCustomer(String token, {required Customer customer});

  /// Deletes a customer with the given [id] from the license server.
  Future<void> deleteCustomer(String token, {required int id});
}
