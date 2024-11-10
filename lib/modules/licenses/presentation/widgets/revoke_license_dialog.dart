import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Confirm dialog for revoking a license.
class RevokeLicenseDialog extends StatefulWidget {
  /// License to revoke.
  final License license;

  /// {@macro show_toast}
  final ShowToast showToast;

  /// Confirm dialog for revoking a license.
  const RevokeLicenseDialog({super.key, required this.license, required this.showToast});

  @override
  State<RevokeLicenseDialog> createState() => _RevokeLicenseDialogState();
}

class _RevokeLicenseDialogState extends State<RevokeLicenseDialog> {
  final revocationReasonController = TextEditingController();

  bool isRevoking = false;

  Future<void> _revokeLicense() async {
    if (isRevoking) {
      return;
    }

    if (revocationReasonController.text.isEmpty) {
      return;
    }

    isRevoking = true;

    final licenses = context.read<LicensesRepository>();

    final revocationReason = revocationReasonController.text;

    final t = context.t;

    Navigator.of(context).pop();

    final loader = widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(t.licenses_revokeLicenseDialog_revokingLicense),
          subtitle: Text(t.licenses_revokeLicenseDialog_revokingLicenseWith(widget.license.licenseKey)),
          trailingAlignment: Alignment.center,
          trailing: const CircularProgressIndicator(),
        ),
      ),
      const Duration(minutes: 1),
    );

    try {
      await licenses.revokeLicense(licenseKey: widget.license.licenseKey, revocationReason: revocationReason);

      widget.showToast(
        (_, __) => SurfaceCard(
          child: Basic(
            title: Text(t.licenses_revokeLicenseDialog_revokedLicense),
            subtitle: Text(t.licenses_revokeLicenseDialog_revokedLicenseWith(widget.license.licenseKey)),
            trailingAlignment: Alignment.center,
            trailing: Icon(RadixIcons.check, color: context.theme.colorScheme.primary),
          ),
        ),
      );

      loader.close();
    } catch (e) {
      loader.close();

      widget.showToast(
        (_, __) => SurfaceCard(
          child: Basic(
            title: Text(t.licenses_revokeLicenseDialog_errorRevoking),
            subtitle: Text(t.licenses_revokeLicenseDialog_errorRevokingWith(widget.license.licenseKey)),
            trailingAlignment: Alignment.center,
            trailing: const Icon(Icons.error),
          ),
        ),
      );
    } finally {
      isRevoking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.licenses_revokeLicenseDialog_revokeLicense),
      content: SizedBox(
        width: 500,
        child: Form(
          child: FormTableLayout(
            rows: [
              FormField<String>(
                key: const FormKey(#revocationReason),
                label: Text(context.t.licenses_revokeLicenseDialog_revocationReasonLabel),
                validator: NotEmptyValidator(message: context.t.licenses_revokeLicenseDialog_revocationReasonRequired),
                child: TextArea(
                  controller: revocationReasonController,
                  placeholder: context.t.licenses_revokeLicenseDialog_revocationReasonPlaceholder,
                ),
              ),
            ],
          ),
        ),
      ).withPadding(all: 20),
      actions: [
        Button.primary(
          onPressed: _revokeLicense,
          child: Text(context.t.licenses_revokeLicenseDialog_revoke),
        ),
        Button.secondary(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.t.global_cancel),
        ),
      ],
    );
  }
}
