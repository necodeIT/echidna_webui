import 'dart:async';

import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all licenses.
class LicensesRepository extends Repository<AsyncValue<List<License>>> {
  final LicensesDatasource _datasource;
  final TokenRepository _tokenRepository;

  /// Provides all licenses.
  LicensesRepository(this._datasource, this._tokenRepository) : super(AsyncValue.loading()) {
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
}
