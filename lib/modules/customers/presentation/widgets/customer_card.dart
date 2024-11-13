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
  const CustomerCard({super.key, required this.customer, this.enableActions = true});

  /// Displays a card with information about a given customer.
  CustomerCard.withoutKey(this.customer)
      : enableActions = true,
        super(key: ValueKey(customer.id));

  /// The customer to display.
  final Customer customer;

  /// Whether to enable actions on the card.
  ///
  /// If `false`, the edit button, delete button, and clicking on the card to navigate to the customer's details will be disabled.
  final bool enableActions;

  /// The width of the card.
  static const width = 350.0;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        if (enableActions) Modular.to.navigate('/customers/${customer.id}');
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
                  if (enableActions)
                    IconButton(
                      icon: const Icon(RadixIcons.pencil1),
                      variance: ButtonVariance.ghost,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditCustomerDialog(
                            customer: customer,
                            showToast: createShowToastHandler(context),
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
              if (enableActions) const SizedBox(height: 10),
              if (enableActions)
                Divider(
                  height: 20,
                  color: context.theme.colorScheme.border,
                ),
              if (enableActions)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => DeleteCustomerDialog(
                          customer: customer,
                          showToast: createShowToastHandler(context),
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
