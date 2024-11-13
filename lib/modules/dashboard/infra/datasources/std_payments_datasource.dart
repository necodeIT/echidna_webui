import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:license_server_admin_panel/modules/dashboard/dashboard.dart';
import 'package:license_server_rest/license_server_rest.dart';

/// Standart Implementation of [PaymentsDatasource]
class StdPaymentsDatasource extends PaymentsDatasource {
  final ApiService _apiService;

  /// Standart Implementation of [PaymentsDatasource]
  StdPaymentsDatasource(this._apiService);

  @override
  void dispose() {
    _apiService.dispose();
  }

  @override
  Future<Payment> getPayment(String token, {required int id}) async {
    log('Getting Payment with ID $id');

    try {
      final response = await _apiService.get('/admin/payments', pathParameter: id, token: token);
      response.raiseForStatusCode();

      final payment = Payment.fromJson(response.json);

      log('Successfully returned payment with ID $id');

      return payment;
    } catch (e, s) {
      log('Failed to get payment with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<Payment>> getPayments(String token) async {
    log('Getting all payments');

    try {
      final response = await _apiService.get('/admin/payments', token: token);
      response.raiseForStatusCode();

      final payments = response.jsonList.map(Payment.fromJson).toList();
      log('Successfully returned all payments');

      return payments;
    } catch (e, s) {
      log('Failed to get all payments', e, s);
      rethrow;
    }
  }
}