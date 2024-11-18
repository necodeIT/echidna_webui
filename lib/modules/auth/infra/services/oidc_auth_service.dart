import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Handles third-party authentication using OpenID Connect.
class OidcAuthService extends AuthService {
  final NetworkService _networkService;

  // waiting for implementation
  // ignore: unused_field
  final OidcIdentityProvider _oidcIdentityProvider;

  /// Handles third-party authentication using OpenID Connect.
  OidcAuthService(this._networkService, this._oidcIdentityProvider);

  @override
  void dispose() {
    _networkService.dispose();
  }

  @override
  Future<String> authenticate() async {
    // TOOD(mcquenji, MasterMarcoHD): Implement authentication

    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO(mcquenji, MasterMarcoHD): implement logout

    throw UnimplementedError();
  }

  @override
  Future<bool> verify(String token) async {
    // TODO(mcquenji, MasterMarcoHD): implement verify

    throw UnimplementedError();
  }
}
