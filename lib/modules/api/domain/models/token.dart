// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

/// Wrapper for a string token.
///
/// Used so that dependency injection does not conflict with other strings.
@freezed
class Token with _$Token {
  /// Wrapper for a string token.
  ///
  /// Used so that dependency injection does not conflict with other strings.
  const factory Token({
    required String token,
  }) = _Token;

  const Token._();

  /// Creates a [Token] from a JSON object.
  factory Token.fromJson(Map<String, Object?> json) => _$TokenFromJson(json);
}
