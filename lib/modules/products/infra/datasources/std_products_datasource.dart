import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:license_server_rest/license_server_rest.dart';

/// Standard implementation of  [ProductsDatasource].
class StdProductsDatasource extends ProductsDatasource {
  final ApiService _apiService;

  /// Standard implementation of  [ProductsDatasource].
  StdProductsDatasource(this._apiService);

  @override
  void dispose() {
    _apiService.dispose();
  }

  @override
  Future<Product> createProduct(String token, {required String name, required String description}) async {
    log('Creating new product: $name, $description');

    try {
      final response = await _apiService.put(
        '/admin/products',
        token: token,
        body: {
          'name': name,
          'description': description,
        },
      );

      response.raiseForStatusCode();

      final product = Product.fromJson(response.json);

      log('Successfully created product with ID ${product.id}');

      return product;
    } on Exception catch (e, s) {
      log('Failed to create product', e, s);
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String token, {required int id}) async {
    log('Deleting Product with ID $id');

    try {
      final response = await _apiService.delete('/admin/products', pathParameter: id, token: token);

      response.raiseForStatusCode();

      log('Successfully deleted product with ID $id');
    } on Exception catch (e, s) {
      log('Failed to delete product with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(String token, {required int id}) async {
    log('Getting Product with ID $id');

    try {
      final response = await _apiService.get('/admin/products', pathParameter: id, token: token);

      response.raiseForStatusCode();

      final product = Product.fromJson(response.json);

      log('Successfully got product with ID $id');

      return product;
    } on Exception catch (e, s) {
      log('Failed to get product with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProducts(String token) async {
    log('Getting all products');

    try {
      final response = await _apiService.get('/admin/products', token: token);

      response.raiseForStatusCode();

      final products = response.jsonList.map(Product.fromJson).toList();

      log('Successfully got ${products.length} products');

      return products;
    } on Exception catch (e, s) {
      log('Failed to get all products', e, s);
      rethrow;
    }
  }

  @override
  Future<Product> updateProduct(String token, {required Product product}) async {
    log('Updating Product with ID ${product.id}');

    try {
      final response = await _apiService.patch(
        '/admin/products',
        pathParameter: product.id,
        token: token,
        body: product.toJson(),
      );

      response.raiseForStatusCode();

      final updatedProduct = Product.fromJson(response.json);

      log('Successfully updated product with ID ${updatedProduct.id}');

      return updatedProduct;
    } on Exception catch (e, s) {
      log('Failed to update product with ID ${product.id}', e, s);
      rethrow;
    }
  }
}
