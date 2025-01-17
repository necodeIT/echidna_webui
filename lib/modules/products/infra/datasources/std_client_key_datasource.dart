import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/products/products.dart';

/// Standard implementation of [ClientKeyDatasource].
class StdClientKeyDatasource extends ClientKeyDatasource {
  final ApiService _apiService;

  /// Standard implementation of [ClientKeyDatasource].
  StdClientKeyDatasource(this._apiService);

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }

  @override
  Future<ClientKey> createClientKey(String token, {required int productId, required int customerId}) async {
    final response = await _apiService.post(
      'admin/client-keys',
      token: token,
      body: {
        'product_id': productId,
        'customer_id': customerId,
      },
    );

    return ClientKey.fromJson(response.json);
  }

  @override
  Future<List<ClientKey>> getClientKeys(String token) async {
    final response = await _apiService.get('admin/client-keys', token: token);

    final clientKeys = response.jsonList.map(ClientKey.fromJson).toList();

    return clientKeys;
  }

  @override
  Future<void> revokeClientKey(String token, {required String key}) async {
    final response = await _apiService.delete(
      'admin/client-keys',
      token: token,
      pathParameter: key,
    );
    response.raiseForStatusCode();
  }
}
