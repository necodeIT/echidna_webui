import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that prompts the user to confirm the deletion of a given [customer].
class DeleteCustomerDialog extends StatefulWidget {
  /// A dialog that prompts the user to confirm the deletion of a given [customer].
  const DeleteCustomerDialog({super.key, required this.customer, required this.showToast});

  /// The customer to delete.
  final Customer customer;

  /// {@macro show_toast}
  final ShowToast showToast;

  @override
  State<DeleteCustomerDialog> createState() => _DeleteCustomerDialogState();
}

class _DeleteCustomerDialogState extends State<DeleteCustomerDialog> {
  bool isDeleting = false;

  Future<void> _deleteCustomer() async {
    if (isDeleting) {
      return;
    }

    isDeleting = true;

    final customers = Modular.get<CustomersRepository>();

    final t = context.t;

    Navigator.of(context).pop();

    final loader = widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(t.customers_deleteCustomerDialog_deletingCustomer),
          subtitle: Text(t.customers_deleteCustomerDialog_deletingCustomerWith(widget.customer.name)),
          trailingAlignment: Alignment.center,
          trailing: const CircularProgressIndicator(),
        ),
      ),
      const Duration(minutes: 1),
    );

    try {
      await customers.deleteCustomer(widget.customer.id);
    } catch (e) {
      widget.showToast(
        (_, __) => SurfaceCard(
          child: Basic(
            title: Text(t.customers_deleteCustomerDialog_errorDeleting),
            subtitle: Text(t.customers_deleteCustomerDialog_errorDeletingWith(widget.customer.name)),
          ),
        ),
        const Duration(seconds: 5),
      );
    } finally {
      loader.close();
      isDeleting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.customers_deleteCustomerDialog_deleteCustomerCheck),
      content: Text(t.customers_deleteCustomerDialog_deleteCustomerWithCheck(widget.customer.name)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(t.global_cancel),
        ),
        TextButton(
          onPressed: _deleteCustomer,
          child: Text(t.global_delete, style: theme.typography.semiBold.copyWith(color: theme.colorScheme.destructive)),
        ),
      ],
    );
  }
}
