import 'package:echidna_webui/config/config.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  loadEnv();

  if (env['DEBUG'] == 'true' || kDebugMode) {
    Logger.root.level = Level.ALL;
    // only called in debug mode
    // ignore: avoid_print
    Logger.root.onRecord.listen((r) => print(r.formatColored()));
  }

  Modular.setInitialRoute('/dashboard');

  ConnectivityService.updateInterval = const Duration(seconds: 10);

  CoreModule.isWeb = kIsWeb;

  loadQueryParameters();
  setPathUrlStrategy();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

/// Root widget of the application.
class AppWidget extends StatelessWidget {
  /// Root widget of the application.
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.watch<ColorSchemeRepository>();

    return ShadcnApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme.state,
        radius: 0.5,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
