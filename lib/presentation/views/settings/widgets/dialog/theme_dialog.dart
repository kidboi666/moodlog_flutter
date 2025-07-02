import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../../view_models/settings/settings_viewmodel.dart';

class ThemeDialog extends StatefulWidget {
  final SettingsViewModel viewModel;

  const ThemeDialog({super.key, required this.viewModel});

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  late ThemeMode selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.viewModel.appState.themeMode;
  }

  void selectTheme(ThemeMode? theme) {
    if (theme != null) {
      setState(() {
        selectedTheme = theme;
      });
      widget.viewModel.setTheme(theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_common_theme_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: Text(ThemeMode.light.displayName),
            value: ThemeMode.light,
            groupValue: selectedTheme,
            onChanged: selectTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text(ThemeMode.dark.displayName),
            value: ThemeMode.dark,
            groupValue: selectedTheme,
            onChanged: selectTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text(ThemeMode.system.displayName),
            value: ThemeMode.system,
            groupValue: selectedTheme,
            onChanged: selectTheme,
          ),
        ],
      ),
    );
  }
}
