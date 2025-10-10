import 'package:flutter/material.dart' hide ThemeMode;

import '../../../../core/constants/enum.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/ui/widgets/base_settings_dialog.dart';
import '../../settings_view_model.dart';

class ThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_theme_title,
      content: RadioGroup(
        groupValue: viewModel.appState.themeMode,
        onChanged: viewModel.setTheme,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text(ThemeMode.light.getDisplayName(context)),
              value: ThemeMode.light,
            ),
            RadioListTile(
              title: Text(ThemeMode.dark.getDisplayName(context)),
              value: ThemeMode.dark,
            ),
            RadioListTile(
              title: Text(ThemeMode.system.getDisplayName(context)),
              value: ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }
}
