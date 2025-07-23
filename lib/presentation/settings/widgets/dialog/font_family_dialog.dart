import 'package:flutter/material.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../core/extensions/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../viewmodel/settings_viewmodel.dart';

class FontFamilyDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const FontFamilyDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.settings_common_font_family_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (_, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<FontFamily>(
                    title: Text(FontFamily.system.getDisplayName(context)),
                    value: FontFamily.system,
                    groupValue: viewModel.appState.fontFamily,
                    onChanged: viewModel.setFontFamily,
                  ),
                  RadioListTile<FontFamily>(
                    title: Text(FontFamily.pretendard.getDisplayName(context)),
                    value: FontFamily.pretendard,
                    groupValue: viewModel.appState.fontFamily,
                    onChanged: viewModel.setFontFamily,
                  ),
                  RadioListTile<FontFamily>(
                    title: Text(FontFamily.leeSeoyun.getDisplayName(context)),
                    value: FontFamily.leeSeoyun,
                    groupValue: viewModel.appState.fontFamily,
                    onChanged: viewModel.setFontFamily,
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
