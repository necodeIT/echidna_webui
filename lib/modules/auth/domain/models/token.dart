// ignore_for_file: invalid_annotation_target

import 'package:flutter_modular/flutter_modular.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

/// Wrapper for the token string.
///
/// Used to avoid type conflicts within modular's [Injector].
@freezed
class Token with _$Token {
  /// Wrapper for the token string.
  ///
  /// Used to avoid type conflicts within modular's [Injector].
  const factory Token({
    required String token,
  }) = _Token;

  const Token._();

  /// Creates a [Token] from a JSON object.
  factory Token.fromJson(Map<String, Object?> json) => _$TokenFromJson(json);
}
