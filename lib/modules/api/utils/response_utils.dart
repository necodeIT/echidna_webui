import 'package:either_dart/either.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides utilties for handling an [HttpResponse] from the [ApiService].
extension HttpResponseX on HttpResponse<Either<List<JSON>, JSON>> {
  /// Returns the response body as a JSON object.
  ///
  /// Throws an exception if the response body is not a JSON object or null.
  JSON get json => body!.fold((_) => throw Exception('Expected JSON object'), (json) => json);

  /// Returns the response body as a list of JSON objects.
  ///
  /// Throws an exception if the response body is not a JSON list or null.
  List<JSON> get jsonList => body!.fold((jsonList) => jsonList, (_) => throw Exception('Expected JSON list'));
}
