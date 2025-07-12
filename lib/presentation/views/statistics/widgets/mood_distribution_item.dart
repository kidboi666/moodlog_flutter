import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';

class MoodDistributionItem extends StatelessWidget {
  final String mood;
  final int count;
  final Color color;

  const MoodDistributionItem({
    super.key,
    required this.mood,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Spacing.sm),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(child: Text(mood)),
          Text(
            AppLocalizations.of(
              context,
            )!.statistics_mood_distribution_unit(count),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
