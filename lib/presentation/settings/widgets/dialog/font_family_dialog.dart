import 'package:flutter/material.dart';

import '../../../../common/constants/enum.dart';
import '../../../../common/extensions/enum.dart';
import '../../../../common/l10n/app_localizations.dart';
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
                children: FontFamily.values.map((fontFamily) {
                  return RadioListTile<FontFamily>(
                    title: Text(
                      fontFamily.getDisplayName(context),
                      style: TextStyle(
                        fontFamily: fontFamily.value,
                        fontSize: fontFamily.fixedFontSize,
                      ),
                    ),
                    value: fontFamily,
                    groupValue: viewModel.appState.fontFamily,
                    onChanged: viewModel.setFontFamily,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
