import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CustomerProducts extends StatefulWidget {
  const CustomerProducts({super.key, required this.customer});

  final Customer customer;

  @override
  State<CustomerProducts> createState() => _CustomerProductsState();
}

class _CustomerProductsState extends State<CustomerProducts> {
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
          Row(
            children: [
              Text(context.t.customers_customerProductsWidget_customerProducts).medium().bold(),
              const SizedBox(width: 50),
              TextField(
                controller: searchController,
                placeholder: Text(context.t.customers_customerProductsWidget_searchProducts),
              ).expanded(),
            ],
          ),
          const SizedBox(height: 10),
          ListView(
            children: [
              for (final product in customer.products.where((p) => p.name.containsIgnoreCase(searchController.text)))
                Row(
                  children: [
                    const Icon(RadixIcons.code),
                    const SizedBox(width: 10),
                    HoverCard(
                      child: Text(product.name),
                      hoverBuilder: (context) => SizedBox(
                        height: 150,
                        child: ProductCard(
                          product: product,
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
                                        child: Text(context.t.global_details),
                                        onPressed: (context) {
                                          Modular.to.navigate('/products/${product.id}');
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
