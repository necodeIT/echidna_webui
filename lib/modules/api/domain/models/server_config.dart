// ignore_for_file: invalid_annotation_target

import 'package:dotenv/dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_config.freezed.dart';
part 'server_config.g.dart';

/// Holds the configuration for the server.
@freezed
class ServerConfig with _$ServerConfig {
  /// Holds the configuration for the server.
  const factory ServerConfig({
    required String url,
  }) = _ServerConfig;

  const ServerConfig._();

  /// Creates a [ServerConfig] from a JSON object.
  factory ServerConfig.fromJson(Map<String, Object?> json) => _$ServerConfigFromJson(json);

  /// Loads the server configuration from the environment.
  factory ServerConfig.fromEnvironment(DotEnv env) {
    final url = env['SERVER_URL'];

    if (url == null) {
      throw Exception('SERVER_URL not found in environment');
    }

    return ServerConfig(url: url);
  }
}
