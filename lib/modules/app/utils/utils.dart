import 'package:shadcn_flutter/shadcn_flutter.dart';

export 'localization_utils.dart';
export 'theme_utils.dart';

/// {@template show_toast}
/// A function that shows a toast overlay.
///
/// Used to avoid unmounted errors when showing a toast after the dialog is closed.
/// {@endtemplate}
typedef ShowToast = ToastOverlay Function(Widget Function(BuildContext, ToastOverlay) builder, [Duration? showDuration]);

/// Creates a [ShowToast] handler for the given [context].
ShowToast createShowToastHandler(BuildContext context) {
  return (Widget Function(BuildContext, ToastOverlay) builder, [Duration? showDuration]) {
    return showToast(
      context: context,
      builder: builder,
      showDuration: showDuration ?? const Duration(seconds: 5),
    );
  };
}
