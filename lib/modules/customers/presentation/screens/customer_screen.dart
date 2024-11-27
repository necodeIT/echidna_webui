import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/uicons.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: customer != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Button.link(
                  onPressed: () {
                    launchUrl(Uri.parse('mailto:${customer.email}'));
                  },
                  child: Row(
                    children: [
                      Icon(
                        UiconsSolid.password_email,
                        size: 16,
                        color: context.theme.colorScheme.mutedForeground,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          customer.email,
                          style: context.theme.typography.small.copyWith(
                            color: context.theme.colorScheme.mutedForeground,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ).textLeft(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerProducts(customer: customer).expanded(),
                    const SizedBox(width: 20),
                    CustomerLicenses(customer: customer).expanded(),
                    const SizedBox(width: 20),
                    CustomerPayments(customer: customer).expanded(),
                  ],
                ).expanded(),
              ],
            ).withPadding(all: 20)
          : const SizedBox(),
    );
  }
}
