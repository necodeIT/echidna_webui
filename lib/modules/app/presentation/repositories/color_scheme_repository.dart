import 'dart:async';

import 'package:echidna_webui/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Holds the color scheme preference of the current platform.
class ColorSchemeRepository extends Repository<ColorScheme> {
  final PlatformBrightnessRepository _platformBrightness;

  final LocalStorageDatasource _storage;

  ColorSchemeId _id = ColorSchemeId.zinc;

  /// Holds the color scheme preference of the current platform.
  ColorSchemeRepository(this._platformBrightness, this._storage) : super(ColorSchemes.darkZinc()) {
    watch(_platformBrightness);

    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    if (!await _storage.exists<ColorSchemeSerialization>()) return;

    final id = await _storage.read<ColorSchemeSerialization>();

    _id = id.id;

    emit(_id.colorScheme(_platformBrightness.state));
  }

  @override
  FutureOr<void> build(Type trigger) {
    emit(_id.colorScheme(_platformBrightness.state));
  }

  /// Sets the color scheme to the given [ColorSchemeId].
  Future<void> setColorScheme(ColorSchemeId id) async {
    if (_id == id) return;

    _id = id;

    emit(id.colorScheme(_platformBrightness.state));

    await _storage.write<ColorSchemeSerialization>(id.serde);
  }

  /// Returns the current color scheme id.
  ColorSchemeId get id => _id;

  @override
  void dispose() {
    _storage.dispose();

    super.dispose();
  }
}
