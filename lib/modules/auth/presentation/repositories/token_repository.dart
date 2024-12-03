import 'dart:async';

import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

/// Provides the token used to access the API.
class TokenRepository extends Repository<AsyncValue<Token>> {
  final AuthService _authService;
  final LocalStorageDatasource _localStorage;

  /// Provides the token used to access the API.
  TokenRepository(this._authService, this._localStorage) : super(AsyncValue.loading()) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    await guard(
      () async {
        final token = await _localStorage.read<Token>();

        if (!await _authService.verify(token.token)) {
          await _localStorage.delete<Token>();
          throw Exception('Invalid token');
        }

        return token;
      },
      onData: (_) => log('Loaded token from cache'),
      onError: (e, s) {
        log('Failed to load token from cache', e, s);
      },
    );
  }

  /// Initiates the authentication process.
  Future<void> authenticate() async {
    log('Initiating authentication flow with third-party identity provider');

    await _authService.authenticate();
  }

  /// Completes the authentication process and stores the token.
  Future<void> completeAuthentication() async {
    final token = await _authService.completeAuthentication();

    await _localStorage.write(Token(token: token));

    data(Token(token: token));
  }

  /// Logs the user out and deletes the token from storage.
  Future<void> logout() async {
    await _authService.logout();

    await _localStorage.delete<Token>();

    error('User logged out');
  }

  @override
  void dispose() {
    super.dispose();

    _authService.dispose();
  }
}
