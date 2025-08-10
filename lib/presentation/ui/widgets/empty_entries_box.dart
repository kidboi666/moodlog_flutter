import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/widget_scale.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class EmptyEntriesBox extends StatelessWidget {
  final void Function()? onPressed;
  final bool isDisabled;

  const EmptyEntriesBox({super.key, this.onPressed, this.isDisabled = false});

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
                onPressed: isDisabled
                    ? null
                    : (onPressed ?? () => context.push(Routes.write)),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return colorScheme.surfaceContainer.withValues(
                        alpha: 0.5,
                      );
                    }
                    return colorScheme.surfaceContainer;
                  }),
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
