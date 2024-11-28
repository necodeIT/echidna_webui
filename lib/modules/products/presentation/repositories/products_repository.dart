import 'dart:async';

import 'package:collection/collection.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides a list of all stored products.
class ProductsRepository extends Repository<AsyncValue<List<Product>>> {
  final TokenRepository _tokenRepository;
  final ProductsDatasource _datasource;

  /// Provides a list of all stored products.
  ProductsRepository(this._tokenRepository, this._datasource) : super(AsyncValue.loading()) {
    watchAsync(_tokenRepository);
  }

  @override
  FutureOr<void> build(Type trigger) {
    guard(
      () async => _datasource.getProducts(_tokenRepository.state.requireData.token),
      onData: (products) {
        log('Loaded ${products.length} products');
      },
      onError: (e, s) {
        log('Failed to load products', e, s);
      },
    );
  }

  /// Creates a new product.
  Future<void> createProduct({
    required String name,
    required String description,
  }) async {
    log('Creating new product: $name, $description');

    if (!state.hasData) {
      log('Cannot create product: Bad state');
      return;
    }

    try {
      final product = await _datasource.createProduct(
        _tokenRepository.state.requireData.token,
        name: name,
        description: description,
      );

      data([...state.requireData, product]);

      log('Successfully created product with ID ${product.id}');
    } catch (e, s) {
      log('Failed to create product', e, s);
    }
  }

  /// Updates a product.
  Future<void> updateProduct({required int id, String? name, String? description}) async {
    log('Updating product: $id');

    if (!state.hasData) {
      log('Cannot update product: Bad state');
      return;
    }

    try {
      final product = state.requireData.firstWhere((element) => element.id == id);

      final updatedProduct = Product(
        id: id,
        name: name ?? product.name,
        description: description ?? product.description,
      );

      if (product == updatedProduct) {
        log('No changes detected. Skipping update');
        return;
      }

      data([...state.requireData.where((element) => element.id != product.id), updatedProduct]);

      log('Successfully updated product with ID ${product.id}');
    } catch (e, s) {
      log('Failed to update product', e, s);
    }
  }

  /// Deletes a product.
  Future<void> deleteProduct(int id) async {
    log('Deleting product with ID $id');

    if (!state.hasData) {
      log('Cannot delete product: Bad state');
      return;
    }

    try {
      await _datasource.deleteProduct(_tokenRepository.state.requireData.token, id: id);

      data(state.requireData.where((element) => element.id != id).toList());

      log('Successfully deleted product with ID $id');
    } catch (e, s) {
      log('Failed to delete product', e, s);
    }
  }

  /// Searches for products.
  ///
  /// Products are searched by their name and description (case-insensitive).
  List<Product> search(String query) {
    if (!state.hasData) {
      return [];
    }

    return state.requireData
        .where(
          (e) => e.name.containsIgnoreCase(query) || e.description.containsIgnoreCase(query),
        )
        .toList();
  }

  /// Returns a product by its ID.
  Product? byId(int id) {
    if (!state.hasData) {
      return null;
    }

    return state.requireData.firstWhereOrNull((element) => element.id == id);
  }

  @override
  void dispose() {
    _tokenRepository.dispose();
    super.dispose();
  }
}
