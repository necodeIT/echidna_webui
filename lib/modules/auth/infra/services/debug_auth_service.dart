import 'package:echidna_webui/modules/auth/auth.dart';

/// Implements [AuthService] for debugging purposes.
class DebugAuthService extends AuthService {
  @override
  void dispose() {}

  @override
  Future<String> authenticate() async => 'Debug';

  @override
  Future<void> logout() async {}

  @override
  Future<bool> verify(String token) async => true;
}
