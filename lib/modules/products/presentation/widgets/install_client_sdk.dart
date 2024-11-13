import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InstallClientSdk extends StatelessWidget {
  const InstallClientSdk({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text('Install client SDK for ${product.name}');
  }
}
