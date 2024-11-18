import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Maps the products api endpoints.
abstract class ProductsDatasource extends Datasource {
  @override
  String get name => 'Products';

  /// Returns a list of all products from the license server.
  Future<List<Product>> getProducts(String token);

  /// Returns a product with the given [id] from the license server.
  Future<Product> getProduct(String token, {required int id});

  /// Creates a new product on the license server.
  Future<Product> createProduct(String token, {required String name, required String description});

  /// Updates a product on the license server.
  Future<Product> updateProduct(String token, {required Product product});

  /// Deletes a product with the given [id] from the license server.
  Future<void> deleteProduct(String token, {required int id});
}
