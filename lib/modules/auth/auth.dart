import 'package:dotenv/dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/config/config.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:quoter/data/data.dart';
import 'package:quoter/quoter.dart';
// quoter package does not export the repository
// ignore: implementation_imports
import 'package:quoter/src/repositories/repositories.dart';

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
    i
      ..add<QuoteRepository>(
        () => const QuoteLocalRepository(
          quoteData: [
            ...kquoteData,
            {
              'quotation': 'Always buy a bigger bottle than you think you need. Better safe than sober.',
              'quotee': 'Abraham Lincoln',
            },
            {
              'quotation': 'I quit drinking yesterday, but tonight I celebrate my sobriety.',
              'quotee': 'Gandhi',
            },
            {
              'quotation': 'Maturity is when you realize that your weekend lasts longer when you start drinking on Wednesday.',
              'quotee': 'Nelson Mandela',
            },
            {
              'quotation':
                  "The definition of insanity is doing the same thing over and over and expecting different results. Unless you're using JavaScript.",
              'quotee': 'Albert Einstein',
            },
            {
              'quotation': 'But I am very poorly today & very stupid & I hate everybody & everything. One lives only to make blunders.',
              'quotee': 'Charles Darwin',
            },
            {
              'quotation': "Maturing is realizing you don't need fun to have alcohol.",
              'quotee': 'Isaac Newton',
            },
            {
              'quotation': 'I am a drinker with a writing problem.',
              'quotee': 'Brendan Behan',
            },
            {
              'quotation': 'Ich bin zwar kein Dichter und Denker, aber dafür dichter als Sie denken.',
              'quotee': 'Wolfgang Amadeus Mozart',
            },
            {
              'quotation': 'Lieber kritigunfähig als kreditunwürdig.',
              'quotee': 'Sonnenschein Catering',
            },
            {
              'quotation': "I don't always have time to study, but when I do I still don't.",
              'quotee': 'Meng Manina',
            },
          ],
        ),
      )
      ..add<Quoter>((QuoteRepository q) => Quoter(quoteRepository: q))
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
      ..addSerde<Token>(
        fromJson: Token.fromJson,
        toJson: (token) => token.toJson(),
      )
      ..addRepository<TokenRepository>(TokenRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const AuthScreen(),
      transition: TransitionType.noTransition,
    );
  }
}
