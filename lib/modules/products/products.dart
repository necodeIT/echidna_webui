import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_admin_panel/modules/products/presentation/presentation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements product management.
class ProductsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        ApiModule(),
        AuthModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<ProductsDatasource>(StdProductsDatasource.new)
      ..add<FeaturesDatasource>(StdFeaturesDatasource.new)
      ..addRepository<FeaturesRepository>(FeaturesRepository.new)
      ..addRepository<ProductsRepository>(ProductsRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/',
        child: (_) => const ProductsScreen(),
      )
      ..child(
        '/:id',
        child: (_) => ProductScreen(
          id: int.parse(r.args.params['id']),
        ),
      );
  }
}
