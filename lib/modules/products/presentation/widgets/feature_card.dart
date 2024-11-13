import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Displays a summary of a given [feature].
class FeatureCard extends StatelessWidget {
  /// Displays a summary of a given [feature].
  const FeatureCard({super.key, required this.feature});

  /// The feature to display.
  final Feature feature;

  @override
  Widget build(BuildContext context) {
    final free = feature.type == FeatureType.free;
    final paid = !free;

    return SizedBox(
      width: 400,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(feature.name).medium().bold(),
            const SizedBox(height: 10),
            Text(feature.description),
            const SizedBox(height: 10),
            Row(
              children: [
                if (free) const Icon(UiconsSolid.hands_heart) else const Icon(UiconsSolid.coin),
                const SizedBox(width: 10),
                Text(free ? 'This feature is free' : 'This feature is paid'),
              ],
            ),
            if (paid) const SizedBox(height: 10),
            if (paid)
              Row(
                children: [
                  const Icon(BootstrapIcons.calendar2HeartFill),
                  const SizedBox(width: 10),
                  if ((feature.trialPeriod ?? 0) > 0)
                    Text('This feature has a trial period of ${feature.trialPeriod} days')
                  else
                    Text('This feature does not have a trial period'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
