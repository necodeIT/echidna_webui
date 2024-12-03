import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/gen/assets.gen.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quoter/quoter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays a login form.
class AuthScreen extends StatefulWidget {
  /// Displays a login form.
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final Quote quote;

  @override
  void initState() {
    quote = Modular.get<Quoter>().getRandomQuote();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token = context.watch<TokenRepository>();
    final idp = context.watch<IdentityProvider>();

    final theme = context.theme;

    if (token.state.hasData) {
      Modular.to.navigate('/');
    }

    return Scaffold(
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: theme.typography.normal.copyWith(color: theme.colorScheme.accent),
              child: Container(
                color: theme.colorScheme.accentForeground,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: theme.borderRadiusSm,
                          child: Assets.branding.icon.svg(
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
                            child: Icon(RadixIcons.quote, color: theme.colorScheme.accent),
                          ),
                          const WidgetSpan(child: SizedBox(width: 5)),
                          TextSpan(text: quote.quotation, style: theme.typography.x3Large),
                          const WidgetSpan(child: SizedBox(width: 5)),
                          WidgetSpan(
                            child: Icon(RadixIcons.quote, color: theme.colorScheme.accent),
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
