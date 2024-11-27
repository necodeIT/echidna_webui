import 'dart:async';

import 'package:collection/collection.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/dashboard/dashboard.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides a list of all payments.
class PaymentsRepository extends Repository<AsyncValue<List<Payment>>> {
  final PaymentsDatasource _datasource;
  final TokenRepository _tokenRepository;

  /// Provides a list of all payments.
  PaymentsRepository(this._datasource, this._tokenRepository) : super(AsyncValue.loading()) {
    watchAsync(_tokenRepository);
  }

  @override
  FutureOr<void> build(Type trigger) async {
    log('Loading payments');

    return guard(
      () => _datasource.getPayments(_tokenRepository.state.requireData.token),
      onData: (payments) {
        log('Loaded payments: $payments');

        data(payments);
      },
      onError: (e, s) {
        log('Failed to load payments', e, s);

        error('Failed to load payments');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _datasource.dispose();
  }
}
