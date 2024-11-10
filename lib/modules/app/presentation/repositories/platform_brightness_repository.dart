import 'dart:ui';

import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds the brightness preference of the user's platform.
class PlatformBrightnessRepository extends Repository<Brightness> {
  /// Holds the brightness preference of the user's platform.
  PlatformBrightnessRepository() : super(Brightness.light) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
  }

  void _onPlatformBrightnessChanged() {
    emit(PlatformDispatcher.instance.platformBrightness);
  }
}
