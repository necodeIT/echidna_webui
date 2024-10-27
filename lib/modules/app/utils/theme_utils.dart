import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Provides easy access to the app's theme.
extension ContextThemeX on BuildContext {
  /// The app's theme.
  ThemeData get theme => Theme.of(this);
}

/// Provides easy access to the app's theme.
extension StateThemeX on State {
  /// The app's theme.
  ThemeData get theme => context.theme;
}
