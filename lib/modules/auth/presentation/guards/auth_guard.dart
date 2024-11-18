import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Ensures that the user is authenticated before accessing a route.
class AuthGuard extends RouteGuard {
  /// Ensures that the user is authenticated before accessing a route.
  AuthGuard({super.redirectTo = '/auth'}) : super();

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final token = Modular.get<TokenRepository>();

    await for (final t in token.stream) {
      if (t.hasData) {
        return true;
      }

      if (t.hasError) {
        return false;
      }
    }

    return false;
  }
}
