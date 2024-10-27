import 'dart:async';

import 'package:collection/collection.dart';
import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides a list of all customers.
class CustomersRepository extends Repository<AsyncValue<List<Customer>>> {
  final CustomersDatasource _datasource;
  final TokenRepository _tokenRepository;

  /// Provides a list of all customers.
  CustomersRepository(this._datasource, this._tokenRepository) : super(AsyncValue.loading()) {
    watchAsync(_tokenRepository);
  }

  @override
  FutureOr<void> build(Type trigger) async {
    log('Loading customers');

    return guard(
      () => _datasource.getCustomers(_tokenRepository.state.requireData.token),
      onData: (customers) {
        log('Loaded customers: $customers');

        data(customers);
      },
      onError: (e, s) {
        log('Failed to load customers', e, s);

        error('Failed to load customers');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _datasource.dispose();
  }

  /// Creates a new customer.
  Future<void> createCustomer({required String name, required String email}) async {
    log('Creating new customer: $name, $email');

    if (!state.hasData) {
      log('Cannot create customer: ${state.error}');

      return;
    }

    try {
      final customer = await _datasource.createCustomer(_tokenRepository.state.requireData.token, name: name, email: email);

      log('Successfully created customer with ID ${customer.id}');

      data([...state.requireData, customer]);
    } catch (e, s) {
      log('Failed to create customer', e, s);

      rethrow;
    }
  }

  /// Updates a customer with the given [id] to the new [name] and [email].
  Future<void> updateCustomer({
    required int id,
    String? name,
    String? email,
  }) async {
    log('Updating customer with ID $id');

    if (!state.hasData) {
      log('Cannot update customer: ${state.error}');

      return;
    }

    try {
      final old = state.requireData.firstWhere((customer) => customer.id == id);

      if (old.name == name && old.email == email) {
        log('No changes detected. Skipping update');

        return;
      }

      final customer = await _datasource.updateCustomer(
        _tokenRepository.state.requireData.token,
        customer: old.copyWith(
          name: name ?? old.name,
          email: email ?? old.email,
        ),
      );

      log('Successfully updated customer with ID $id');

      data(state.requireData.map((c) => c.id == id ? customer : c).toList());
    } catch (e, s) {
      log('Failed to update customer with ID $id', e, s);

      rethrow;
    }
  }

  /// Deletes a customer with the given [id].
  Future<void> deleteCustomer(int id) async {
    log('Deleting Customer with ID $id');

    if (!state.hasData) {
      log('Cannot delete customer: ${state.error}');

      return;
    }

    try {
      await _datasource.deleteCustomer(_tokenRepository.state.requireData.token, id: id);

      log('Successfully deleted customer with ID $id');

      data(state.requireData.where((customer) => customer.id != id).toList());
    } catch (e, s) {
      log('Failed to delete customer with ID $id', e, s);

      rethrow;
    }
  }

  /// Filters the customers by [name] and [email].
  ///
  /// Only provided parameters will be used for filtering.
  ///
  /// Filter is case-insensitive and checks if the provided string is a substring of the customer's name or email respectively.
  List<Customer> filter({String? name, String? email}) {
    if (!state.hasData) {
      return [];
    }

    return state.requireData.where((customer) {
      if (name != null && !customer.name.containsIgnoreCase(name)) {
        return false;
      }

      if (email != null && !customer.email.containsIgnoreCase(email)) {
        return false;
      }

      return true;
    }).toList();
  }

  /// Searches the customers by [query].
  ///
  /// Search is case-insensitive and checks if the provided string is a substring of the customer's name or email.
  List<Customer> search(String query) {
    if (!state.hasData) {
      return [];
    }

    return state.requireData.where((customer) {
      return customer.name.containsIgnoreCase(query) || customer.email.containsIgnoreCase(query);
    }).toList();
  }

  /// Returns the customer with the given [id].
  ///
  /// Returns `null` if the customer with the given [id] does not exist.
  Customer? byId(int id) {
    if (!state.hasData) {
      return null;
    }

    return state.requireData.firstWhereOrNull((customer) => customer.id == id);
  }
}
