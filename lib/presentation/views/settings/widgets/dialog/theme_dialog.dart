import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/enum.dart';

import '../../../../view_models/settings/settings_viewmodel.dart';

class ThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('테마 선택'),
      content: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: Text(ThemeMode.light.displayName),
                value: ThemeMode.light,
                groupValue: viewModel.appState.themeMode,
                onChanged: viewModel.setTheme,
              ),
              RadioListTile<ThemeMode>(
                title: Text(ThemeMode.dark.displayName),
                value: ThemeMode.dark,
                groupValue: viewModel.appState.themeMode,
                onChanged: viewModel.setTheme,
              ),
              RadioListTile<ThemeMode>(
                title: Text(ThemeMode.system.displayName),
                value: ThemeMode.system,
                groupValue: viewModel.appState.themeMode,
                onChanged: viewModel.setTheme,
              ),
            ],
          );
        },
      ),
    );
  }
}
