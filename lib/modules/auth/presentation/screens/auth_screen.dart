import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/gen/assets.gen.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:quoter/quoter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays a login form.
class AuthScreen extends StatelessWidget {
  /// Displays a login form.
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final token = context.watch<TokenRepository>();
    final idp = context.watch<IdentityProvider>();
    final quote = Modular.get<Quoter>().getRandomQuote();
    final theme = context.theme;

    if (token.state.hasData) {
      Modular.to.navigate('/');
    }

    return Scaffold(
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: theme.typography.normal.copyWith(color: theme.colorScheme.primaryForeground),
              child: Container(
                color: theme.colorScheme.primary,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: theme.borderRadiusSm,
                          child: Assets.branding.logoIconBackground.svg(
                            width: 30,
                            height: 30,
                            placeholderBuilder: (context) => const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(context.t.global_licenseServerAdminPanel, style: theme.typography.large),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(RadixIcons.quote, color: theme.colorScheme.primaryForeground),
                          ),
                          const WidgetSpan(child: SizedBox(width: 5)),
                          TextSpan(text: quote.quotation, style: theme.typography.x3Large),
                          const WidgetSpan(child: SizedBox(width: 5)),
                          WidgetSpan(
                            child: Icon(RadixIcons.quote, color: theme.colorScheme.primaryForeground),
                          ),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          TextSpan(text: quote.quotee, style: theme.typography.small.copyWith(fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ).withPadding(right: 250, left: 40),
                    Row(
                      children: [
                        Text(context.t.auth_authScreen_poweredBy),
                        Assets.branding.logoHoriz.svg(
                          width: 100,
                          height: 30,
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.t.auth_authScreen_loginToContinue).x3Large().semiBold(),
                      const SizedBox(height: 5),
                      Text(context.t.auth_authScreen_signInWithIdProvider).small(),
                      const SizedBox(height: 20),
                      Button.primary(
                        onPressed: token.authenticate,
                        child: Text(context.t.auth_authScreen_loginWithIdp(idp.name)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton.outline(
                    icon: const Icon(
                      BootstrapIcons.github,
                    ),
                    onPressed: () {
                      launchUrl(Uri.parse('https://github.com/necodeIT/license_server'));
                    },
                  ),
                ),
              ],
            ).withPadding(all: 20),
          ),
        ],
      ),
    );
  }
}
