library echidna_webui.modules.app;

import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/dashboard/dashboard.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/logs/logs.dart';
import 'package:echidna_webui/modules/settings/settings.dart';
import 'package:echidna_webui/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:memory_cache/memory_cache.dart';

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
        CustomersModule(),
        DashboardModule(),
        LicensesModule(),
        ProductsModule(),
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
          ModuleRoute(
            '/settings',
            module: SettingsModule(),
          ),
          ModuleRoute(
            '/logs',
            module: LogsModule(),
          ),
        ].applyDefaultTransition(),
        guards: [AuthGuard()],
      );
  }
}
