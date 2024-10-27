import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Provides a getter for the [AppLocalizations] on [BuildContext].
extension ContextLocalizaationX on BuildContext {
  /// Returns the [AppLocalizations] for the current [BuildContext].
  AppLocalizations get t => AppLocalizations.of(this);
}

/// Provides a getter for the [AppLocalizations] on [State].
extension StateLocalizaationX on State {
  /// Returns the [AppLocalizations] for the current [BuildContext].
  AppLocalizations get t => AppLocalizations.of(context);
}
