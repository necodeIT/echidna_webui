import 'package:awesome_extensions/awesome_extensions.dart' hide ThemeExt, ExpandedExtension;
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays a summary of a [license].
class LicenseCard extends StatelessWidget {
  /// Displays a summary of a [license].
  const LicenseCard({super.key, required this.license});

  /// The license to summarize.
  final License license;

  /// Date formatter for the activation and expiration dates.
  static final formatter = DateFormat('dd.MM.yyyy');

  /// ¯\_(ツ)_/¯ (^///^)^_^╰(*°▽°*)╯☆*: .｡. o(≧▽≦)o .｡.:*☆╰(*°▽°*)╯╰(*°▽°*)╯
  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();

    return SizedBox(
      height: 350,
      width: CustomerCard.width,
      child: FutureBuilder(
        future: licenses.getStatus(license),
        builder: (context, state) {
          return Card(
            // padding: const EdgeInsets.all(15),
            child: Builder(
              builder: (context) {
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(BootstrapIcons.personFill),
                        const SizedBox(width: 10),
                        Text(
                          license.isCustomerWide
                              ? context.t.licenses_licenseCard_customerWideLicense
                              : context.t.licenses_licenseCard_userId(license.userId.toString()),
                        ).bold(),
                      ],
                    ),
                    Row(
                      children: [
                        if (!status.active)
                          Icon(BootstrapIcons.xCircleFill, color: context.theme.colorScheme.destructive)
                        else
                          Icon(BootstrapIcons.checkCircleFill, color: context.theme.colorScheme.primary),
                        const SizedBox(width: 10),
                        Text(status.active ? context.t.licenses_licenseCard_active : context.t.licenses_licenseCard_inactive),
                      ],
                    ),
                    if (status.activationDate != null)
                      Row(
                        children: [
                          const Icon(BootstrapIcons.calendar2CheckFill),
                          const SizedBox(width: 10),
                          Text(context.t.licenses_licenseCard_activatedOn(formatter.format(status.activationDate!))),
                        ],
                      ),
                    if (status.expirationDate != null)
                      Row(
                        children: [
                          const Icon(BootstrapIcons.calendar2XFill),
                          const SizedBox(width: 10),
                          Text(context.t.licenses_licenseCard_expiresOn(formatter.format(status.expirationDate!))),
                        ],
                      ),
                    Expanded(
                      child: LicenseFeatures(license: license, status: status),
                    ),
                  ].separatedby(const SizedBox(height: 15)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
