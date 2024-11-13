import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Confirm dialog for deleting a product.
class DeleteProductDialog extends ToastConsumer {
  /// Product to delete.
  final Product product;

  /// Confirm dialog for deleting a product.
  const DeleteProductDialog({super.key, required this.product, required super.showToast});

  @override
  State<DeleteProductDialog> createState() => _DeleteProductDialogState();
}

class _DeleteProductDialogState extends State<DeleteProductDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.products_deleteProductDialog_deleteCheck),
      content: Text(context.t.products_deleteProductDialog_deleteCheckWith(widget.product.name)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.t.global_cancel),
        ),
        TextButton(
          onPressed: _deleteProduct,
          child: Text(context.t.global_delete, style: theme.typography.semiBold.copyWith(color: theme.colorScheme.destructive)),
        ),
      ],
    );
  }

  Future<void> _deleteProduct() async {
    final products = Modular.get<ProductsRepository>();

    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: t.products_deleteProductDialog_deletingProduct,
      subtitle: t.products_deleteProductDialog_deletingProductWith(widget.product.name),
    );

    try {
      await products.deleteProduct(widget.product.id);
    } catch (e) {
      showErrorToast(
        title: t.products_deleteProductDialog_errorDeleting,
        subtitle: t.products_deleteProductDialog_errorDeletingWith(widget.product.name),
      );
    } finally {
      loader.close();
    }
  }
}
