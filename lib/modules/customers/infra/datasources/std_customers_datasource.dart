import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/customers/customers.dart';

/// Standard implementation of [CustomersDatasource].
class StdCustomersDatasource extends CustomersDatasource {
  final ApiService _apiService;

  /// Standard implementation of [CustomersDatasource].
  StdCustomersDatasource(this._apiService);

  @override
  void dispose() {
    _apiService.dispose();
  }

  @override
  Future<Customer> createCustomer(String token, {required String name, required String email}) async {
    log('Creating new customer: $name, $email');

    try {
      final response = await _apiService.put(
        '/admin/customers',
        token: token,
        body: {
          'name': name,
          'email': email,
        },
      );
      response.raiseForStatusCode();

      final customer = Customer.fromJson(response.json);

      log('Successfully created customer with ID ${customer.id}');

      return customer;
    } catch (e, s) {
      log('Failed to create customer', e, s);
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomer(String token, {required int id}) async {
    log('Deleting Customer with ID $id');

    try {
      final response = await _apiService.delete('/admin/customers', pathParameter: id, token: token);

      response.raiseForStatusCode();

      log('Successfully deleted customer with ID $id');
    } catch (e, s) {
      log('Failed to delete customer with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<Customer> getCustomer(String token, {required int id}) async {
    log('Getting Customer with ID $id');

    try {
      final response = await _apiService.get('/admin/customers', pathParameter: id, token: token);
      response.raiseForStatusCode();

      final customer = Customer.fromJson(response.json);

      log('Successfully returned customer with ID $id');

      return customer;
    } catch (e, s) {
      log('Failed to get customer with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<Customer>> getCustomers(String token) async {
    log('Getting all customers');

    try {
      final response = await _apiService.get('/admin/customers', token: token);
      response.raiseForStatusCode();

      final customers = response.jsonList.map(Customer.fromJson).toList();

      log('Successfully returned ${customers.length} customers');

      return customers;
    } catch (e, s) {
      log('Failed to get customers', e, s);
      rethrow;
    }
  }

  @override
  Future<Customer> updateCustomer(String token, {required Customer customer}) async {
    log('Updating Customer with ID ${customer.id} to $customer');

    try {
      final response = await _apiService.patch('/admin/customers/', pathParameter: customer.id, token: token, body: customer.toJson());
      response.raiseForStatusCode();

      log('Successfully updated customer with ID ${customer.id}');

      return Customer.fromJson(response.json);
    } catch (e, s) {
      log('Failed to update customer with ID ${customer.id}', e, s);
      rethrow;
    }
  }
}
