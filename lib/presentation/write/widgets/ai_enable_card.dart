import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/snack_bar.dart';
import '../../../core/extensions/widget.dart';
import '../../../core/l10n/app_localizations.dart';
import '../write_view_model.dart';

class AiEnableCard extends StatelessWidget {
  const AiEnableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<WriteViewModel>();
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      child: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              if (viewModel.content == null || viewModel.content!.trim().isEmpty) {
                context.showSnackBar(
                  const SnackBar(
                    content: Text('Please write something first.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
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
                        Row(
                          children: [
                            Text(t.write_ai_title, style: textTheme.titleMedium),
                            const Spacer(),
                            Text(
                              '(${3 - viewModel.aiUsageCount}/3)',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        Text(t.write_ai_description),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Switch(
                      value: viewModel.aiEnabled,
                      onChanged: (viewModel.canUseAiToday && viewModel.content != null && viewModel.content!.trim().isNotEmpty)
                          ? viewModel.updateAiEnabled
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).scale();
  }
}
