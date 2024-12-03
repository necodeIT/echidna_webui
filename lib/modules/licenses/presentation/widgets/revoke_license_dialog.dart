import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Confirm dialog for revoking a license.
class RevokeLicenseDialog extends ToastConsumer {
  /// License to revoke.
  final List<License> licenses;

  /// Confirm dialog for revoking a license.
  const RevokeLicenseDialog({super.key, required this.licenses, required super.showToast});

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

    final loader = showLoadingToast(
      title: t.licenses_revokeLicenseDialog_revokingLicense,
      subtitle: t.licenses_revokeLicenseDialog_revokingLicenseWith(widget.licenses.length),
    );

    try {
      for (final license in widget.licenses) {
        await licenses.revokeLicense(licenseKey: license.licenseKey, revocationReason: revocationReason);
        showSuccessToast(
          title: t.licenses_revokeLicenseDialog_revokedLicense,
          subtitle: t.licenses_revokeLicenseDialog_revokedLicenseWith(license.licenseKey),
        );
      }

      loader.close();
    } catch (e) {
      loader.close();

      showErrorToast(
        title: t.licenses_revokeLicenseDialog_errorRevoking,
        subtitle: t.licenses_revokeLicenseDialog_errorRevokingWith(widget.licenses.length),
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
                  placeholder: Text(context.t.licenses_revokeLicenseDialog_revocationReasonPlaceholder),
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
