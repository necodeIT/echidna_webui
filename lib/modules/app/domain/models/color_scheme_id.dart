// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'color_scheme_id.freezed.dart';
part 'color_scheme_id.g.dart';

/// Serialization of the color scheme.
///
/// Used to get json serialization of [ColorSchemeId].
@freezed
class ColorSchemeSerialization with _$ColorSchemeSerialization {
  /// Serialization of the color scheme.
  ///
  /// Used to get json serialization of [ColorSchemeId].
  const factory ColorSchemeSerialization({
    required ColorSchemeId id,
  }) = _ColorSchemeSerialization;

  const ColorSchemeSerialization._();

  /// [ColorSchemeSerialization] to fromJson.
  factory ColorSchemeSerialization.fromJson(Map<String, dynamic> json) => _$ColorSchemeSerializationFromJson(json);
}

/// All available color schemes.
enum ColorSchemeId {
  /// [ColorSchemes.zinc].
  zinc(_zinc, __zinc),

  /// [ColorSchemes.slate].
  slate(_slate, __slate),

  /// [ColorSchemes.rose].
  rose(_rose, __rose),

  /// [ColorSchemes.blue].
  blue(_blue, __blue),

  /// [ColorSchemes.green].
  green(_green, __green),

  /// [ColorSchemes.orange].
  orange(_orange, __orange),

  /// [ColorSchemes.yellow].
  yellow(_yellow, __yellow),

  /// [ColorSchemes.violet].
  violet(_violet, __violet),

  /// [ColorSchemes.gray].
  gray(_gray, __gray),

  /// [ColorSchemes.neutral].
  neutral(_neutral, __neutral),

  /// [ColorSchemes.red].
  red(_red, __red),

  /// [ColorSchemes.stone].
  stone(_stone, __stone);

  /// Translated name of the color scheme for the current [BuildContext].
  final String Function(BuildContext context) translate;

  /// Builds the color scheme for the given [ThemeMode].
  final ColorScheme Function(ThemeMode mode) builder;

  const ColorSchemeId(this.translate, this.builder);

  /// Returns the colorscheme either light or dark based on the given [Brightness].
  ColorScheme colorScheme(Brightness brightness) => builder(brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);

  /// Returns the serialization of the color scheme.
  ColorSchemeSerialization get serde => ColorSchemeSerialization(id: this);

  static String _zinc(BuildContext context) => 'Zinc';

  static String _slate(BuildContext context) => 'Slate';

  static String _rose(BuildContext context) => 'Rose';

  static String _blue(BuildContext context) => 'Blue';

  static String _green(BuildContext context) => 'Green';

  static String _orange(BuildContext context) => 'Orange';

  static String _yellow(BuildContext context) => 'Yellow';

  static String _violet(BuildContext context) => 'Violet';

  static String _gray(BuildContext context) => 'Gray';

  static String _neutral(BuildContext context) => 'Neutral';

  static String _red(BuildContext context) => 'Red';

  static String _stone(BuildContext context) => 'Stone';

  static ColorScheme __zinc(ThemeMode mode) => ColorSchemes.zinc(mode);

  static ColorScheme __slate(ThemeMode mode) => ColorSchemes.slate(mode);

  static ColorScheme __rose(ThemeMode mode) => ColorSchemes.rose(mode);

  static ColorScheme __blue(ThemeMode mode) => ColorSchemes.blue(mode);

  static ColorScheme __green(ThemeMode mode) => ColorSchemes.green(mode);

  static ColorScheme __orange(ThemeMode mode) => ColorSchemes.orange(mode);

  static ColorScheme __yellow(ThemeMode mode) => ColorSchemes.yellow(mode);

  static ColorScheme __violet(ThemeMode mode) => ColorSchemes.violet(mode);

  static ColorScheme __gray(ThemeMode mode) => ColorSchemes.gray(mode);

  static ColorScheme __neutral(ThemeMode mode) => ColorSchemes.neutral(mode);

  static ColorScheme __red(ThemeMode mode) => ColorSchemes.red(mode);

  static ColorScheme __stone(ThemeMode mode) => ColorSchemes.stone(mode);
}
