import 'package:shadcn_flutter/shadcn_flutter.dart';

/// {@template show_toast}
/// A function that shows a toast overlay.
///
/// Used to avoid unmounted errors when showing a toast after the widget is closed.
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

/// Base class for widgets that consume toasts.
///
/// This is used to provide the extension methods from [ToastConsumerX].
abstract class ToastConsumer extends StatefulWidget {
  /// {@macro show_toast}
  final ShowToast showToast;

  /// Base class for widgets that consume toasts.
  ///
  /// This is used to provide the extension methods from [ToastConsumerX].
  const ToastConsumer({super.key, required this.showToast});
}

/// Provides some convenience (and concistency) methods for showing toasts.
extension ToastConsumerX<T extends ToastConsumer> on State<T> {
  /// Shows a toast overlay with the given [title], [subtitle] and [trailing] widget with an optional [showDuration].
  ToastOverlay showToast({required String title, required String subtitle, required Widget trailing, Duration? showDuration}) {
    return widget.showToast(
      (_, __) => SurfaceCard(
        child: Basic(
          title: Text(title),
          subtitle: Text(subtitle),
          trailingAlignment: Alignment.center,
          trailing: trailing,
        ),
      ),
      showDuration,
    );
  }

  /// Shows a toast overlay with the given [title], [subtitle] and [icon].
  ToastOverlay showIconToast({required String title, required String subtitle, required IconData icon, Duration? showDuration}) {
    return showToast(
      title: title,
      subtitle: subtitle,
      trailing: Icon(icon),
      showDuration: showDuration,
    );
  }

  /// Shows a loading toast overlay with the given [title] and [subtitle].
  ///
  /// This method uses a [CircularProgressIndicator] as the trailing widget.
  ToastOverlay showLoadingToast({required String title, required String subtitle}) {
    return showToast(
      title: title,
      subtitle: subtitle,
      trailing: const CircularProgressIndicator(),
      showDuration: const Duration(minutes: 1),
    );
  }

  /// Shows an error toast overlay with the given [title] and [subtitle].
  ///
  /// This method uses a [BootstrapIcons.exclamationDiamond] as the icon.
  ToastOverlay showErrorToast({required String title, required String subtitle}) {
    return showIconToast(
      title: title,
      subtitle: subtitle,
      icon: BootstrapIcons.exclamationDiamond,
      showDuration: const Duration(seconds: 10),
    );
  }

  /// Shows a success toast overlay with the given [title] and [subtitle].
  ///
  /// This method uses a [RadixIcons.check] as the icon.
  ToastOverlay showSuccessToast({required String title, required String subtitle}) {
    return showIconToast(
      title: title,
      subtitle: subtitle,
      icon: RadixIcons.check,
    );
  }
}
