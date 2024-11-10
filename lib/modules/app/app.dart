library license_server_admin_panel.modules.app;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/dashboard/dashboard.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';
import 'utils/utils.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        ApiModule(),
        AuthModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..addRepository<PlatformBrightnessRepository>(PlatformBrightnessRepository.new)
      ..addRepository<ColorSchemeRepository>(ColorSchemeRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..module(
        '/auth',
        module: AuthModule(),
        transition: TransitionType.noTransition,
      )
      ..child(
        '/',
        child: (_) => const NavbarScreen(),
        transition: TransitionType.noTransition,
        children: [
          ModuleRoute(
            '/customers',
            module: CustomersModule(),
          ),
          ModuleRoute(
            '/dashboard',
            module: DashboardModule(),
          ),
          ModuleRoute(
            '/licenses',
            module: LicensesModule(),
          ),
          ModuleRoute(
            '/products',
            module: ProductsModule(),
          ),
        ].applyDefaultTransition(),
        guards: [AuthGuard()],
      );
  }
}
