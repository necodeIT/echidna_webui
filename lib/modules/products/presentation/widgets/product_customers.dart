import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays the customers of a product.
class ProductCustomers extends StatefulWidget {
  /// Displays the customers of a product.
  const ProductCustomers({super.key, required this.product});

  /// The product to display the customers of.
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
                                        child: const Text('Details'),
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
