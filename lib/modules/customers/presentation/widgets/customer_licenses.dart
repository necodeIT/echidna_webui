import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

class CustomerLicenses extends StatefulWidget {
  const CustomerLicenses({super.key, required this.customer});

  final Customer customer;

  @override
  State<CustomerLicenses> createState() => _CustomerLicensesState();
}

class _CustomerLicensesState extends State<CustomerLicenses> {
  final searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();
    final products = context.watch<ProductsRepository>();

    final state = products.state.join(licenses.state);

    if (!state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final customer = CustomerAggregate.join(
      customer: widget.customer,
      products: products.state.requireData,
      licenses: licenses.state.requireData,
    );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.customers_customerLicensesWidget_licensesForCustomer(customer.licenses.length.toString())).medium().bold(),
          const SizedBox(height: 10),
          ListView(
            children: [
              for (final license in customer.licenses)
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
