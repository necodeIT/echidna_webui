import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that allows the user to edit a given [customer].
class EditCustomerDialog extends StatefulWidget {
  /// A dialog that allows the user to edit a given [customer].
  const EditCustomerDialog({super.key, required this.customer, required this.showToast});

  /// The customer to edit.
  final Customer customer;

  /// {@macro show_toast}
  final ShowToast showToast;

  @override
  State<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.customer.name);
    emailController = TextEditingController(text: widget.customer.email);
  }

  Future<void> _editCustomer() async {
    if (isUpdating) {
      return;
    }

    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      return;
    }

    isUpdating = true;

    final customers = Modular.get<CustomersRepository>();

    final t = context.t;

    Navigator.of(context).pop();

    final loader = widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(t.customers_editCustomerDialog_updatingCustomer),
          subtitle: Text(t.customers_editCustomerDialog_updatingCustomerWith(widget.customer.id.toString())),
          trailingAlignment: Alignment.center,
          trailing: const CircularProgressIndicator(),
        ),
      ),
      const Duration(minutes: 1),
    );

    final name = nameController.text;
    final email = emailController.text;

    try {
      await customers.updateCustomer(
        id: widget.customer.id,
        name: name,
        email: email,
      );

      loader.close();
    } catch (e) {
      loader.close();
      widget.showToast(
        (_, __) => SurfaceCard(
          child: Basic(
            title: Text(t.customers_editCustomerDialog_errorUpdating),
            subtitle: Text(t.customers_editCustomerDialog_errorUpdatingWith(widget.customer.id.toString())),
          ),
        ),
        const Duration(seconds: 5),
      );
    } finally {
      isUpdating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.customers_editCustomerDialog_editCustomerWithId(widget.customer.id.toString())),
      content: SizedBox(
        width: 400,
        child: Form(
          child: FormTableLayout(
            rows: [
              FormField<String>(
                key: const FormKey(#name),
                label: Text(context.t.customers_createCustomerDialog_nameLabel),
                validator: NotEmptyValidator(message: context.t.customers_createCustomerDialog_nameRequired),
                child: TextField(
                  controller: nameController,
                  placeholder: context.t.customers_createCustomerDialog_namePlaceholder,
                ),
              ),
              FormField<String>(
                key: const FormKey(#email),
                label: Text(context.t.customers_createCustomerDialog_emailLabel),
                validator: NotEmptyValidator(message: context.t.customers_createCustomerDialog_emailRequired) +
                    EmailValidator(message: context.t.customers_createCustomerDialog_invalidEmail),
                child: TextField(
                  controller: emailController,
                  placeholder: context.t.customers_createCustomerDialog_emailPlaceholder,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(t.global_cancel),
        ),
        TextButton(
          onPressed: _editCustomer,
          child: Text(t.customers_editCustomerDialog_updateCustomer),
        ),
      ],
    );
  }
}
