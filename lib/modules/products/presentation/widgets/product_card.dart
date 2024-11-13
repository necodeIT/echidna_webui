import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Renders a product.
class ProductCard extends StatelessWidget {
  /// The product to render.
  final Product product;

  /// Renders a product.
  const ProductCard({super.key, required this.product});

  /// Renders a product.
  ProductCard.withoutKey(this.product) : super(key: ValueKey(product.id));

  /// Height of the card.
  static const height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        Modular.to.navigate('/products/${product.id}');
      },
      child: SizedBox(
        width: CustomerCard.width,
        height: height,
        child: Card(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OverflowMarquee(
                      delayDuration: const Duration(seconds: 5),
                      duration: const Duration(seconds: 10),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(RadixIcons.pencil1),
                    variance: ButtonVariance.ghost,
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
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: OverflowMarquee(
                  delayDuration: const Duration(seconds: 5),
                  duration: const Duration(seconds: 10),
                  direction: Axis.vertical,
                  child: Text(
                    product.description,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteProductDialog(
                        product: product,
                        showToast: createShowToastHandler(context),
                      ),
                    );
                  },
                  child: Text(
                    context.t.global_delete,
                    style: context.theme.typography.semiBold.copyWith(
                      color: context.theme.colorScheme.destructive,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
