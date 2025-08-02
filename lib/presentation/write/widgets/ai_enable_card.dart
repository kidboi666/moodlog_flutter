import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/snack_bar.dart';
import '../../../common/extensions/widget_scale.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';

class AiEnableCard extends StatelessWidget {
  const AiEnableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        return Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              if (viewModel.canUseAiToday) {
                viewModel.updateAiEnabled(!viewModel.aiEnabled);
              } else {
                context.showSnackBar(
                  SnackBar(
                    content: Text(t.write_ai_limit_reached),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(child: Icon(Icons.psychology)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.write_ai_title, style: textTheme.titleMedium),
                        Text(t.write_ai_description),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Switch(
                      value: viewModel.aiEnabled,
                      onChanged: viewModel.canUseAiToday
                          ? viewModel.updateAiEnabled
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).scale();
      },
    );
  }
}
