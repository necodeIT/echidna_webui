import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides access to logs.
abstract class LogsDatasource extends Datasource {
  @override
  String get name => 'Logs';

  /// A stream of logs as they are received.
  ///
  /// The stream will emit the entire log list every time a new log is received.
  Stream<List<ServerLog>> getLogs(String token);
}
