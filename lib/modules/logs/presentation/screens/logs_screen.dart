import 'package:awesome_extensions/awesome_extensions.dart' hide ThemeExt;
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/logs/logs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays the server logs.
class LogsScreen extends StatelessWidget {
  /// Displays the server logs.
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = context.watch<LogsRepository>();

    return Scaffold(
      loadingProgressIndeterminate: logs.state.isLoading,
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              Text(context.t.logs_logsScreen_serverLogs),
            ],
          ),
        ),
      ],
      child: logs.state.hasData
          ? ListView(
              children: [
                for (final log in logs.sortBy(SortServerLogsBy.sequenceNumber).reversed)
                  LogEntry(
                    log: log,
                    key: ValueKey(log.sequenceNumber),
                  ),
              ].separatedby(const SizedBox(height: 10)),
            ).withPadding(all: 20)
          : const SizedBox.shrink(),
    );
  }
}
