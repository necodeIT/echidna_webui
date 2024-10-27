import 'package:mcquenji_core/mcquenji_core.dart';

/// Handles third-party authentication.
abstract class AuthService extends Service {
  @override
  String get name => 'Auth';

  /// Initiates the authentication process.
  Future<String> authenticate();

  /// Logs out the user.
  Future<void> logout();

  /// Returns `true` if the given [token] is valid.
  Future<bool> verify(String token);
}
