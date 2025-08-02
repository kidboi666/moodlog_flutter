import 'package:flutter/material.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';

class LegendCard extends StatelessWidget {
  const LegendCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(
            context,
            color: colorScheme.secondary,
            text: t.entries_calendar_legend_has_journal,
          ),
          _buildLegendItem(
            context,
            color: colorScheme.primary.withValues(alpha: 0.5),
            text: t.entries_calendar_legend_today,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context, {
    required Color color,
    required String text,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: Spacing.xs),
        Text(text, style: textTheme.bodySmall),
      ],
    );
  }
}
