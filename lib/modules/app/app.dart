library license_server_admin_panel.modules.app;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        ApiModule(),
      ];

  @override
  void binds(Injector i) {}

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SizedBox());
  }
}
