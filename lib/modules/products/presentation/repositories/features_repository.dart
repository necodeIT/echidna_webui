import 'dart:async';

import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:echidna_webui/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides a list of all features.
class FeaturesRepository extends Repository<AsyncValue<List<Feature>>> {
  final TokenRepository _tokenRepository;
  final FeaturesDatasource _datasource;

  /// Provides a list of all features.
  FeaturesRepository(this._tokenRepository, this._datasource) : super(AsyncValue.loading()) {
    watchAsync(_tokenRepository);
  }

  @override
  FutureOr<void> build(Type trigger) {
    guard(
      () async => _datasource.getFeatures(_tokenRepository.state.requireData.token),
      onData: (features) {
        log('Loaded ${features.length} features');
      },
      onError: (e, s) {
        log('Failed to load features', e, s);
      },
    );
  }

  /// Creates a new feature.
  Future<void> createFeature({
    int? trialPeriod,
    required String name,
    required int productId,
    required FeatureType type,
    required String description,
  }) async {
    log('Creating new feature: $name, $description');

    if (!state.hasData) {
      log('Cannot create feature: Bad state');
      return;
    }

    try {
      final feature = await _datasource.createFeature(
        _tokenRepository.state.requireData.token,
        trialPeriod: trialPeriod,
        name: name,
        productId: productId,
        type: type,
        description: description,
      );

      data([...state.requireData, feature]);

      log('Successfully created feature with ID ${feature.id}');
    } catch (e, s) {
      log('Failed to create feature', e, s);
    }
  }

  /// Deletes a feature.
  Future<void> deleteFeature(int id) async {
    log('Deleting Feature with ID $id');

    if (!state.hasData) {
      log('Cannot delete feature: Bad state');
      return;
    }

    try {
      await _datasource.deleteFeature(_tokenRepository.state.requireData.token, id: id);

      data(state.requireData.where((feature) => feature.id != id).toList());

      log('Successfully deleted feature with ID $id');
    } catch (e, s) {
      log('Failed to delete feature', e, s);
    }
  }

  /// Updates a feature.
  Future<void> updateFeature({required int id, String? name, String? description, FeatureType? type, int? trialPeriod}) async {
    log('Updating feature: $id');

    if (!state.hasData) {
      log('Cannot update feature: Bad state');
      return;
    }

    try {
      final oldFeature = state.requireData.firstWhere((feature) => feature.id == id);

      final feature = Feature(
        id: id,
        name: name ?? oldFeature.name,
        description: description ?? oldFeature.description,
        type: type ?? oldFeature.type,
        trialPeriod: trialPeriod ?? oldFeature.trialPeriod,
        productId: oldFeature.productId,
      );

      if (oldFeature == feature) {
        log('No changes detected. Skipping update.');
        return;
      }

      final updatedFeature = await _datasource.updateFeature(
        _tokenRepository.state.requireData.token,
        feature: feature,
      );

      data(state.requireData.map((f) => f.id == updatedFeature.id ? updatedFeature : f).toList());

      log('Successfully updated feature with ID ${feature.id}');
    } catch (e, s) {
      log('Failed to update feature', e, s);
    }
  }

  /// Filters the features based on the specified properties.
  ///
  /// This method applies all provided conditions to filter the features.
  /// Any condition that is not provided will be ignored.
  ///
  /// As the parameters are lists, the method will return features that match any of the provided values.
  List<Feature> filter({
    List<int>? productIds,
    List<int>? ids,
    List<String>? names,
    List<String>? descriptions,
    List<FeatureType>? types,
    List<int>? trialPeriods,
  }) {
    if (!state.hasData) {
      return [];
    }

    return state.requireData.where((feature) {
      if (productIds != null) {
        if (!productIds.any((pid) => pid == feature.productId)) return false;
      }

      if (ids != null) {
        if (!ids.any((id) => id == feature.id)) return false;
      }

      if (names != null) {
        if (!names.any((name) => feature.name.containsIgnoreCase(name))) return false;
      }

      if (descriptions != null) {
        if (!descriptions.any((desc) => feature.description.containsIgnoreCase(desc))) return false;
      }

      if (types != null) {
        if (!types.any((type) => type == feature.type)) return false;
      }

      if (trialPeriods != null) {
        if (!trialPeriods.any((tp) => tp == feature.trialPeriod)) return false;
      }

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}
