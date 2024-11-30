
import 'package:flutter/foundation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds the brightness preference of the user's platform.
class PlatformBrightnessRepository extends Repository<Brightness> {
  /// Overrides the brightness preference of the user's platform in debug mode.
  static Brightness? debugOverride;

  /// Holds the brightness preference of the user's platform.
  PlatformBrightnessRepository() : super(Brightness.light) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;

    if (kDebugMode && debugOverride != null) emit(debugOverride!);
  }

  void _onPlatformBrightnessChanged() {
    emit(kDebugMode && debugOverride != null ? debugOverride! : PlatformDispatcher.instance.platformBrightness);
  }
}
