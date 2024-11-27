import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
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
            Text('${feature.name} (#${feature.id})').medium().bold(),
            const SizedBox(height: 10),
            Text(feature.description),
            const SizedBox(height: 10),
            Row(
              children: [
                if (free) const Icon(UiconsSolid.hands_heart) else const Icon(UiconsSolid.coin),
                const SizedBox(width: 10),
                Text(free ? context.t.products_featureCard_freeFeature : context.t.products_featureCard_paidFeature),
              ],
            ),
            if (paid) const SizedBox(height: 10),
            if (paid)
              Row(
                children: [
                  const Icon(BootstrapIcons.calendar2HeartFill),
                  const SizedBox(width: 10),
                  if ((feature.trialPeriod ?? 0) > 0)
                    Text(context.t.products_featureCard_hasTrial(feature.trialPeriod.toString()))
                  else
                    Text(context.t.products_featureCard_noTrial),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
