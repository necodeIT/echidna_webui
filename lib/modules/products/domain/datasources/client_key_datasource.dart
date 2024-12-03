import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Responsible for fetching a client key.
abstract class ClientKeyDatasource extends Datasource {
  @override
  String get name => 'ClientKey';

  /// Fetches the client key for the given [productId] and [customerId].
  Future<ClientKey> createClientKey(String token, {required int productId, required int customerId});

  /// Fetches all client keys.
  Future<List<ClientKey>> getClientKeys(String token);

  /// Revokes the client key with the given [key].
  Future<void> revokeClientKey(String token, {required String key});
}
