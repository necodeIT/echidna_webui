import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'domain/domain.dart';
import 'presentation/presentation.dart';
import 'infra/infra.dart';
import 'utils/utils.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

class LicensesModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {}

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
