import 'package:flutter_modular/flutter_modular.dart';

/// Extension on to apply default transition to a list of [ModuleRoute].
extension TransitionX on List<ModuleRoute> {
  /// Applies default transitions to all routes in this list.
  List<ModuleRoute> applyDefaultTransition() {
    return map(
      (route) => route.copyWith(
        transition: TransitionType.noTransition,
      ),
    ).toList();
  }
}
