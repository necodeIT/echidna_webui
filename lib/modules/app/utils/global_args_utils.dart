// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

Map<String, String> _globalArgs = {};

/// Arguments intially passed to the application.
///
/// Used as a workaround for a bug that deletes all query parameters from the URL when directly navigating to a route with query parameters before the application is fully loaded.
Map<String, String> get queryParameters => _globalArgs;

/// Loads [queryParameters] from the URL.
void loadQueryParameters() {
  final href = window.location.href;

  // Parse query parameters from the URL.
  // idk why, but the query parameters are not parsed correctly by Uri.parse.

  final queryIndex = href.indexOf('?');

  if (queryIndex != -1) {
    final query = href.substring(queryIndex + 1);

    final pairs = query.split('&');

    for (final pair in pairs) {
      final parts = pair.split('=');

      if (parts.length == 2) {
        _globalArgs[parts[0]] = parts[1];
      }
    }
  }
}
