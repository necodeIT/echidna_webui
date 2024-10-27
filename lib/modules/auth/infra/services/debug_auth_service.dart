import 'package:license_server_admin_panel/modules/auth/auth.dart';

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
