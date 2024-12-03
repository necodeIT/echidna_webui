import 'package:dotenv/dotenv.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Holds the available client SDKs.
class ClientSdkRepository extends Repository<AsyncValue<List<ClientSdk>>> {
  final ClientSdkDatasource _datasource;
  final ClientKeyDatasource _clientKey;
  final TokenRepository _token;
  final DotEnv _env;

  /// Holds the available client SDKs.
  ClientSdkRepository(this._datasource, this._clientKey, this._token, this._env) : super(AsyncValue.loading()) {
    _load();

    watchAsync(_token);
  }

  Future<void> _load() async {
    await guard(_datasource.getAvailableClientSdks);
  }

  /// Fetches the installation instructions for the given [sdk] for the given [context].
  ///
  /// Returns a record with the instructions and the client key if available.
  Future<(Map<String, String>, ClientKey?)> getInstructions({
    required ClientSdk sdk,
    required BuildContext context,
    required int productId,
    required int? customerId,
  }) async {
    if (!_token.state.hasData) {
      log('No token available, cannot fetch instructions');

      return (<String, String>{}, null);
    }

    try {
      final language = Localizations.localeOf(context).languageCode;
      final instructons = await _datasource.getInstructions(sdk, language);

      ClientKey? clientKey;

      if (customerId != null) {
        clientKey = await _clientKey.createClientKey(
          _token.state.requireData.token,
          productId: productId,
          customerId: customerId,
        );

        final substitutions = <String, String>{
          '<client-key>': clientKey.key,
          '<client-id>': clientKey.id.toString(),
          '<domain>': _env['SERVER_URL']!,
        };

        for (final key in instructons.keys) {
          var value = instructons[key]!;

          for (final entry in substitutions.entries) {
            value = value.replaceAll(entry.key, entry.value);
          }

          instructons[key] = value;
        }
      }

      return (instructons, clientKey);
    } catch (e, s) {
      log('Failed to fetch instructions for $sdk', e, s);
      return (<String, String>{}, null);
    }
  }

  Future<List<ClientKey>> getClientKeys({List<int>? productIds, List<int>? customerIds}) async {
    final keys = await _clientKey.getClientKeys(_token.state.requireData.token);

    return keys.where((key) {
      if (productIds != null && !productIds.contains(key.productId)) {
        return false;
      }

      if (customerIds != null && !customerIds.contains(key.customerId)) {
        return false;
      }

      return true;
    }).toList();
  }

  Future<void> revokeClientKey({required String key}) async {
    if (!state.hasData) {
      return;
    }

    await _clientKey.revokeClientKey(_token.state.requireData.token, key: key);
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
