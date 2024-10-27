import 'package:dotenv/dotenv.dart';

/// The configuration loaded from the environment.
final env = DotEnv();

/// Loads the environment variables.
///
/// This must be called before any module is initialized (e.g. main).
void loadEnv() {
  const compileTimeEnv = {
    'DEBUG': String.fromEnvironment('DEBUG'),
    'SERVER_URL': String.fromEnvironment('SERVER_URL'),
    'AUTH_BACKEND': String.fromEnvironment('AUTH_BACKEND'),
    'OIDC_NAME': String.fromEnvironment('OIDC_NAME'),
    'OIDC_CLIENT_ID': String.fromEnvironment('OIDC_CLIENT_ID'),
    'OIDC_CLIENT_SECRET': String.fromEnvironment('OIDC_CLIENT_SECRET'),
    'OIDC_TOKEN_URL': String.fromEnvironment('OIDC_TOKEN_URL'),
    'OIDC_USER_INFO_URL': String.fromEnvironment('OIDC_USER_INFO_URL'),
    'OIDC_AUTHORIZATION_URL': String.fromEnvironment('OIDC_AUTHORIZATION_URL'),
    'OIDC_REDIRECT_URI': String.fromEnvironment('OIDC_REDIRECT_URI'),
    'OIDC_SCOPES': String.fromEnvironment('OIDC_SCOPES'),
  };

  env.addAll(compileTimeEnv);
}
