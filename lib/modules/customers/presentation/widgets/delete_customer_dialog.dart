import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A dialog that prompts the user to confirm the deletion of a given [customer].
class DeleteCustomerDialog extends ToastConsumer {
  /// A dialog that prompts the user to confirm the deletion of a given [customer].
  const DeleteCustomerDialog({super.key, required this.customer, required super.showToast});

  /// The customer to delete.
  final Customer customer;

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

    final loader = showLoadingToast(
      title: t.customers_deleteCustomerDialog_deletingCustomer,
      subtitle: t.customers_deleteCustomerDialog_deletingCustomerWith(widget.customer.name),
    );

    try {
      await customers.deleteCustomer(widget.customer.id);
    } catch (e) {
      showErrorToast(
        title: t.customers_deleteCustomerDialog_errorDeleting,
        subtitle: t.customers_deleteCustomerDialog_errorDeletingWith(widget.customer.name),
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
