import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';

/// Standart Implementation of [LicensesDatasource]
class StdLicensesDatasource extends LicensesDatasource {
  final ApiService _apiService;

  /// Standart Implementation of [LicensesDatasource]
  StdLicensesDatasource(this._apiService);

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }

  @override
  Future<License> createLicense(String token, {required String userId, required int customerId, required int productId}) async {
    log('Creating new License: $userId, $customerId, $productId');

    try {
      final response = await _apiService.put(
        '/admin/licenses',
        token: token,
        body: {
          'userId': userId,
          'customerId': customerId,
          'productId': productId,
        },
      );
      response.raiseForStatusCode();

      final license = License.fromJson(response.json);
      log('Successfully created license with ID ${license.licenseKey}');

      return license;
    } catch (e, s) {
      log('Failed to create license', e, s);
      rethrow;
    }
  }

  @override
  Future<License> getLicense(String token, {required String licenseKey}) async {
    log('Getting License with ID $licenseKey');

    try {
      final response = await _apiService.get(
        '/admin/licenses',
        pathParameter: licenseKey,
        token: token,
      );
      response.raiseForStatusCode();

      final license = License.fromJson(response.json);

      log('Successfully returned license with ID ${license.licenseKey}');

      return license;
    } catch (e, s) {
      log('Failed to get license', e, s);
      rethrow;
    }
  }

  @override
  Future<List<Payment>> getLicenseHistory(String token, {required String licenseKey}) async {
    log('Getting all payments associated with license $licenseKey');

    try {
      final response = await _apiService.get(
        'admin/licenses/history',
        pathParameter: licenseKey,
        token: token,
      );
      response.raiseForStatusCode();

      final payments = response.jsonList.map(Payment.fromJson).toList();

      log('Successfully returned all payments associated with license $licenseKey');

      return payments;
    } catch (e, s) {
      log('Failed to get payments associated with license $licenseKey', e, s);
      rethrow;
    }
  }

  @override
  Future<List<License>> getLicenses(String token) async {
    log('Getting all licenses');

    try {
      final response = await _apiService.get('/admin/licenses', token: token);
      response.raiseForStatusCode();

      final licenses = response.jsonList.map(License.fromJson).toList();

      log('Successfully returned ${licenses.length} licenses');

      return licenses;
    } catch (e, s) {
      log('Failed to return all licenses', e, s);
      rethrow;
    }
  }

  @override
  Future<void> revokeLicense(String token, {required String licenseKey, required String revocationReason}) async {
    log('Revoking license $licenseKey with reason: $revocationReason');

    try {
      final response = await _apiService.post(
        '/admin/licenses/revoke',
        pathParameter: licenseKey,
        token: token,
        body: {'reason': revocationReason},
      );
      response.raiseForStatusCode();

      log('Successfully revoked license $licenseKey with reason: $revocationReason');
    } catch (e, s) {
      log('Failed to revoke license $licenseKey', e, s);
      rethrow;
    }
  }

  @override
  Future<License> updateLicense(String token, {required License license}) async {
    log('Updating license with ID ${license.licenseKey} to $license');

    try {
      final response = await _apiService.patch(
        '/admin/licenses',
        pathParameter: license.licenseKey,
        token: token,
        body: license.toJson(),
      );
      response.raiseForStatusCode();

      log('Successfully updated license with ID ${license.licenseKey}');

      return License.fromJson(response.json);
    } catch (e, s) {
      log('Failed to update license with ID ${license.licenseKey}', e, s);
      rethrow;
    }
  }

  @override
  Future<LicenseStatus> getLicenseStatus(String token, {required String licenseKey}) async {
    log('Getting status of license $licenseKey');

    try {
      final response = await _apiService.get(
        '/admin/licenses/status',
        pathParameter: licenseKey,
        token: token,
      );
      response.raiseForStatusCode();

      final status = LicenseStatus.fromJson(response.json);

      log('Successfully returned status of license $licenseKey');

      return status;
    } catch (e, s) {
      log('Failed to get status of license $licenseKey', e, s);
      rethrow;
    }
  }
}
