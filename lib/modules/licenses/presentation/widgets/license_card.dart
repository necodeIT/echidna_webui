import 'dart:math';

import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays a summary of a [license].
class LicenseCard extends StatelessWidget {
  /// Displays a summary of a [license].
  const LicenseCard({super.key, required this.license});

  /// The license to summarize.
  final License license;

  @override
  Widget build(BuildContext context) {
    // TODO: actually check if license is valid
    final rng = Random();
    final valid = rng.nextBool();

    return SizedBox(
      width: CustomerCard.width,
      child: Card(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('License overview').medium().bold(),
            const SizedBox(height: 10),
            Text('License key: ${license.licenseKey}').ellipsis(),
            const SizedBox(height: 10),
            Text('User ID: ${license.userId}'),
            const SizedBox(height: 10),
            // TODO: get license status
            Row(
              children: [
                if (!valid)
                  Icon(BootstrapIcons.xCircleFill, color: context.theme.colorScheme.destructive)
                else
                  Icon(BootstrapIcons.checkCircleFill, color: context.theme.colorScheme.primary),
                const SizedBox(width: 10),
                Text(valid ? 'Active' : 'Inactive'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
