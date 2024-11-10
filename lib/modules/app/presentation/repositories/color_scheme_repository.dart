import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Holds the color scheme preference of the current platform.
class ColorSchemeRepository extends Repository<ColorScheme> {
  /// The color scheme to use for debugging purposes.
  ///
  /// Will override the platform color scheme if [kDebugMode] is `true`.
  static ColorScheme? debugOverride;

  final PlatformBrightnessRepository _platformBrightness;

  /// Holds the color scheme preference of the current platform.
  ColorSchemeRepository(this._platformBrightness) : super(ColorSchemes.darkRose()) {
    watch(_platformBrightness);
  }

  @override
  FutureOr<void> build(Type trigger) {
    emit(_platformBrightness.state == Brightness.dark ? ColorSchemes.darkRose() : ColorSchemes.lightRose());

    if (kDebugMode && debugOverride != null) {
      emit(debugOverride!);
    }
  }
}
