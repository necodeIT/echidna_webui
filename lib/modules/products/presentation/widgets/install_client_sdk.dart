import 'package:echidna_dto/echidna_dto.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays a step by step guide to install the client SDK for a product.
class InstallClientSdk extends StatelessWidget {
  /// Displays a step by step guide to install the client SDK for a product.
  const InstallClientSdk({super.key, required this.product});

  /// The product to install the client SDK for.
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text('Install client SDK for ${product.name}');
  }
}
