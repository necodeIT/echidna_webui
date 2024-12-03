import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/logs/logs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Standard implementation of [LogsDatasource].
class StdLogsDatasource extends LogsDatasource {
  WebSocketChannel? _socket;
  final DotEnv _env;

  /// Standard implementation of [LogsDatasource].
  StdLogsDatasource(this._env);

  @override
  void dispose() {
    _socket = null;

    log('Websocket connection closed');
  }

  @override
  Stream<List<ServerLog>> getLogs(String token) async* {
    if (_socket == null) {
      try {
        final socketUrl = '${_env['SERVER_WEBSOCKET']!}/admin/logs?token=$token';

        log('Connecting to $socketUrl');

        _socket = WebSocketChannel.connect(Uri.parse(socketUrl));

        log('Connected to websocket');
      } catch (e, s) {
        log('Failed do establish connection to websocket', e, s);
        rethrow;
      }
    }

    await _socket!.ready;

    await for (final data in _socket!.stream) {
      log('Received data from websocket');

      final json = jsonDecode(data);

      yield (json as List).map((e) => ServerLog.fromJson(e)).toList();
    }
  }
}
