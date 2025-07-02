import 'package:flutter/material.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../view_models/settings/settings_viewmodel.dart';

class LanguageDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('언어 선택'),
      content: Column(
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
      ),
    );
  }
}
