import 'package:awesome_extensions/awesome_extensions.dart' hide ExpandedExtension, ThemeExt;
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/dashboard/dashboard.dart';

import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

class CustomerPayments extends StatefulWidget {
  const CustomerPayments({super.key, required this.customer});

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
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final customerLicense = licenses.state.requireData.firstWhere((license) => license.customerId == widget.customer.id && license.userId == null);
    final customerPayments = payments.state.requireData.where((payment) => payment.licenseKey == customerLicense.licenseKey).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payments from this customer (${customerLicense.licenseKey})').large().bold(),
        const SizedBox(height: 30),
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
                        Text(payment.paymentReference ?? 'No payment reference'),
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
                          Text('Revoked: ${payment.revocationReasoning ?? 'No reason provided'}').expanded(),
                        ],
                      ),
                  ],
                ),
            ],
          ).expanded(),
        ),
      ],
    ).paddingAll(10);
  }
}
