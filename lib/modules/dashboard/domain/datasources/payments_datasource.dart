import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Maps the payments api endpoints.
abstract class PaymentsDatasource extends Datasource {
  @override
  String get name => 'Payments';

  /// Gets a payment by its id.
  Future<Payment> getPayment(String token, {required int id});

  /// Gets all payments.
  Future<List<Payment>> getPayments(String token);
}
