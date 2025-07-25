import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../onboarding/widgets/onboarding_personality_item.dart';
import '../../viewmodel/settings_viewmodel.dart';

class AiPersonalityDialog extends StatefulWidget {
  final SettingsViewModel viewModel;

  const AiPersonalityDialog({super.key, required this.viewModel});

  @override
  State<AiPersonalityDialog> createState() => _AiPersonalityDialogState();
}

class _AiPersonalityDialogState extends State<AiPersonalityDialog> {
  late AiPersonality _selectedPersonality;

  @override
  void initState() {
    super.initState();
    _selectedPersonality = widget.viewModel.appState.aiPersonality;
  }

  void _setPersonality(AiPersonality personality) {
    setState(() {
      _selectedPersonality = personality;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    
    return AlertDialog(
      title: Text(t.onboarding_personality_title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.onboarding_personality_description,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: Spacing.lg),
            ...AiPersonality.values.map((personality) {
              final isSelected = personality == _selectedPersonality;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: Spacing.sm),
                child: PersonalityItem(
                  personality: personality,
                  isSelected: isSelected,
                  selectedPersonality: _selectedPersonality,
                  setPersonality: _setPersonality,
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common_confirm_cancel),
        ),
        FilledButton(
          onPressed: () {
            widget.viewModel.setAiPersonality(_selectedPersonality);
            Navigator.of(context).pop();
          },
          child: Text(t.common_confirm_save),
        ),
      ],
    );
  }
}