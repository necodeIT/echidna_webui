import 'package:awesome_extensions/awesome_extensions.dart' hide ExpandedExtension;
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Lists all features unlocked by a license.
class LicenseFeatures extends StatelessWidget {
  /// Lists all features unlocked by a license.
  const LicenseFeatures({super.key, required this.license, required this.status});

  /// The status of the license.
  final LicenseStatus status;

  /// The license to display features for.
  final License license;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox.shrink(),
        Text(context.t.licenses_licenseCard_featuresUnlocked).bold(),
        const SizedBox(height: 10),
        if (status.featureClaims.isEmpty) Text(context.t.licenses_licenseFeatures_noFeaturesUnlocked).muted(),
        if (status.featureClaims.isNotEmpty)
          ListView(
            children: [
              for (final claim in status.featureClaims)
                Row(
                  children: [
                    if (claim.feature.type == FeatureType.free) const Icon(UiconsSolid.hands_heart) else const Icon(UiconsSolid.coin),
                    const SizedBox(width: 10),
                    Text(claim.feature.name),
                    if (claim.isCustomer && !license.isCustomerWide)
                      Transform.scale(
                        scale: 0.8,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.basic,
                          child: SecondaryBadge(
                            child: Text(context.t.licenses_licenseCard_customerWide),
                          ),
                        ),
                      ),
                  ],
                ),
            ].separatedby(const SizedBox(height: 10)),
          ).expanded(),
      ],
    );
  }
}
