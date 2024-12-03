import 'package:awesome_extensions/awesome_extensions.dart' hide ThemeExt;
import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Side navigation bar for the application that allows users to navigate between different sections.
class Navbar extends StatefulWidget {
  /// Side navigation bar for the application that allows users to navigate between different sections.
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  final List<String> _routes = [];

  void _syncRoute(Duration _) {
    didChangeRoute();
  }

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(didChangeRoute);
  }

  void didChangeRoute() {
    final index = _routes.indexWhere((r) => Modular.to.path.startsWith(r));

    if (index != -1 && index != selectedIndex) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  void dispose() {
    Modular.to.removeListener(didChangeRoute);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_syncRoute);

    return SizedBox(
      width: 200,
      height: context.height,
      child: NavigationSidebar(
        backgroundColor: context.theme.colorScheme.background,
        onSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        index: selectedIndex,
        children: [
          NavigationLabel(child: Text(context.t.gloabal_adminPanel)),
          _item(context.t.dashboard_dashboardScreen_title, UiconsSolid.chart_simple, '/dashboard'),
          _item(context.t.customers_customersScreen_title, BootstrapIcons.peopleFill, '/customers'),
          _item(context.t.licenses_licensesScreen_title, BootstrapIcons.keyFill, '/licenses'),
          _item(context.t.products_productsScreen_title, RadixIcons.code, '/products'),
          NavigationGap(context.height - 300), // may fail on smallers screens
          _item(context.t.logs_logsScreen_serverLogs, BootstrapIcons.fileTextFill, '/logs'),
          _item(context.t.settings_settingsScreen_settings, BootstrapIcons.gearWideConnected, '/settings'),
        ],
      ),
    );
  }

  NavigationBarItem _item(String label, IconData icon, String route) {
    if (!_routes.contains(route)) {
      _routes.add(route);
    }

    return NavigationButton(
      label: Text(label),
      onChanged: (value) {
        if (value) {
          Modular.to.navigate(route);
        }
      },
      child: Icon(icon),
    );
  }
}
