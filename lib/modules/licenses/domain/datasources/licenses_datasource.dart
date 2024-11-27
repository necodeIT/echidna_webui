import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Maps the license admin api endpoints.
abstract class LicensesDatasource extends Datasource {
  @override
  String get name => 'Licenses';

  /// Gets all licenses.
  Future<List<License>> getLicenses(String token);

  /// Gets a license by its key.
  Future<License> getLicense(String token, {required String licenseKey});

  /// Creates a new license.
  Future<License> createLicense(String token, {required String userId, required int customerId, required int productId});

  /// Updates a license.
  Future<License> updateLicense(String token, {required License license});

  /// Revokes a license.
  Future<void> revokeLicense(String token, {required String licenseKey, required String revocationReason});

  /// Gets the payment history of a license.
  Future<List<Payment>> getLicenseHistory(String token, {required String licenseKey});

  /// Gets the status of a license.
  Future<LicenseStatus> getLicenseStatus(String token, {required String licenseKey});
}
