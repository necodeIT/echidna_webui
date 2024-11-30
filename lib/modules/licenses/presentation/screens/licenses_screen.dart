import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              Text(context.t.licenses_licensesScreen_title),
            ],
          ),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: LicensesTable(),
      ),
    );
  }
}
