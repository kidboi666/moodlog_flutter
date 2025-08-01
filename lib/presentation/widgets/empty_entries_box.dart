import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/widget_scale.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/routing/routes.dart';

class EmptyEntriesBox extends StatelessWidget {
  const EmptyEntriesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(24),
        dashPattern: [10, 5],
        strokeWidth: 2,
        color: colorScheme.outlineVariant,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          child: Column(
            spacing: Spacing.xxl,
            children: [
              Column(
                spacing: Spacing.sm,
                children: [
                  Text(
                    t.entries_empty_box_title,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  Text(
                    t.entries_empty_box_description,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                ],
              ),
              FilledButton.tonal(
                onPressed: () => context.push(Routes.write),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    colorScheme.surfaceContainer,
                  ),
                ),
                child: Row(
                  spacing: Spacing.md,
                  mainAxisSize: MainAxisSize.min,
                  children: [const Icon(Icons.add)],
                ),
              ).scale(),
            ],
          ),
        ),
      ),
    );
  }
}
