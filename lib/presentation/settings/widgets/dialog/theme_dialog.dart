import 'package:flutter/material.dart' hide ThemeMode;

import '../../../../common/constants/enum.dart';
import '../../../../common/extensions/enum.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../../viewmodel/settings_viewmodel.dart';

class ThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.settings_common_theme_title),
      content: ListenableBuilder(
        listenable: viewModel,
        builder: (_, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(ThemeMode.light.getDisplayName(context)),
              value: ThemeMode.light,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
            RadioListTile<ThemeMode>(
              title: Text(ThemeMode.dark.getDisplayName(context)),
              value: ThemeMode.dark,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
            RadioListTile<ThemeMode>(
              title: Text(ThemeMode.system.getDisplayName(context)),
              value: ThemeMode.system,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
          ],
        ),
      ),
    );
  }
}
