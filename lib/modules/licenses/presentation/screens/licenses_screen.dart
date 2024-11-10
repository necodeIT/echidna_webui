import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays all licenses.
class LicensesScreen extends StatelessWidget {
  /// Displays all licenses.
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();
    final products = context.watch<ProductsRepository>();
    final customers = context.watch<CustomersRepository>();

    final state = licenses.state.join(products.state).join(customers.state);

    return Scaffold(
      loadingProgressIndeterminate: state.isLoading,
      headers: [
        AppBar(
          title: Text(context.t.licenses_licensesScreen_title),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: LicensesTable(),
      ),
    );
  }
}
