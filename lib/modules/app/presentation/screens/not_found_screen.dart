import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Shown when the user navigates to a non-existent route.
class NotFoundScreen extends StatelessWidget {
  /// Shown when the user navigates to a non-existent route.
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: Text(context.t.app_notFound_404),
        ),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              BootstrapIcons.exclamationDiamondFill,
              color: context.theme.colorScheme.destructive,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(context.t.app_notFound_404).h1(),
            Text(context.t.app_notFound_notFound).h2(),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                Modular.to.navigate('/');
              },
              leading: const Icon(Icons.home),
              child: Text(context.t.app_notFound_goToHome),
            ),
          ],
        ),
      ),
    );
  }
}
