import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Edit product dialog.
class EditProductDialog extends ToastConsumer {
  /// Edit product dialog.
  const EditProductDialog({super.key, required super.showToast, required this.product});

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

    final loader = showLoadingToast(
      title: t.products_editProductDialog_updatingProduct,
      subtitle: t.products_editProductDialog_updatingProductWith(widget.product.id),
    );

    try {
      await products.updateProduct(
        id: widget.product.id,
        name: name,
        description: description,
      );
    } catch (e) {
      showErrorToast(
        title: t.products_editProductDialog_errorUpdating,
        subtitle: t.products_editProductDialog_errorUpdatingWith(widget.product.id),
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
                label: Text(t.global_name),
                key: const FormKey(#name),
                validator: NotEmptyValidator(message: t.global_nameRequired),
                child: TextField(
                  controller: nameController,
                  placeholder: Text(t.products_createProductDialog_namePlaceholder),
                  initialValue: widget.product.name,
                ),
              ),
              FormField<String>(
                label: Text(t.global_description),
                key: const FormKey(#description),
                validator: NotEmptyValidator(message: t.global_descriptionRequired),
                child: TextArea(
                  controller: descriptionController,
                  placeholder: Text(t.products_createProductDialog_descriptionPlaceholder),
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
