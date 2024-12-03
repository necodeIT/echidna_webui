import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Handles third-party authentication.
abstract class AuthService extends Service {
  @override
  String get name => 'Auth';

  /// Initiates the authentication process.
  Future<void> authenticate();

  /// Completes the authentication process and returns the user's token.
  ///
  /// This should be called after the user has been redirected back to the app.
  Future<String> completeAuthentication();

  /// Logs out the user.
  Future<void> logout();

  /// Returns `true` if the given [token] is valid.
  Future<bool> verify(String token);
}
