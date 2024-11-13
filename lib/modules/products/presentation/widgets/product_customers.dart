import 'package:license_server_admin_panel/main.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProductCustomers extends StatefulWidget {
  const ProductCustomers({super.key, required this.product});

  final Product product;

  @override
  State<ProductCustomers> createState() => _ProductCustomersState();
}

class _ProductCustomersState extends State<ProductCustomers> {
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
          Row(
            children: [
              Text('Customers using this product (${product.customers.length})').medium().bold(),
              const SizedBox(width: 50),
              TextField(
                controller: searchController,
                placeholder: t.customers_customersScreen_searchCustomers,
              ).expanded(),
            ],
          ),
          const SizedBox(height: 10),
          ListView(
            children: [
              for (final customer in product.customers.where((c) => c.name.containsIgnoreCase(searchController.text)))
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    HoverCard(
                      child: Text(customer.name),
                      hoverBuilder: (context) => SizedBox(
                        height: 150,
                        child: CustomerCard(
                          customer: customer,
                          enableActions: false,
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
                                        leading: const Icon(BootstrapIcons.infoCircle),
                                        child: Text('Details'),
                                        onPressed: (context) {
                                          Modular.to.navigate('/customers/${customer.id}');
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
