import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class WeeklyEmotionKeywords extends StatelessWidget {
  const WeeklyEmotionKeywords({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final topEmotions = context.select<StatisticsViewModel, List<String>>(
      (vm) => vm.weeklyTopEmotions,
    );

    return BaseCard(
      title: t.statistics_weekly_top_emotions,
      icon: Icons.favorite_outline,
      child: topEmotions.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(
                  t.statistics_mood_distribution_empty,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: topEmotions.asMap().entries.map((entry) {
                final index = entry.key;
                final emotion = entry.value;
                return _EmotionChip(
                  emotion: emotion,
                  rank: index + 1,
                );
              }).toList(),
            ),
    );
  }
}

class _EmotionChip extends StatelessWidget {
  final String emotion;
  final int rank;

  const _EmotionChip({
    required this.emotion,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
    ];

    final color = colors[rank - 1];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(Roundness.cardInner),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: Spacing.sm),
          Text(
            emotion,
            style: textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
