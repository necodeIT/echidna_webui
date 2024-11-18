import 'package:echidna_dto/echidna_dto.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Maps the features api endpoints.
abstract class FeaturesDatasource extends Datasource {
  @override
  String get name => 'Features';

  /// Fetches all features from the license server.
  Future<List<Feature>> getFeatures(String token);

  /// Fetches a feature with the given [id] from the license server.
  Future<Feature> getFeature(String token, {required int id});

  /// Creates a new feature on the license server.
  Future<Feature> createFeature(
    String token, {
    int? trialPeriod,
    required String name,
    required int productId,
    required FeatureType type,
    required String description,
  });

  /// Updates a feature on the license server.
  Future<Feature> updateFeature(String token, {required Feature feature});

  /// Deletes a feature with the given [id] from the license server.
  Future<void> deleteFeature(String token, {required int id});
}
