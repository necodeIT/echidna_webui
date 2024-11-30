import 'package:echidna_dto/echidna_dto.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/uicons.dart';

/// Displays a single log entry.
class LogEntry extends StatelessWidget {
  /// Displays a single log entry.
  const LogEntry({super.key, required this.log});

  /// The log entry to display.
  final ServerLog log;

  @override
  Widget build(BuildContext context) {
    Widget levelToIcon(Level level) {
      switch (level) {
        case Level.SEVERE:
          return const Icon(UiconsSolid.flame, color: Colors.red);
        case Level.WARNING:
          return const Icon(BootstrapIcons.exclamationDiamondFill, color: Colors.orange);
        case Level.INFO:
          return const Icon(BootstrapIcons.exclamationCircle, color: Colors.blue);
        case Level.CONFIG:
          return const Icon(BootstrapIcons.gearWideConnected, color: Colors.blue);
        case Level.FINE:
        case Level.FINER:
        case Level.FINEST:
          return const Icon(BootstrapIcons.bug);
        default:
          return const Icon(BootstrapIcons.questionDiamondFill);
      }
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              levelToIcon(log.level),
              const SizedBox(width: 10),
              Text(log.level.toString()).bold(),
              const SizedBox(width: 5),
              Text(log.time.toIso8601String()).muted(),
              const SizedBox(width: 10),
              Text(log.name).muted().textEnd().expanded(),
            ],
          ),
          const SizedBox(height: 10),
          Text(log.message),
          if (log.error != null) const SizedBox(height: 20),
          if (log.error != null) Text(log.error!),
          if (log.stackTrace != null) const SizedBox(height: 10),
          if (log.stackTrace != null) Text(log.stackTrace!).mono().small(),
        ],
      ),
    );
  }
}
