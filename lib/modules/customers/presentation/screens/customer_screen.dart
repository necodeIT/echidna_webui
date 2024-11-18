import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays advanced details of a customer.
class CustomerScreen extends StatelessWidget {
  /// The ID of the customer to display.
  final int id;

  /// Displays advanced details of a customer.
  const CustomerScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomersRepository>();

    final customer = customers.byId(id);

    return Scaffold(
      loadingProgressIndeterminate: customers.state.isLoading,
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              TextButton(
                density: ButtonDensity.compact,
                onPressed: () {
                  Modular.to.navigate('/customers');
                },
                child: Text(context.t.customers_customersScreen_title),
              ),
              Text(customer?.name ?? id.toString()),
            ],
          ),
        ),
      ],
      child: const SizedBox(),
    );
  }
}
