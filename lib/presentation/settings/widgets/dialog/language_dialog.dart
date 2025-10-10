import 'package:flutter/material.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/ui/widgets/base_settings_dialog.dart';
import '../../settings_view_model.dart';

class LanguageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_language_dialog_title,
      content: RadioGroup<LanguageCode>(
        groupValue: viewModel.appState.languageCode,
        onChanged: viewModel.setLanguage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              value: LanguageCode.ko,
              title: Text(LanguageCode.ko.displayName),
            ),
            RadioListTile(
              value: LanguageCode.en,
              title: Text(LanguageCode.en.displayName),
            ),
            RadioListTile(
              value: LanguageCode.ja,
              title: Text(LanguageCode.ja.displayName),
            ),
          ],
        ),
      ),
    );
  }
}
