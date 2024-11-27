import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/dashboard/domain/datasources/datasources.dart';
import 'package:echidna_webui/modules/dashboard/infra/datasources/datasources.dart';
import 'package:echidna_webui/modules/dashboard/presentation/presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements the dashboard.
class DashboardModule extends Module {
  @override
  List<Module> get imports => [
        ApiModule(),
        AuthModule(),
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<PaymentsDatasource>(StdPaymentsDatasource.new)
      ..addRepository<PaymentsRepository>(PaymentsRepository.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const SizedBox(),
    );
  }
}
