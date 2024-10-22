import 'package:either_dart/either.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Handles API requests to the license server.
abstract class ApiService extends Service {
  @override
  String get name => 'Api';

  /// Sends a GET request to the license server.
  Future<HttpResponse<Either<List<JSON>, JSON>>> get(
    String path, {
    Map<String, String> queryParameters = const {},
  });

  /// Sends a POST request to the license server.
  Future<HttpResponse<Either<List<JSON>, JSON>>> post(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  });

  /// Sends a PUT request to the license server.
  Future<HttpResponse<Either<List<JSON>, JSON>>> put(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  });

  /// Sends a DELETE request to the license server.
  Future<HttpResponse<Either<List<JSON>, JSON>>> delete(
    String path, {
    Map<String, String> queryParameters = const {},
  });

  /// Sends a PATCH request to the license server.
  Future<HttpResponse<Either<List<JSON>, JSON>>> patch(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  });
}
