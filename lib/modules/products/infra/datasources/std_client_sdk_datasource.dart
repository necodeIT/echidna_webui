import 'dart:async';
import 'dart:convert';

import 'package:echidna_webui/products.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:memory_cache/memory_cache.dart';

/// Standard implementation of [ClientSdkDatasource].
class StdClientSdkDatasource extends ClientSdkDatasource {
  final NetworkService _networkService;
  final MemoryCache _cache;

  /// Standard implementation of [ClientSdkDatasource].
  StdClientSdkDatasource(this._networkService, this._cache);

  @override
  void dispose() {
    _networkService.dispose();
  }

  /// A list of available SDK URLs.
  static const availableSdkUrls = [
    'https://raw.githubusercontent.com/necodeIT/echidna_flutter/refs/heads/main/echidna.json',
  ];

  @override
  Future<List<ClientSdk>> getAvailableClientSdks() async {
    final sdks = <ClientSdk>[];

    for (final url in availableSdkUrls) {
      if (!_cache.contains(url)) {
        final metadata = await _networkService.get(url);

        metadata.raiseForStatusCode();

        final json = jsonDecode(metadata.body);

        final sdk = ClientSdk.fromJson(json);

        _cache.create(
          url,
          jsonEncode(sdk.toJson()),
          expiry: const Duration(hours: 1),
        );

        sdks.add(sdk);
      } else {
        log('Using cached metadata for $url.');

        final cachedJson = jsonDecode(_cache.read(url)) as Map<String, Object?>;

        sdks.add(ClientSdk.fromJson(cachedJson));
      }
    }

    return sdks;
  }

  @override
  Future<Map<String, String>> getInstructions(ClientSdk sdk, String language) async {
    if (sdk.guides.isEmpty) {
      log('No installation instructions available for ${sdk.name}.');

      return {};
    }

    var url = sdk.guides[language];

    if (url == null) {
      log('Requested language $language is not available for ${sdk.name}. Returning first available language.');

      url = sdk.guides.values.first;
    }

    if (!_cache.contains(url)) {
      final response = await _networkService.get(url);

      response.raiseForStatusCode();

      final markdown = response.body;

      final instructions = <String, String>{};

      var title = '';

      for (final line in markdown.split('\n')) {
        if (line.startsWith('#')) {
          title = line.substring(1).trim();

          instructions[title] = '';

          continue;
        }

        instructions[title] = '${instructions[title]!}$line\n';
      }

      _cache.create<Map<String, String>>(
        url,
        instructions,
        expiry: const Duration(hours: 1),
      );

      log('Fetched installation instructions for $url.');

      return instructions;
    }

    log('Using cached installation instructions for $url.');

    return _cache.read<Map<String, String>>(url)!;
  }
}
