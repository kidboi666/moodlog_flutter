import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../view_models/settings/settings_viewmodel.dart';

class FontFamilyDialog extends StatelessWidget {
  const FontFamilyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SettingsViewModel>();
    final fontFamily = context.select(
      (SettingsViewModel viewModel) => viewModel.appState.fontFamily,
    );

    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.settings_common_font_family_title,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<FontFamily>(
            title: Text(FontFamily.pretendard.displayName),
            value: FontFamily.pretendard,
            groupValue: fontFamily,
            onChanged: viewModel.setFontFamily,
          ),
          RadioListTile<FontFamily>(
            title: Text(FontFamily.leeSeoyun.displayName),
            value: FontFamily.leeSeoyun,
            groupValue: fontFamily,
            onChanged: viewModel.setFontFamily,
          ),
        ],
      ),
    );
  }
}
