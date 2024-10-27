import 'package:dotenv/dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/config/config.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:quoter/quoter.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Handles the authentication of the user.
class AuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        LocalStorageModule(),
      ];

  @override
  void binds(Injector i) {
    // Quoter takes a QuoteRepository as a parameter in its constructor with a default value of QuoteLocalRepository.
    // However, modular will still throw an error if we don't provide a binding for QuoteRepository, thus the unnecessary lambda.
    // ignore: unnecessary_lambdas
    i
      ..add<Quoter>(() => const Quoter())
      ..add<DotEnv>(() => env)
      ..add<IdentityProvider>(IdentityProvider.fromEnvironment)
      ..add<AuthService>(
        kDebugMode
            ? DebugAuthService.new
            : (IdentityProvider idp, NetworkService network) => idp.when(
                  saml: (_, __, ___) => throw UnimplementedError('Saml is not yet supported'),
                  oidc: (
                    String name,
                    String clientId,
                    String clientSecret,
                    String redirectUri,
                    String authorizationUrl,
                    String tokenUrl,
                    String userInfoUrl,
                    String scopes,
                  ) =>
                      OidcAuthService(
                    network,
                    OidcIdentityProvider(
                      name: name,
                      clientId: clientId,
                      clientSecret: clientSecret,
                      redirectUri: redirectUri,
                      authorizationUrl: authorizationUrl,
                      tokenUrl: tokenUrl,
                      userInfoUrl: userInfoUrl,
                      scopes: scopes,
                    ),
                  ),
                ),
      )
      ..addSerde<Token>(fromJson: Token.fromJson, toJson: (token) => token.toJson())
      ..addRepository<TokenRepository>(TokenRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const AuthScreen());
  }
}
