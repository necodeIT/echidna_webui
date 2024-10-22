// ignore_for_file: invalid_annotation_target

import 'package:dotenv/dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server.freezed.dart';
part 'server.g.dart';

/// Holds the configuration for the server.
@freezed
class Server with _$Server {
  /// Holds the configuration for the server.
  const factory Server({
    required String url,
  }) = _Server;

  const Server._();

  /// Creates a [Server] from a JSON object.
  factory Server.fromJson(Map<String, Object?> json) => _$ServerFromJson(json);

  /// Loads the server configuration from the environment.
  factory Server.fromEnvironment(DotEnv env) {
    final url = env['SERVER_URL'];

    if (url == null) {
      throw Exception('SERVER_URL not found in environment');
    }

    return Server(url: url);
  }
}
