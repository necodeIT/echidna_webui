import 'dart:async';

import 'package:echidna_webui/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Responsible for fetching a list of available client SDKs.
abstract class ClientSdkDatasource extends Datasource {
  @override
  String get name => 'ClientSdk';

  /// Fetches a list of available client SDKs.
  Future<List<ClientSdk>> getAvailableClientSdks();

  /// Fetches the installation instructions the given [sdk] in the given [language].
  ///
  /// The keys are the title of the step and the values are the instructions of that step in markdown format.
  Future<Map<String, String>> getInstructions(ClientSdk sdk, String language);
}
