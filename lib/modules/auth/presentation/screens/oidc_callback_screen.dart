import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Handles the oidc callback.
class OidcCallbackScreen extends StatelessWidget {
  /// Handles the oidc callback.
  const OidcCallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenRepository = context.watch<TokenRepository>();

    if (tokenRepository.state.hasData) {
      Modular.to.navigate(Modular.initialRoute);
    } else if (!tokenRepository.state.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) => tokenRepository.completeAuthentication());
    }

    return Container();
  }
}
