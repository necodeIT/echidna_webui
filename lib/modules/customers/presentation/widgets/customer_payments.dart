import 'package:awesome_extensions/awesome_extensions.dart' hide ExpandedExtension, ThemeExt;
import 'package:collection/collection.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/dashboard/dashboard.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/licenses/presentation/repositories/licenses_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Displays the payment history of a customer.
class CustomerPayments extends StatefulWidget {
  /// Displays the payment history of a customer.
  const CustomerPayments({super.key, required this.customer});

  /// The customer to display the payments for.
  final Customer customer;

  @override
  State<CustomerPayments> createState() => _CustomerPaymentsState();
}

class _CustomerPaymentsState extends State<CustomerPayments> {
  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();
    final payments = context.watch<PaymentsRepository>();

    if (!licenses.state.hasData || !payments.state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final customerLicense =
        licenses.state.requireData.firstWhereOrNull((license) => license.customerId == widget.customer.id && license.userId == null);

    final customerPayments =
        customerLicense != null ? payments.state.requireData.where((payment) => payment.licenseKey == customerLicense.licenseKey).toList() : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.t.customers_customerPaymentsWidget_customerPayments).large().bold(),
        Text(
          customerLicense != null ? customerLicense.licenseKey : 'No customer wide license found',
        ).muted(),
        const SizedBox(height: 30),
        if (customerPayments != null)
          SingleChildScrollView(
            child: Steps(
              children: [
                for (final payment in customerPayments)
                  StepItem(
                    title: Text(LicenseCard.formatter.format(payment.activationDate)),
                    content: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(BootstrapIcons.coin),
                          const SizedBox(width: 10),
                          Text(payment.paymentReference ?? context.t.customers_customerPayments_noPaymentReference),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            BootstrapIcons.calendar2XFill,
                            color: payment.expirationDate.isBefore(DateTime.now()) ? context.theme.colorScheme.destructive : null,
                          ),
                          const SizedBox(width: 10),
                          Text(LicenseCard.formatter.format(payment.expirationDate)),
                        ],
                      ),
                      if (payment.revoked) const SizedBox(height: 10),
                      if (payment.revoked)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              UiconsSolid.gavel,
                              color: context.theme.colorScheme.destructive,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.t.customers_customerPayments_revokedFor(
                                payment.revocationReasoning ?? context.t.customers_customerPayments_noReasonProvided,
                              ),
                            ).expanded(),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          ).expanded(),
      ],
    ).paddingAll(10);
  }
}
