import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/config/config.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(debugLogHandler);

  Modular.setInitialRoute('/dashboard');

  CoreModule.isWeb = kIsWeb;

  loadEnv();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

/// Root widget of the application.
class AppWidget extends StatelessWidget {
  /// Root widget of the application.
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorSchemes.darkZinc(),
        radius: 0.5,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
