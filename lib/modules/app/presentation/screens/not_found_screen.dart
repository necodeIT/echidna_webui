import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: Text('404'),
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
            Text('404').h1(),
            Text("Sorry, couldn't find what you're looking for!").h2(),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                Modular.to.navigate('/');
              },
              leading: const Icon(Icons.home),
              child: Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
