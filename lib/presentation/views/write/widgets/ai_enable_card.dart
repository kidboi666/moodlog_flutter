import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/write/write_viewmodel.dart';

class AiEnableCard extends StatelessWidget {
  final WriteViewModel viewModel;

  const AiEnableCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => viewModel.updateAiEnabled(!viewModel.aiEnabled),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(child: Icon(Icons.adb)),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.write_ai_title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(AppLocalizations.of(context)!.write_ai_description),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Switch(
                  value: viewModel.aiEnabled,
                  onChanged: viewModel.updateAiEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
