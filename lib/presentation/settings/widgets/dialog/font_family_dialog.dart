import 'package:flutter/material.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/ui/widgets/base_settings_dialog.dart';
import '../../settings_view_model.dart';

class FontFamilyDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const FontFamilyDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_font_family_title,
      content: RadioGroup(
        groupValue: viewModel.appState.fontFamily,
        onChanged: viewModel.setFontFamily,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: FontFamily.values.map((fontFamily) {
            return RadioListTile(
              value: fontFamily,
              title: Text(
                fontFamily.getDisplayName(context),
                style: TextStyle(
                  fontFamily: fontFamily.value,
                  fontSize: fontFamily.fixedFontSize,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
