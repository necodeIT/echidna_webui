import 'package:collection/collection.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog to create a new license.
class CreateCustomerLicenseDialog extends ToastConsumer {
  /// Dialog to create a new license.
  const CreateCustomerLicenseDialog({super.key, required super.showToast});

  @override
  State<CreateCustomerLicenseDialog> createState() => _CreateCustomerLicenseDialogState();
}

class _CreateCustomerLicenseDialogState extends State<CreateCustomerLicenseDialog> {
  final formController = FormController();

  Customer? _customer;
  Product? _product;

  bool isCreating = false;

  Future<void> _createCustomerLicense() async {
    if (isCreating) {
      return;
    }

    if (_customer == null || _product == null) {
      return;
    }

    isCreating = true;

    final licenses = context.watch<LicensesRepository>();

    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: t.licenses_createCustomerLicenseDialog_creatingCustomerLicense,
      subtitle: t.licenses_createCustomerLicenseDialog_creatingCustomerLicenseWith(_product!.name, _customer!.name),
    );

    try {
      final existingCustomerLicense = licenses.state.requireData
          .firstWhereOrNull((license) => license.customerId == _customer!.id && license.productId == _product!.id && license.userId == null);

      if (existingCustomerLicense != null) {
        showErrorToast(
          title: t.licenses_createCustomerLicenseDialog_customerLicenseAlreadyExists,
          subtitle: t.licenses_createCustomerLicenseDialog_customerLicenseAlreadyExistsWith(_product!.name, _customer!.name),
        );
        return;
      }

      await licenses.createCustomerLicense(customerId: _customer!.id, productId: _product!.id);
      showSuccessToast(
        title: t.licenses_createCustomerLicenseDialog_successCustomerLicense,
        subtitle: t.licenses_createCustomerLicenseDialog_successCustomerLicenseWith(_product!.name, _customer!.name),
      );
    } catch (e) {
      showErrorToast(
        title: t.licenses_createCustomerLicenseDialog_errorCustomerLicense,
        subtitle: t.licenses_createCustomerLicenseDialog_errorCustomerLicenseWith(_product!.name, _customer!.name),
      );
    } finally {
      loader.close();
      isCreating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomersRepository>();

    final products = context.watch<ProductsRepository>();

    return AlertDialog(
      title: Text(t.licenses_createCustomerLicenseDialog_title),
      content: SizedBox(
        width: 500,
        child: Form(
          controller: formController,
          child: FormTableLayout(
            rows: [
              FormField(
                key: const FormKey(#customer),
                label: Text(t.licenses_createCustomerLicenseDialog_customerLabel),
                child: Select<Customer>(
                  popupConstraints: const BoxConstraints(maxWidth: 150),
                  value: _customer,
                  onChanged: (c) {
                    setState(() {
                      _customer = c;
                    });
                  },
                  itemBuilder: (context, c) => Text(c.name),
                  searchFilter: (c, query) => c.name.containsIgnoreCase(query) ? 1 : 0,
                  placeholder: Text(t.licenses_createCustomerLicenseDialog_customerPlaceholder),
                  children: [
                    for (final c in customers.state.requireData)
                      SelectItemButton(
                        value: c,
                        child: Text(c.name),
                      ),
                  ],
                ),
              ),
              FormField(
                key: const FormKey(#product),
                label: Text(t.licenses_createCustomerLicenseDialog_productLabel),
                child: Select<Product>(
                  popupConstraints: const BoxConstraints(maxWidth: 150),
                  value: _product,
                  onChanged: (p) {
                    setState(() {
                      _product = p;
                    });
                  },
                  itemBuilder: (context, p) => Text(p.name),
                  searchFilter: (p, query) => p.name.containsIgnoreCase(query) ? 1 : 0,
                  placeholder: Text(t.licenses_createCustomerLicenseDialog_productPlaceholder),
                  children: [
                    for (final p in products.state.requireData)
                      SelectItemButton(
                        value: p,
                        child: Text(p.name),
                      ),
                  ],
                ),
              ),
            ],
          ).withPadding(all: 20),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.t.global_cancel),
        ),
        PrimaryButton(
          onPressed: _createCustomerLicense,
          child: Text(context.t.global_create),
        ),
      ],
    );
  }
}
