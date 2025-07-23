import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';

class EmptyEntriesBox extends StatelessWidget {
  const EmptyEntriesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.xxl),
      child: Column(
        spacing: Spacing.xxl,
        children: [
          Text(
            t.entries_empty_box_title,
            style: textTheme.titleLarge?.copyWith(color: colorScheme.outline),
          ),
          Text(
            t.entries_empty_box_description,
            style: textTheme.titleMedium?.copyWith(color: colorScheme.outline),
          ),
          FilledButton(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Spacing.sm),
              ),
            ),
            onPressed: () => context.push(Routes.write),
            child: Text(t.entries_empty_box_button),
          ),
        ],
      ),
    );
  }
}
