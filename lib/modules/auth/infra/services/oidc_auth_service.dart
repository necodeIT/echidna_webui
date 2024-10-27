import 'package:license_server_admin_panel/modules/auth/auth.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Handles third-party authentication using OpenID Connect.
class OidcAuthService extends AuthService {
  final NetworkService _networkService;
  final OidcIdentityProvider _oidcIdentityProvider;

  /// Handles third-party authentication using OpenID Connect.
  OidcAuthService(this._networkService, this._oidcIdentityProvider);

  @override
  void dispose() {
    _networkService.dispose();
  }

  @override
  Future<String> authenticate() async {
    // TOOD: Implement authentication

    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout

    throw UnimplementedError();
  }

  @override
  Future<bool> verify(String token) async {
    // TODO: implement verify

    throw UnimplementedError();
  }
}
