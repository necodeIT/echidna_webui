import 'dart:convert';

import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'dart:html';

import 'package:modular_core/modular_core.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static String get redirectUri => '${window.location.origin}/auth/oidc';

  @override
  Future<void> authenticate() async {
    var url = '${_oidcIdentityProvider.authorizationUrl}?client_id=${_oidcIdentityProvider.clientId}';

    url += '&response_type=code';
    url += '&scope=${_oidcIdentityProvider.scopeList.join(' ')}';
    url += '&redirect_uri=$redirectUri';

    log('Redirecting to: $url');

    window.location.href = Uri.encodeFull(url).replaceAll('#', '%23');
  }

  @override
  Future<void> logout() async {
    // TODO(mcquenji, MasterMarcoHD): implement logout

    throw UnimplementedError();
  }

  @override
  Future<bool> verify(String token) async {
    final basic = '${_oidcIdentityProvider.clientId}:${_oidcIdentityProvider.clientSecret}';

    final response = await _networkService.post(
      _oidcIdentityProvider.introspectUri,
      {
        'token': token,
      },
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode(basic))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    response.raiseForStatusCode();

    return response.body['client_id'] == _oidcIdentityProvider.clientId;
  }

  @override
  Future<String> completeAuthentication() async {
    final code = queryParameters['code']!;

    final response = await _networkService.post(
      _oidcIdentityProvider.tokenUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      {
        'client_id': _oidcIdentityProvider.clientId,
        'client_secret': _oidcIdentityProvider.clientSecret,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
        'prompt': 'none',
      },
    );

    return response.body['access_token'] as String;
  }
}
