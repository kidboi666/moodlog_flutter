import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/journal/journal_viewmodel.dart';

class AiResponseBox extends StatelessWidget {
  final JournalViewModel viewModel;

  const AiResponseBox({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !viewModel.journal.aiResponseEnabled,
      child: Card(
        color: Color(
          viewModel.journal.moodType.colorValue,
        ).withValues(alpha: 0.6),
        margin: const EdgeInsets.all(Spacing.md),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            spacing: Spacing.xl,
            children: [
              Row(
                spacing: Spacing.md,
                children: [
                  Icon(Icons.adb),
                  Text(
                    AppLocalizations.of(context)!.write_ai_title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Text(
                viewModel.journal.aiResponse ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
