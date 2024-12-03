import 'dart:html';

import 'package:echidna_webui/modules/app/utils/utils.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_core/modular_core.dart';

/// Implements [AuthService] for debugging purposes.
class DebugAuthService extends AuthService {
  @override
  void dispose() {}

  @override
  Future<void> authenticate() async {
    log('Debug authentication initiated');

    Modular.to.navigate('/auth/oidc?token=Debug');
  }

  @override
  Future<void> logout() async {}

  @override
  Future<bool> verify(String token) async => true;

  @override
  Future<String> completeAuthentication() async => queryParameters['token'] ?? '';
}
