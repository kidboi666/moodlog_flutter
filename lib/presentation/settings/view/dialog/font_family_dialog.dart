import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/enum.dart';
import '../../viewmodel/settings_viewmodel.dart';

class FontFamilyDialog extends StatelessWidget {
  const FontFamilyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final setFontFamily = context.read<SettingsViewModel>().setFontFamily;

    return AlertDialog(
      title: Text(t.settings_common_font_family_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Selector<SettingsViewModel, FontFamily>(
            selector: (context, viewModel) => viewModel.appState.fontFamily,
            builder: (context, fontFamily, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<FontFamily>(
                    title: Text(FontFamily.pretendard.displayName),
                    value: FontFamily.pretendard,
                    groupValue: fontFamily,
                    onChanged: setFontFamily,
                  ),
                  RadioListTile<FontFamily>(
                    title: Text(FontFamily.leeSeoyun.displayName),
                    value: FontFamily.leeSeoyun,
                    groupValue: fontFamily,
                    onChanged: setFontFamily,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
