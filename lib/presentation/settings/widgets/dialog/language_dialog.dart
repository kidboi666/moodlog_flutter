import 'package:flutter/material.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/ui/widgets/base_settings_dialog.dart';
import '../../settings_viewmodel.dart';

class LanguageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_language_dialog_title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(LanguageCode.ko.displayName),
            leading: Radio<LanguageCode>(
              value: LanguageCode.ko,
              groupValue: viewModel.appState.languageCode,
              onChanged: viewModel.setLanguage,
            ),
            onTap: () => viewModel.setLanguage(LanguageCode.ko),
          ),
          ListTile(
            title: Text(LanguageCode.en.displayName),
            leading: Radio<LanguageCode>(
              value: LanguageCode.en,
              groupValue: viewModel.appState.languageCode,
              onChanged: viewModel.setLanguage,
            ),
            onTap: () => viewModel.setLanguage(LanguageCode.en),
          ),
          ListTile(
            title: Text(LanguageCode.ja.displayName),
            leading: Radio<LanguageCode>(
              value: LanguageCode.ja,
              groupValue: viewModel.appState.languageCode,
              onChanged: viewModel.setLanguage,
            ),
            onTap: () => viewModel.setLanguage(LanguageCode.ja),
          ),
        ],
      ),
    );
  }
}
