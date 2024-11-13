import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dispays all products.
class ProductsScreen extends StatefulWidget {
  /// Dispays all products.
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
    final products = context.watch<ProductsRepository>();

    return Scaffold(
      loadingProgressIndeterminate: products.state.isLoading,
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              Text(t.products_productsScreen_title),
            ],
          ),
          trailing: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: searchController,
                placeholder: context.t.products_productsScreen_searchProducts,
              ),
            ),
            IconButton.outline(
              icon: const Icon(RadixIcons.plus),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CreateProductDialog(
                    showToast: createShowToastHandler(context),
                  ),
                );
              },
            ),
          ],
        ),
      ],
      child: !products.state.hasData
          ? const SizedBox()
          : Wrap(
              spacing: 20,
              runSpacing: 20,
              children: products.search(searchController.text).map(ProductCard.withoutKey).toList(),
            ),
    );
  }
}
