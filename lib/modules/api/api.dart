import 'package:dotenv/dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/config/config.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Handles communication with the license server API.
class ApiModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<DotEnv>(() => env)
      ..add<ServerConfig>(ServerConfig.fromEnvironment)
      ..add<ApiService>(StdApiService.new);
  }
}
