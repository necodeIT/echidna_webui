import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that allows the user to create a new customer.
class CreateCustomerDialog extends ToastConsumer {
  /// A dialog that allows the user to create a new customer.
  const CreateCustomerDialog({super.key, required super.showToast});

  @override
  State<CreateCustomerDialog> createState() => _CreateCustomerDialogState();
}

class _CreateCustomerDialogState extends State<CreateCustomerDialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formController = FormController();

  bool isCreating = false;

  Future<void> _createCustomer() async {
    if (isCreating) {
      return;
    }

    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      return;
    }

    isCreating = true;

    final customers = context.read<CustomersRepository>();

    final name = nameController.text;
    final email = emailController.text;

    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: t.customers_createCustomerDialog_creatingCustomer,
      subtitle: t.customers_createCustomerDialog_creatingCustomerWith(name, email),
    );

    try {
      await customers.createCustomer(
        name: name,
        email: email,
      );

      showSuccessToast(
        title: t.customers_createCustomerDialog_customerCreated,
        subtitle: t.customers_createCustomerDialog_successfullyCreated(name, email),
      );
    } catch (e) {
      showErrorToast(
        title: t.customers_createCustomerDialog_failedToCreate,
        subtitle: t.customers_createCustomerDialog_failedToCreateTryAgain,
      );
    } finally {
      loader.close();
      isCreating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.customers_createCustomerDialog_createNewCustomer),
      content: SizedBox(
        width: 500,
        child: Form(
          controller: formController,
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
          ).withPadding(all: 20),
          onSubmit: (_, __) => _createCustomer,
        ),
      ),
      actions: [
        PrimaryButton(
          onPressed: _createCustomer,
          child: Text(context.t.global_create),
        ),
      ],
    );
  }
}
