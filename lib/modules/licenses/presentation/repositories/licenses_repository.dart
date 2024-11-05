import 'dart:async';

import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_rest/license_server_rest.dart';
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
    final licenses = await _datasource.getLicenses(_tokenRepository.state.data!.token);

    emit(AsyncValue.data(licenses));
  }

  @override
  void dispose() {
    _datasource.dispose();

    super.dispose();
  }
}
