import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:echidna_webui/products.dart';

/// Responsible for fetching a client key.
abstract class ClientKeyDatasource extends Datasource {
  @override
  String get name => 'ClientKey';

  /// Fetches the client key for the given [productId] and [customerId].
  Future<ClientKey> createClientKey(String token, {required int productId, required int customerId});
}
