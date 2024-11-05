import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Edit product dialog.
class EditProductDialog extends StatefulWidget {
  /// Edit product dialog.
  const EditProductDialog({super.key, required this.showToast, required this.product});

  /// {@macro show_toast}
  final ShowToast showToast;

  /// Product to edit.
  final Product product;

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isEditing = false;

  Future<void> _editProduct() async {
    if (isEditing) {
      return;
    }

    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      return;
    }

    isEditing = true;

    Navigator.of(context).pop();

    final products = context.read<ProductsRepository>();

    final name = nameController.text;
    final description = descriptionController.text;

    final t = context.t;

    final loader = widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(t.products_editProductDialog_updatingProduct),
          subtitle: Text(t.products_editProductDialog_updatingProductWith(widget.product.id)),
          trailingAlignment: Alignment.center,
          trailing: const CircularProgressIndicator(),
        ),
      ),
      const Duration(minutes: 1),
    );

    try {
      await products.updateProduct(
        id: widget.product.id,
        name: name,
        description: description,
      );
    } catch (e) {
      widget.showToast(
        (_, __) => SurfaceCard(
          child: Basic(
            title: Text(t.products_editProductDialog_errorUpdating),
            subtitle: Text(t.products_editProductDialog_errorUpdatingWith(widget.product.id)),
            trailingAlignment: Alignment.center,
            trailing: const Icon(Icons.error, color: Colors.red),
          ),
        ),
        const Duration(seconds: 3),
      );
    } finally {
      loader.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: AlertDialog(
        title: Text(t.products_editProductDialog_editProductWithID(widget.product.id)),
        content: Form(
          child: FormTableLayout(
            rows: [
              FormField<String>(
                label: Text(t.products_createProductDialog_nameLabel),
                key: const FormKey(#name),
                validator: NotEmptyValidator(message: t.products_createProductDialog_nameRequired),
                child: TextField(
                  controller: nameController,
                  placeholder: t.products_createProductDialog_namePlaceholder,
                  initialValue: widget.product.name,
                ),
              ),
              FormField<String>(
                label: Text(t.products_createProductDialog_descriptionLabel),
                key: const FormKey(#description),
                validator: NotEmptyValidator(message: t.products_createProductDialog_descriptionRequired),
                child: TextArea(
                  controller: descriptionController,
                  placeholder: t.products_createProductDialog_descriptionPlaceholder,
                  initialValue: widget.product.description,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.t.global_cancel),
          ),
          TextButton(
            onPressed: _editProduct,
            child: Text(t.products_editProductDialog_updateProduct),
          ),
        ],
      ),
    );
  }
}
