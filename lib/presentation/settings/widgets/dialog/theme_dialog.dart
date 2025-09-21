import 'package:flutter/material.dart' hide ThemeMode;

import '../../../../core/constants/enum.dart';
import '../../../../core/extensions/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/ui/widgets/base_settings_dialog.dart';
import '../../settings_viewmodel.dart';

class ThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_theme_title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(ThemeMode.light.getDisplayName(context)),
            leading: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
            onTap: () => viewModel.setTheme(ThemeMode.light),
          ),
          ListTile(
            title: Text(ThemeMode.dark.getDisplayName(context)),
            leading: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
            onTap: () => viewModel.setTheme(ThemeMode.dark),
          ),
          ListTile(
            title: Text(ThemeMode.system.getDisplayName(context)),
            leading: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: viewModel.appState.themeMode,
              onChanged: viewModel.setTheme,
            ),
            onTap: () => viewModel.setTheme(ThemeMode.system),
          ),
        ],
      ),
    );
  }
}
