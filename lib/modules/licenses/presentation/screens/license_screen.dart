import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/dashboard/dashboard.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// Shows details of a single license.
class LicenseScreen extends StatelessWidget {
  /// The license key to show details for.
  final String licenseKey;

  /// Shows details of a single license.
  const LicenseScreen({super.key, required this.licenseKey});

  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();
    final payments = context.watch<PaymentsRepository>();
    final customers = context.watch<CustomersRepository>();
    final products = context.watch<ProductsRepository>();

    final loading = !licenses.state.hasData || !payments.state.hasData || !customers.state.hasData || !products.state.hasData;

    return Scaffold(
      loadingProgressIndeterminate: loading,
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              TextButton(
                density: ButtonDensity.compact,
                onPressed: () {
                  Modular.to.navigate('/licenses');
                },
                child: Text(context.t.licenses_licensesScreen_title),
              ),
              Text(licenseKey),
            ],
          ),
        ),
      ],
      child: loading
          ? const SizedBox.shrink()
          : Builder(
              builder: (context) {
                final license = licenses.byKey(licenseKey)!;

                final licenseCustomer = customers.byId(license.customerId)!;
                final licenseProduct = products.byId(license.productId)!;

                return FutureBuilder(
                  future: licenses.getHistory(license),
                  builder: (context, historyState) {
                    if (!historyState.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final licensePayments = historyState.requireData;

                    return FutureBuilder(
                      future: licenses.getStatus(license),
                      builder: (context, state) {
                        if (!state.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final status = state.requireData;

                        if (status == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              license.isCustomerWide
                                  ? context.t.licenses_licenseCard_customerWideLicense
                                  : context.t.licenses_licenseCard_userId(license.userId.toString()),
                            ).h3(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                if (!status.active)
                                  Icon(BootstrapIcons.xCircleFill, color: context.theme.colorScheme.destructive)
                                else
                                  Icon(BootstrapIcons.checkCircleFill, color: context.theme.colorScheme.primary),
                                const SizedBox(width: 10),
                                Text(
                                  license.licenseKey,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CustomerCard(
                                            customer: licenseCustomer,
                                            enableActions: false,
                                          ),
                                          const SizedBox(width: 20),
                                          ProductCard(
                                            product: licenseProduct,
                                            enableActions: false,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          SingleChildScrollView(
                                            child: Steps(
                                              children: [
                                                for (final payment in licensePayments)
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
                                                            color: payment.expirationDate.isBefore(DateTime.now())
                                                                ? context.theme.colorScheme.destructive
                                                                : null,
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
                                                      const SizedBox(height: 10),
                                                      for (final feature in payment.features)
                                                        HoverCard(
                                                          anchorAlignment: Alignment.bottomLeft,
                                                          popoverOffset: const Offset(200, 10),
                                                          hoverBuilder: (_) => SizedBox(
                                                            height: 150,
                                                            child: FeatureCard(feature: feature),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              if (feature.type == FeatureType.free)
                                                                const Icon(UiconsSolid.hands_heart)
                                                              else
                                                                const Icon(UiconsSolid.coin),
                                                              const SizedBox(width: 10),
                                                              Text(feature.name),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ).expanded(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: LicenseFeatures(
                                    license: license,
                                    status: status,
                                  ),
                                ),
                              ],
                            ).expanded(),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ).withPadding(all: 20),
    );
  }
}
