import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that allows the user to create a new customer.
class CreateCustomerDialog extends StatefulWidget {
  /// A dialog that allows the user to create a new customer.
  const CreateCustomerDialog({super.key, required this.showToast});

  /// {@macro show_toast}
  final ShowToast showToast;

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

    Navigator.of(context).pop();

    final customers = context.read<CustomersRepository>();

    final name = nameController.text;
    final email = emailController.text;

    final t = context.t;

    final loader = widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(t.customers_createCustomerDialog_creatingCustomer),
          subtitle: Text(t.customers_createCustomerDialog_creatingCustomerWith(name, email)),
          trailingAlignment: Alignment.center,
          trailing: const CircularProgressIndicator(),
        ),
      ),
      const Duration(minutes: 1),
    );

    try {
      await customers.createCustomer(
        name: name,
        email: email,
      );

      Future.delayed(const Duration(milliseconds: 300), loader.close);
      widget.showToast(
        (_, toast) => SurfaceCard(
          child: Basic(
            title: Text(t.customers_createCustomerDialog_customerCreated),
            subtitle: Text(t.customers_createCustomerDialog_successfullyCreated(name, email)),
            trailingAlignment: Alignment.center,
            trailing: IconButton.ghost(
              icon: const Icon(RadixIcons.cross2),
              onPressed: toast.close,
            ),
          ),
        ),
      );
    } catch (e) {
      Future.delayed(const Duration(milliseconds: 300), loader.close);

      widget.showToast(
        (_, toast) => SurfaceCard(
          child: Basic(
            title: Text(context.t.customers_createCustomerDialog_failedToCreate),
            subtitle: Text(context.t.customers_createCustomerDialog_failedToCreateTryAgain),
            trailingAlignment: Alignment.center,
            trailing: IconButton.ghost(
              icon: const Icon(RadixIcons.cross2),
              onPressed: toast.close,
            ),
          ),
        ),
      );

      isCreating = false;
    } finally {
      isCreating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.customers_createCustomerDialog_createNewCustomer),
      content: SizedBox(
        width: 400,
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

/// {@template show_toast}
/// A function that shows a toast overlay.
///
/// Used to avoid unmounted errors when showing a toast after the dialog is closed.
/// {@endtemplate}
typedef ShowToast = ToastOverlay Function(Widget Function(BuildContext, ToastOverlay) builder, [Duration? showDuration]);
