import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Displays the features of a product.
class ProductFeatures extends StatefulWidget {
  /// Displays the features of a product.
  const ProductFeatures({super.key, required this.product});

  /// The product to display the features of.
  final Product product;

  @override
  State<ProductFeatures> createState() => _ProductFeaturesState();
}

class _ProductFeaturesState extends State<ProductFeatures> {
  @override
  Widget build(BuildContext context) {
    final features = context.watch<FeaturesRepository>();

    if (!features.state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final relatedFeatures = features.filter(productIds: [widget.product.id]);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.t.products_productFeatures_productFeatures(relatedFeatures.length.toString())).medium().bold(),
              IconButton.ghost(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddFeatureDialog(
                      product: widget.product,
                      showToast: createShowToastHandler(context),
                    ),
                  );
                },
              ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for (final feature in relatedFeatures)
                Row(
                  children: [
                    if (feature.type == FeatureType.free) const Icon(UiconsSolid.hands_heart) else const Icon(UiconsSolid.coin),
                    const SizedBox(width: 10),
                    HoverCard(
                      child: Text(feature.name),
                      hoverBuilder: (context) => SizedBox(
                        height: 150,
                        child: FeatureCard(
                          feature: feature,
                        ),
                      ),
                    ).expanded(),
                    Builder(
                      builder: (context) {
                        return IconButton.ghost(
                          icon: const Icon(RadixIcons.dotsHorizontal),
                          onPressed: () {
                            showDropdown(
                              context: context,
                              builder: (_) {
                                return SizedBox(
                                  width: 100,
                                  child: DropdownMenu(
                                    children: [
                                      MenuButton(
                                        leading: const Icon(RadixIcons.pencil1),
                                        child: Text(context.t.global_edit),
                                        onPressed: (context) {
                                          // TODO: show edit dialog
                                        },
                                      ),
                                      MenuButton(
                                        leading: Icon(
                                          RadixIcons.trash,
                                          color: context.theme.colorScheme.destructive,
                                        ),
                                        child: Text(
                                          context.t.licenses_licensesTableRow_revoke,
                                          style: context.theme.typography.semiBold.copyWith(
                                            color: context.theme.colorScheme.destructive,
                                          ),
                                        ),
                                        onPressed: (_) {
                                          // TODO: show confirmation dialog
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
            ],
          ).expanded(),
        ],
      ),
    );
  }
}
