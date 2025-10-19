import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class MonthlyEmotionDistribution extends StatelessWidget {
  const MonthlyEmotionDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final emotionDistribution = context
        .select<StatisticsViewModel, Map<String, int>>(
          (vm) => vm.monthlyEmotionDistribution,
        );

    final totalCount = emotionDistribution.values.fold(
      0,
      (sum, count) => sum + count,
    );
    final sortedEmotions = emotionDistribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topEmotions = sortedEmotions.take(8).toList();

    return BaseCard(
      title: t.statistics_monthly_emotion_distribution,
      icon: Icons.psychology,
      child: topEmotions.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(
                  t.statistics_emotion_keywords_empty,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : Column(
              children: topEmotions.map((entry) {
                final emotion = entry.key;
                final count = entry.value;
                final percentage = totalCount > 0
                    ? (count / totalCount * 100).toDouble()
                    : 0.0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.md),
                  child: _EmotionItem(
                    emotion: emotion,
                    count: count,
                    percentage: percentage,
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _EmotionItem extends StatelessWidget {
  final String emotion;
  final int count;
  final double percentage;

  const _EmotionItem({
    required this.emotion,
    required this.count,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final emotionColors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.inversePrimary,
    ];

    final colorIndex = emotion.hashCode.abs() % emotionColors.length;
    final color = emotionColors[colorIndex];

    return Row(
      children: [
        Container(
          width: 8,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        CommonSizedBox.widthSm,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    emotion,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$count회 (${percentage.toStringAsFixed(1)}%)',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              CommonSizedBox.heightXs,
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 6,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
