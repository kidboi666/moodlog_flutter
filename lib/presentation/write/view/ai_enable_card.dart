import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';

class AiEnableCard extends StatelessWidget {
  const AiEnableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.read<WriteViewModel>().updateAiEnabled(
          !context.watch<WriteViewModel>().aiEnabled,
        ),
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
                  value: context.watch<WriteViewModel>().aiEnabled,
                  onChanged: context.read<WriteViewModel>().updateAiEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
