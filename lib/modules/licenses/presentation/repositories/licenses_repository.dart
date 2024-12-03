import 'dart:async';

import 'package:collection/collection.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:memory_cache/memory_cache.dart';

/// Provides all licenses.
class LicensesRepository extends Repository<AsyncValue<List<License>>> {
  final LicensesDatasource _datasource;
  final TokenRepository _tokenRepository;
  final MemoryCache _cache;

  /// Provides all licenses.
  LicensesRepository(this._datasource, this._tokenRepository, this._cache) : super(AsyncValue.loading()) {
    watchAsync(_tokenRepository);
  }

  @override
  FutureOr<void> build(Type trigger) async {
    log('Loading licenses');

    return guard(
      () => _datasource.getLicenses(_tokenRepository.state.data!.token),
      onData: (licenses) {
        log('Loaded licenses');

        data(licenses);
      },
      onError: (e, s) {
        log('Failed to load licenses', e, s);

        error('Failed to load licenses');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _datasource.dispose();
  }

  /// Updates the license with the given [licenseKey].
  Future<void> updateLicense({
    required String licenseKey,
    String? userId,
    int? productId,
    int? customerId,
  }) async {
    log('Updating license with license key $licenseKey');

    if (!state.hasData) {
      log('Cannot update license: ${state.error}');

      return;
    }

    try {
      final old = state.requireData.firstWhere((license) => license.licenseKey == licenseKey);

      if (old.userId == userId && old.productId == productId && old.customerId == customerId) {
        log('No changes detected. Skipping update');

        return;
      }

      final license = await _datasource.updateLicense(
        _tokenRepository.state.requireData.token,
        license: old.copyWith(
          userId: userId ?? old.userId,
          productId: productId ?? old.productId,
          customerId: customerId ?? old.customerId,
        ),
      );

      log('Successfully updated license with license key $licenseKey');

      data(state.requireData.map((l) => l.licenseKey == licenseKey ? license : l).toList());
    } catch (e, s) {
      log('Failed to update license with license key $licenseKey', e, s);

      rethrow;
    }
  }

  /// Revokes the license with the given [licenseKey].
  Future<void> revokeLicense({
    required String licenseKey,
    required String revocationReason,
  }) async {
    log('Revoking license with license key $licenseKey');

    if (!state.hasData) {
      log('Cannot revoke license: ${state.error}');

      return;
    }

    try {
      await _datasource.revokeLicense(_tokenRepository.state.requireData.token, licenseKey: licenseKey, revocationReason: revocationReason);

      log('Successfully revoked license with license key $licenseKey');
    } catch (e, s) {
      log('Failed to revoke license with license key $licenseKey', e, s);

      rethrow;
    }
  }

  /// Gets the status of the license with the given [license].
  Future<LicenseStatus?> getStatus(License license) async {
    if (!state.hasData) {
      log('Cannot get status for license with license key ${license.licenseKey}: State has no data');

      return null;
    }

    final cached = _cache.read(license.licenseKey);

    if (cached != null) {
      log('Got status for license with license key ${license.licenseKey} from cache');

      return cached;
    }

    log('Getting status for license with license key ${license.licenseKey}');

    try {
      final status = await _datasource.getLicenseStatus(_tokenRepository.state.requireData.token, licenseKey: license.licenseKey);

      log('Got status for license with license key ${license.licenseKey}');

      _cache.create(
        license.licenseKey,
        status,
        expiry: const Duration(minutes: 5),
      );

      return status;
    } catch (e, s) {
      log('Failed to get status for license with license key ${license.licenseKey}', e, s);

      rethrow;
    }
  }

  /// Gets the payment history of the license with the given [license].
  Future<List<Payment>> getHistory(License license) {
    if (!state.hasData) {
      log('Cannot get history for license with license key ${license.licenseKey}: State has no data');

      return Future.value([]);
    }

    return _datasource.getLicenseHistory(_tokenRepository.state.requireData.token, licenseKey: license.licenseKey);
  }

  /// Gets the license with the given [key].
  License? byKey(String key) {
    if (!state.hasData) {
      return null;
    }

    return state.requireData.firstWhereOrNull((element) => element.licenseKey == key);
  }
}
