import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements license management.
class LicensesModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        ProductsModule(),
        CustomersModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<LicensesDatasource>(StdLicensesDatasource.new)
      ..addRepository<LicensesRepository>(LicensesRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/',
        child: (_) => const LicensesScreen(),
      )
      ..child(
        '/:id',
        child: (_) => const LicenseScreen(),
      );
  }
}
