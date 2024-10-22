import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Implements the [ApiService] for requests that require a token.
class TokenApiService extends ApiService {
  final Token _token;
  final NetworkService _networkService;
  final Server _server;

  /// Implements the [ApiService] for requests that require a token.
  TokenApiService(this._token, this._networkService, this._server);

  @override
  void dispose() {}

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $_token',
      };

  Either<List<JSON>, JSON> _parseResponse(HttpResponse response) {
    final contentType = response.headers['content-type'];

    if (!(contentType?.contains(ContentType.json.toString()) ?? false)) {
      throw Exception('Unexpected content type: $contentType');
    }

    if (response.body is List) {
      final jsonList = (response.body as List<dynamic>).map((dynamic e) => e as JSON).toList();

      return Left(jsonList);
    }

    return Right(response.body as JSON);
  }

  HttpResponse<Either<List<JSON>, JSON>> _mapResponse(HttpResponse response) {
    return HttpResponse(
      headers: response.headers,
      requestUri: response.requestUri,
      body: _parseResponse(response),
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> delete(String path, {Map<String, String> queryParameters = const {}}) async {
    final response = await _networkService.delete(_path(path), headers: _headers, queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> get(String path, {Map<String, String> queryParameters = const {}}) async {
    final response = await _networkService.get(_path(path), headers: _headers, queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> patch(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    final response = await _networkService.patch(_path(path), body, headers: _headers, queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> post(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    final response = await _networkService.post(_path(path), body, headers: _headers, queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> put(
    String path, {
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    final response = await _networkService.put(_path(path), body, headers: _headers, queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  String _path(String path) {
    return '${_server.url}${path.startsWith('/') ? '' : '/'}$path${path.endsWith('/') ? '' : '/'}';
  }
}
