import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../view_models/settings/settings_viewmodel.dart';

class FontFamilyDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const FontFamilyDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.settings_common_font_family_title,
      ),
      content: ListenableBuilder(
        listenable: viewModel,
        builder: (_, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<FontFamily>(
                title: Text(FontFamily.pretendard.displayName),
                value: FontFamily.pretendard,
                groupValue: viewModel.appState.fontFamily,
                onChanged: viewModel.setFontFamily,
              ),
              RadioListTile<FontFamily>(
                title: Text(FontFamily.leeSeoyun.displayName),
                value: FontFamily.leeSeoyun,
                groupValue: viewModel.appState.fontFamily,
                onChanged: viewModel.setFontFamily,
              ),
            ],
          );
        },
      ),
    );
  }
}
