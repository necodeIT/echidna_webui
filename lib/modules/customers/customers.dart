import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

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
      ..child('/', child: (_) => const CustomersScreen())
      ..child('/:id', child: (_) => CustomerScreen(id: int.parse(r.args.params['id'])));
  }
}
