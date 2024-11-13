import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays details of a product.
class ProductScreen extends StatelessWidget {
  /// The product ID.
  final int id;

  /// Displays details of a product.
  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsRepository>();

    final product = products.byId(id);

    if (products.state.hasData && product == null) {
      return const NotFoundScreen();
    }

    return Scaffold(
      loadingProgressIndeterminate: products.state.isLoading,
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              TextButton(
                density: ButtonDensity.compact,
                onPressed: () {
                  Modular.to.navigate('/products/');
                },
                child: Text(context.t.products_productsScreen_title),
              ),
              Text(product?.name ?? id.toString()),
            ],
          ),
          trailing: product != null
              ? [
                  IconButton.outline(
                    icon: const Icon(RadixIcons.pencil1),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => EditProductDialog(
                          product: product,
                          showToast: createShowToastHandler(context),
                        ),
                      );
                    },
                  ),
                ]
              : [],
        ),
      ],
      child: products.state.hasData && product != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ProductFeatures(product: product).expanded(),
                            const SizedBox(width: 20),
                            ProductCustomers(product: product).expanded(),
                          ],
                        ).expanded(),
                        const SizedBox(height: 20),
                        InstallClientSdk(product: product).expanded(flex: 2),
                      ],
                    ).expanded(flex: 2),
                    const SizedBox(width: 20),
                    ProductLicenses(product: product).expanded(),
                  ],
                ).expanded(),
              ],
            ).withPadding(all: 20)
          : const SizedBox(),
    );
  }
}
