import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Shows server logs.
class LogsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<LogsDatasource>(StdLogsDatasource.new)
      ..addRepository<LogsRepository>(LogsRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const LogsScreen(),
    );
  }
}
