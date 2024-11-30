import 'dart:async';

import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/logs/logs.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Provides a list of all logs on the server.
class LogsRepository extends Repository<AsyncValue<List<ServerLog>>> {
  final LogsDatasource _datasource;
  final TokenRepository _token;

  /// Provides a list of all logs on the server.
  LogsRepository(this._datasource, this._token) : super(AsyncValue.loading()) {
    watchAsync(_token);
  }

  StreamSubscription? _subscription;

  @override
  FutureOr<void> build(Type trigger) {
    _subscription?.cancel();

    _subscription = _datasource.getLogs(_token.state.requireData.token).listen((event) {
      emit(AsyncValue.data(event));
    });
  }

  /// Sorts the logs by the given parameters.
  ///
  /// Note:
  List<ServerLog> sortBy(SortServerLogsBy sort) {
    if (!state.hasData) {
      return [];
    }

    final logs = state.requireData;

    if (sort == SortServerLogsBy.level) {
      logs.sort((a, b) => a.level.compareTo(b.level));
    }

    if (sort == SortServerLogsBy.time) {
      logs.sort((a, b) => a.time.compareTo(b.time));
    }

    if (sort == SortServerLogsBy.sequenceNumber) {
      logs.sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));
    }

    return logs;
  }

  @override
  void dispose() {
    _datasource.dispose();

    super.dispose();
  }
}

/// Enum to sort the server logs by.
enum SortServerLogsBy {
  /// Sort by [ServerLog.level].
  level(_level),

  /// Sort by [ServerLog.time].
  time(_time),

  /// Sort by [ServerLog.sequenceNumber].
  sequenceNumber(_sequenceNumber),

  /// No sorting.
  none(_none);

  /// Translates the enum value to a human readable string.
  final String Function(BuildContext) translate;

  const SortServerLogsBy(this.translate);

  static String _level(BuildContext context) => 'Level';
  static String _time(BuildContext context) => 'Time';
  static String _sequenceNumber(BuildContext context) => 'Sequence number';
  static String _none(BuildContext context) => 'None';
}
