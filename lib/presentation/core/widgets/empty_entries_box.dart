import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/widget_scale.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';

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
        dashPattern: [5, 5],
        strokeWidth: 1,
        color: colorScheme.outlineVariant,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          child: Column(
            spacing: Spacing.sm,
            children: [
              Column(
                spacing: Spacing.sm,
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 64,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                  Text(
                    t.entries_empty_box_title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outlineVariant,
                      fontWeight: FontWeight.bold,
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
                  children: [
                    const Icon(Icons.add),
                    Text(t.entries_empty_box_button),
                  ],
                ),
              ).scale(),
            ],
          ),
        ),
      ),
    );
  }
}
