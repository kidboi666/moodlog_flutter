import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../../../core/constants/enum.dart';
import '../../viewmodel/settings_viewmodel.dart';

class LanguageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(t.settings_common_language_dialog_title),
      content: ListenableBuilder(
        listenable: viewModel,
        builder: (_, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<LanguageCode>(
                title: Text(LanguageCode.ko.displayName),
                value: LanguageCode.ko,
                groupValue: viewModel.appState.languageCode,
                onChanged: viewModel.setLanguage,
              ),
              RadioListTile<LanguageCode>(
                title: Text(LanguageCode.en.displayName),
                value: LanguageCode.en,
                groupValue: viewModel.appState.languageCode,
                onChanged: viewModel.setLanguage,
              ),
            ],
          );
        },
      ),
    );
  }
}
