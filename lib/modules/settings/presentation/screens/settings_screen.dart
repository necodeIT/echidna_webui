import 'package:awesome_extensions/awesome_extensions.dart' hide ThemeExt;
import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays the settings screen.
class SettingsScreen extends StatelessWidget {
  /// Displays the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.watch<ColorSchemeRepository>();

    return Scaffold(
      headers: [
        AppBar(
          title: Breadcrumb(
            separator: Breadcrumb.arrowSeparator,
            children: [
              Text(context.t.settings_settingsScreen_settings),
            ],
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.settings_settingsScreen_colorScheme).large().bold(),
          const SizedBox(height: 10),
          const SizedBox(
            width: double.infinity,
            child: Divider(),
          ),
          const SizedBox(height: 20),
          RadioGroup<ColorSchemeId>(
            value: colorScheme.id,
            onChanged: colorScheme.setColorScheme,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final colorSchemeId in ColorSchemeId.values)
                  RadioCard<ColorSchemeId>(
                    value: colorSchemeId,
                    child: Basic(
                      leadingAlignment: Alignment.center,
                      leading: Container(
                        decoration: BoxDecoration(
                          color: colorSchemeId.colorScheme(context.theme.brightness).primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 10,
                        width: 10,
                      ),
                      title: Text(colorSchemeId.translate(context)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ).paddingAll(20),
    );
  }
}
