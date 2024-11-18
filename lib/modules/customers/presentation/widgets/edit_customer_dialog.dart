import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that allows the user to edit a given [customer].
class EditCustomerDialog extends ToastConsumer {
  /// A dialog that allows the user to edit a given [customer].
  const EditCustomerDialog({super.key, required this.customer, required super.showToast});

  /// The customer to edit.
  final Customer customer;

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

    final loader = showLoadingToast(
      title: t.customers_editCustomerDialog_updatingCustomer,
      subtitle: t.customers_editCustomerDialog_updatingCustomerWith(widget.customer.id.toString()),
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
      showErrorToast(
        title: t.customers_editCustomerDialog_errorUpdating,
        subtitle: t.customers_editCustomerDialog_errorUpdatingWith(widget.customer.id.toString()),
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
        width: 500,
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
