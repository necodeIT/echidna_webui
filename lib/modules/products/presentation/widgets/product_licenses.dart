import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

class ProductLicenses extends StatefulWidget {
  const ProductLicenses({super.key, required this.product});

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
          Text('Licenses for this product (${product.licenses.length})').medium().bold(),
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
                      hoverBuilder: (context) => SizedBox(
                        height: 150,
                        child: LicenseCard(
                          license: license,
                        ),
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
                                        child: Text('Details'),
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
                                              license: license,
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
