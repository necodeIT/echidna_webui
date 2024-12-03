import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds the brightness preference of the user's platform.
class PlatformBrightnessRepository extends Repository<Brightness> {
  /// Overrides the brightness preference of the user's platform in debug mode.
  static Brightness? debugOverride;

  late final MediaQueryList _query;

  /// Holds the brightness preference of the user's platform.
  PlatformBrightnessRepository() : super(Brightness.light) {
    _query = window.matchMedia('(prefers-color-scheme: dark)');

    _query.addListener(_listener);

    emit(_query.matches ? Brightness.dark : Brightness.light);

    if (kDebugMode && debugOverride != null) emit(debugOverride!);
  }

  void _listener(Event event) {
    emit(_query.matches ? Brightness.dark : Brightness.light);
  }

  @override
  void dispose() {
    _query.removeListener(_listener);
    super.dispose();
  }
}
