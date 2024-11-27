import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A screen that displays all customers.
class CustomersScreen extends StatefulWidget {
  /// A screen that displays all customers.
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomersRepository>();

    return Scaffold(
      loadingProgressIndeterminate: customers.state.isLoading,
      headers: [
        AppBar(
          title: Text(context.t.customers_customersScreen_title),
          trailing: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: searchController,
                placeholder: Text(context.t.customers_customersScreen_searchCustomers),
                leading: const Icon(RadixIcons.magnifyingGlass),
              ),
            ),
            const SizedBox(width: 10),
            Tooltip(
              tooltip: Text(context.t.customers_customersScreen_newCustomer),
              child: IconButton.outline(
                icon: const Icon(RadixIcons.plus),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => CreateCustomerDialog(showToast: createShowToastHandler(context)),
                  );
                },
              ),
            ),
          ],
        ),
      ],
      child: !customers.state.hasData
          ? const SizedBox()
          : SingleChildScrollView(
              controller: ScrollController(),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: customers.search(searchController.text).map(CustomerCard.withoutKey).toList(),
              ).withPadding(all: 20),
            ),
    );
  }
}
