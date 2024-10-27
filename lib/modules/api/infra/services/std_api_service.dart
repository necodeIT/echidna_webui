import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Standard implementation of the [ApiService].
class StdApiService extends ApiService {
  final NetworkService _networkService;
  final ServerConfig _server;

  /// Implements the [ApiService] for requests that require a token.
  StdApiService(this._networkService, this._server);

  @override
  void dispose() {
    _networkService.dispose();
  }

  Map<String, String> _headers(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': ContentType.json.toString(),
      // 'Origin': Uri.base.origin,
    };
  }

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

  HttpResponse<Either<List<JSON>, JSON>> _mapResponse(HttpResponse response) => response.transform((_) => _parseResponse(response));

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> delete(
    String path, {
    Object? pathParameter,
    Map<String, String> queryParameters = const {},
    required String token,
  }) async {
    _logRequest('delete', path, pathParameter);

    final response = await _networkService.delete(_path(path, pathParameter), headers: _headers(token), queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> get(
    String path, {
    Object? pathParameter,
    Map<String, String> queryParameters = const {},
    required String token,
  }) async {
    _logRequest('get', path, pathParameter);

    final response = await _networkService.get(_path(path, pathParameter), headers: _headers(token), queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> patch(
    String path, {
    Object? pathParameter,
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    required String token,
  }) async {
    _logRequest('patch', path, pathParameter);

    final response = await _networkService.patch(_path(path, pathParameter), body, headers: _headers(token), queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> post(
    String path, {
    Object? pathParameter,
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    required String token,
  }) async {
    _logRequest('post', path, pathParameter);

    final response = await _networkService.post(_path(path, pathParameter), body, headers: _headers(token), queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  @override
  Future<HttpResponse<Either<List<JSON>, JSON>>> put(
    String path, {
    Object? pathParameter,
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    required String token,
  }) async {
    _logRequest('put', path, pathParameter);

    final response = await _networkService.put(_path(path, pathParameter), body, headers: _headers(token), queryParameters: queryParameters);

    response.raiseForStatusCode();

    return _mapResponse(response);
  }

  String _path(
    String path,
    Object? pathParameter,
  ) {
    return '${_server.url}${path.startsWith('/') ? '' : '/'}$path${path.endsWith('/') ? '' : '/'}${pathParameter ?? ''}';
  }

  void _logRequest(
    String method,
    String path,
    Object? pathParameter,
  ) {
    log('Sending ${method.toUpperCase()} request to ${_path(path, pathParameter)}');
  }
}
