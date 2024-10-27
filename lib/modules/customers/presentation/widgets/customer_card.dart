import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays a card with information about a given customer.
class CustomerCard extends StatelessWidget {
  /// Displays a card with information about a given customer.
  const CustomerCard({super.key, required this.customer});

  /// Displays a card with information about a given customer.
  CustomerCard.withoutKey(this.customer) : super(key: ValueKey(customer.id));

  /// The customer to display.
  final Customer customer;

  /// The width of the card.
  static const width = 350.0;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        Modular.to.navigate('/customers/${customer.id}');
      },
      child: SizedBox(
        width: width,
        child: Card(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Avatar(
                    initials: Avatar.getInitials(customer.name),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OverflowMarquee(
                      delayDuration: const Duration(seconds: 5),
                      duration: const Duration(seconds: 10),
                      child: Text(
                        customer.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(RadixIcons.pencil1),
                    variance: ButtonVariance.ghost,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => EditCustomerDialog(
                          customer: customer,
                          showToast: createShowTostHandler(context),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              Divider(
                height: 20,
                color: context.theme.colorScheme.border,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteCustomerDialog(
                        customer: customer,
                        showToast: createShowTostHandler(context),
                      ),
                    );
                  },
                  child: Text(
                    context.t.global_delete,
                    style: context.theme.typography.semiBold.copyWith(
                      color: context.theme.colorScheme.destructive,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
