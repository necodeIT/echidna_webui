import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Wraps the application with a side navigation bar.
class NavbarScreen extends StatelessWidget {
  /// Wraps the application with a side navigation bar.
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Navbar(),
        Expanded(
          child: RouterOutlet(),
        ),
      ],
    );
  }
}
