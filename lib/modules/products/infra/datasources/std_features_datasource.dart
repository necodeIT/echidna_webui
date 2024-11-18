import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/api/api.dart';
import 'package:echidna_webui/modules/products/products.dart';

/// Standard implementation of [FeaturesDatasource].
class StdFeaturesDatasource extends FeaturesDatasource {
  final ApiService _apiService;

  /// Standard implementation of [FeaturesDatasource].
  StdFeaturesDatasource(this._apiService);

  @override
  void dispose() {
    _apiService.dispose();
  }

  @override
  Future<Feature> createFeature(
    String token, {
    int? trialPeriod,
    required String name,
    required int productId,
    required FeatureType type,
    required String description,
  }) async {
    log('Creating new feature: $name, $description');

    try {
      final response = await _apiService.put(
        '/admin/features',
        token: token,
        body: {
          'name': name,
          'description': description,
          'product_id': productId,
          'type': type.name,
          if (trialPeriod != null) 'trial_period': trialPeriod,
        },
      );
      response.raiseForStatusCode();

      final feature = Feature.fromJson(response.json);

      log('Successfully created feature with ID ${feature.id}');

      return feature;
    } catch (e, s) {
      log('Failed to create feature', e, s);
      rethrow;
    }
  }

  @override
  Future<void> deleteFeature(String token, {required int id}) async {
    log('Deleting Feature with ID $id');

    try {
      final response = await _apiService.delete('/admin/features', pathParameter: id, token: token);

      response.raiseForStatusCode();

      log('Successfully deleted feature with ID $id');
    } catch (e, s) {
      log('Failed to delete feature with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<Feature> getFeature(String token, {required int id}) async {
    log('Getting Feature with ID $id');

    try {
      final response = await _apiService.get('/admin/features', pathParameter: id, token: token);
      response.raiseForStatusCode();

      final feature = Feature.fromJson(response.json);

      log('Successfully returned feature with ID $id');

      return feature;
    } catch (e, s) {
      log('Failed to get feature with ID $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<Feature>> getFeatures(String token) async {
    log('Getting all features');

    try {
      final response = await _apiService.get('/admin/features', token: token);
      response.raiseForStatusCode();

      final features = response.jsonList.map(Feature.fromJson).toList();

      log('Successfully returned all features');

      return features;
    } catch (e, s) {
      log('Failed to get all features', e, s);
      rethrow;
    }
  }

  @override
  Future<Feature> updateFeature(String token, {required Feature feature}) async {
    log('Updating Feature with ID ${feature.id}');

    try {
      final response = await _apiService.post(
        '/admin/features',
        pathParameter: feature.id,
        token: token,
        body: feature.toJson(),
      );
      response.raiseForStatusCode();

      final updatedFeature = Feature.fromJson(response.json);

      log('Successfully updated feature with ID ${feature.id}');

      return updatedFeature;
    } catch (e, s) {
      log('Failed to update feature with ID ${feature.id}', e, s);
      rethrow;
    }
  }
}
