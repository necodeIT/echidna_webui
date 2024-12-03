import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Displays the licenses of a product.
class ProductLicenses extends StatefulWidget {
  /// Displays the licenses of a product.
  const ProductLicenses({super.key, required this.product});

  /// The product to display the licenses of.
  final Product product;

  @override
  State<ProductLicenses> createState() => _ProductLicensesState();
}

class _ProductLicensesState extends State<ProductLicenses> {
  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomersRepository>();
    final licenses = context.watch<LicensesRepository>();

    final state = customers.state.join(licenses.state);

    if (!state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final product = ProductAggregate.join(
      product: widget.product,
      licenses: licenses.state.requireData,
      customers: customers.state.requireData,
    );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.products_productLicenses_productLicenses(product.licenses.length.toString())).medium().bold(),
          const SizedBox(height: 10),
          ListView(
            children: [
              for (final license in product.licenses)
                Row(
                  children: [
                    const Icon(BootstrapIcons.keyFill),
                    const SizedBox(width: 10),
                    HoverCard(
                      child: Text(license.licenseKey).ellipsis(),
                      hoverBuilder: (context) => LicenseCard(
                        license: license,
                      ),
                    ).expanded(),
                    const SizedBox(width: 10),
                    Builder(
                      builder: (_context) {
                        return IconButton.ghost(
                          icon: const Icon(RadixIcons.dotsHorizontal),
                          onPressed: () {
                            showDropdown(
                              context: _context,
                              builder: (_) {
                                return SizedBox(
                                  width: 100,
                                  child: DropdownMenu(
                                    children: [
                                      MenuButton(
                                        leading: const Icon(BootstrapIcons.infoCircle),
                                        child: Text(context.t.global_details),
                                        onPressed: (context) {
                                          Modular.to.navigate('/licenses/${license.licenseKey}');
                                        },
                                      ),
                                      MenuButton(
                                        leading: Icon(
                                          UiconsSolid.gavel,
                                          color: context.theme.colorScheme.destructive,
                                        ),
                                        child: Text(
                                          context.t.licenses_licensesTableRow_revoke,
                                          style: context.theme.typography.semiBold.copyWith(
                                            color: context.theme.colorScheme.destructive,
                                          ),
                                        ),
                                        onPressed: (_) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => RevokeLicenseDialog(
                                              licenses: [license],
                                              showToast: createShowToastHandler(context),
                                            ),
                                          );
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
