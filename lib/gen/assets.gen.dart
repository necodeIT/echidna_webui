/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsBrandingGen {
  const $AssetsBrandingGen();

  /// File path: assets/branding/logo-horiz.svg
  SvgGenImage get logoHoriz =>
      const SvgGenImage('assets/branding/logo-horiz.svg');

  /// File path: assets/branding/logo-icon-background.svg
  SvgGenImage get logoIconBackground =>
      const SvgGenImage('assets/branding/logo-icon-background.svg');

  /// List of all assets
  List<SvgGenImage> get values => [logoHoriz, logoIconBackground];
}

class $AssetsFrameworksGen {
  const $AssetsFrameworksGen();

  /// File path: assets/frameworks/angular-svgrepo-com.svg
  SvgGenImage get angularSvgrepoCom =>
      const SvgGenImage('assets/frameworks/angular-svgrepo-com.svg');

  /// File path: assets/frameworks/dart-svgrepo-com.svg
  SvgGenImage get dartSvgrepoCom =>
      const SvgGenImage('assets/frameworks/dart-svgrepo-com.svg');

  /// File path: assets/frameworks/flutter-svgrepo-com.svg
  SvgGenImage get flutterSvgrepoCom =>
      const SvgGenImage('assets/frameworks/flutter-svgrepo-com.svg');

  /// File path: assets/frameworks/javascript-svgrepo-com.svg
  SvgGenImage get javascriptSvgrepoCom =>
      const SvgGenImage('assets/frameworks/javascript-svgrepo-com.svg');

  /// File path: assets/frameworks/react-svgrepo-com.svg
  SvgGenImage get reactSvgrepoCom =>
      const SvgGenImage('assets/frameworks/react-svgrepo-com.svg');

  /// File path: assets/frameworks/svelte-svgrepo-com.svg
  SvgGenImage get svelteSvgrepoCom =>
      const SvgGenImage('assets/frameworks/svelte-svgrepo-com.svg');

  /// File path: assets/frameworks/vue-vuejs-javascript-js-framework-svgrepo-com.svg
  SvgGenImage get vueVuejsJavascriptJsFrameworkSvgrepoCom => const SvgGenImage(
      'assets/frameworks/vue-vuejs-javascript-js-framework-svgrepo-com.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        angularSvgrepoCom,
        dartSvgrepoCom,
        flutterSvgrepoCom,
        javascriptSvgrepoCom,
        reactSvgrepoCom,
        svelteSvgrepoCom,
        vueVuejsJavascriptJsFrameworkSvgrepoCom
      ];
}

class Assets {
  Assets._();

  static const $AssetsBrandingGen branding = $AssetsBrandingGen();
  static const $AssetsFrameworksGen frameworks = $AssetsFrameworksGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
