import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RevokeClientKeyDialog extends ToastConsumer {
  const RevokeClientKeyDialog({super.key, required this.product, required this.customer, required super.showToast});

  final Product product;
  final Customer customer;

  @override
  State<RevokeClientKeyDialog> createState() => _RevokeClientSdkDialogState();
}

class _RevokeClientSdkDialogState extends State<RevokeClientKeyDialog> {
  bool isRevoking = false;

  Future<void> _revokeClientKey() async {
    if (isRevoking) {
      return;
    }

    isRevoking = true;

    final clientSdk = context.watch<ClientSdkRepository>();
    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: t.products_revokeClientKeyDialog_revokingClientKey,
      subtitle: t.products_revokeClientKeyDialog_revokingClientKeyWith(widget.customer.name),
    );

    try {
      final clientKey = await clientSdk.getClientKeys(
        customerIds: [widget.customer.id],
        productIds: [widget.product.id],
      );

      await clientSdk.revokeClientKey(key: clientKey.first.key);

      showSuccessToast(
        title: t.products_revokeClientKeyDialog_revokedClientKey,
        subtitle: t.products_revokeClientKeyDialog_revokedClientKeyWith(widget.customer.name),
      );
    } catch (e) {
      showErrorToast(
        title: t.products_revokeClientKeyDialog_errorRevokingClientKey,
        subtitle: t.products_revokeClientKeyDialog_errorRevokingClientKeyWith(widget.customer.name),
      );
    } finally {
      loader.close();
      isRevoking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.products_revokeClientKeyDialog_popUpTitle),
      content: SizedBox(
        width: 500,
        child: Text(context.t.products_revokeClientKeyDialog_popUpText(widget.customer.name)),
      ).withPadding(all: 20),
      actions: [
        Button.primary(
          onPressed: _revokeClientKey,
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
