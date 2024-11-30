// ignore_for_file: invalid_annotation_target

import 'package:echidna_webui/gen/assets.gen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_sdk.freezed.dart';
part 'client_sdk.g.dart';

/// Holds metadata about a client SDK.
@freezed
class ClientSdk with _$ClientSdk {
  /// Holds metadata about a client SDK.
  const factory ClientSdk({
    /// Name of this client SDK.
    required String name,

    /// The framework this client SDK is for.
    required ClientSdkFramework framework,

    /// Installation instructions for this client SDK.
    ///
    /// Language -> Installation instructions (markdown format).
    @JsonKey(name: 'gettingStarted') required Map<String, String> guides,
  }) = _ClientSdk;

  const ClientSdk._();

  /// Creates a [ClientSdk] from a JSON object.
  factory ClientSdk.fromJson(Map<String, Object?> json) => _$ClientSdkFromJson(json);
}

/// Represents a client SDK framework.
enum ClientSdkFramework {
  /// [React](https://react.dev/) framework.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  react('React', _reactIcon),

  /// [Flutter](flutter.dev) framework.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  flutter('Flutter', _flutterIcon),

  /// [Dart](https://dart.dev/) programming language.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  dart('Dart', _dartIcon),

  /// [Angular](https://angular.io/) framework.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  angular('Angular', _angularIcon),

  /// [Vue](https://vuejs.org/) framework.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  vue('Vue', _vueIcon),

  /// [Svelte](https://svelte.dev/) framework.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  svelte('Svelte', _svelteIcon),

  /// Vanilla JavaScript.
  ///
  /// © Icon from[https://www.svgrepo.com/](https://www.svgrepo.com/)
  vanillaJS('VanillaJS', _vanillaJSIcon);

  const ClientSdkFramework(this.name, this.icon);

  /// Display name of the framework.
  final String name;

  /// Icon representing the framework.
  final SvgGenImage Function() icon;
}

SvgGenImage _reactIcon() => Assets.frameworks.reactSvgrepoCom;
SvgGenImage _flutterIcon() => Assets.frameworks.flutterSvgrepoCom;
SvgGenImage _dartIcon() => Assets.frameworks.dartSvgrepoCom;
SvgGenImage _angularIcon() => Assets.frameworks.angularSvgrepoCom;
SvgGenImage _vueIcon() => Assets.frameworks.vueVuejsJavascriptJsFrameworkSvgrepoCom;
SvgGenImage _svelteIcon() => Assets.frameworks.svelteSvgrepoCom;
SvgGenImage _vanillaJSIcon() => Assets.frameworks.javascriptSvgrepoCom;
