import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OidcCallbackScreen extends StatelessWidget {
  const OidcCallbackScreen({super.key, required this.args});

  final ModularArguments args;

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
