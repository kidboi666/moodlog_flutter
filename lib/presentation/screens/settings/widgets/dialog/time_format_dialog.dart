import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/settings/settings_view_model.dart';
import 'package:moodlog/presentation/widgets/base_settings_dialog.dart';

class TimeFormatDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const TimeFormatDialog({super.key, required this.viewModel});

  String _getDisplayName(BuildContext context, TimeFormat format) {
    final t = AppLocalizations.of(context)!;
    switch (format) {
      case TimeFormat.hour24:
        return t.settings_time_format_24hour;
      case TimeFormat.hour12:
        return t.settings_time_format_12hour;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BaseSettingsDialog(
      viewModel: viewModel,
      title: t.settings_common_time_format_title,
      content: RadioGroup(
        groupValue: viewModel.appState.timeFormat,
        onChanged: viewModel.setTimeFormat,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text(_getDisplayName(context, TimeFormat.hour24)),
              value: TimeFormat.hour24,
            ),
            RadioListTile(
              title: Text(_getDisplayName(context, TimeFormat.hour12)),
              value: TimeFormat.hour12,
            ),
          ],
        ),
      ),
    );
  }
}
