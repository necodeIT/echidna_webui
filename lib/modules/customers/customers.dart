import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements customer management.
class CustomersModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
        ApiModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<CustomersDatasource>(StdCustomersDatasource.new)
      ..addRepository<CustomersRepository>(CustomersRepository.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/',
        child: (_) => const CustomersScreen(),
        transition: TransitionType.noTransition,
      )
      ..child(
        '/:id',
        child: (_) => CustomerScreen(id: int.parse(r.args.params['id'])),
        transition: TransitionType.noTransition,
      );
  }
}
