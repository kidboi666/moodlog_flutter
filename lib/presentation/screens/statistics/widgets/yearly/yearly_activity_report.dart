import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyActivityReport extends StatelessWidget {
  const YearlyActivityReport({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final topActivities = context.select<StatisticsViewModel, List<String>>(
      (vm) => vm.yearlyTopActivities,
    );

    final checkIns = context.select<StatisticsViewModel, int>(
      (vm) => vm.yearlyCheckInsList.length,
    );

    final activityCounts = <String, int>{};
    if (topActivities.isNotEmpty) {
      final allCheckIns = context.read<StatisticsViewModel>().yearlyCheckInsList;
      for (var checkIn in allCheckIns) {
        final tags = checkIn.tagNames ?? [];
        for (var tag in tags) {
          activityCounts[tag] = (activityCounts[tag] ?? 0) + 1;
        }
      }
    }

    return BaseCard(
      title: t.statistics_yearly_activity_report,
      icon: Icons.assessment,
      child: topActivities.isEmpty
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
          : Column(
              children: topActivities.asMap().entries.map((entry) {
                final index = entry.key;
                final activity = entry.value;
                final count = activityCounts[activity] ?? 0;
                final percentage = checkIns > 0 ? (count / checkIns * 100).toDouble() : 0.0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.sm),
                  child: _ActivityItem(
                    rank: index + 1,
                    activity: activity,
                    count: count,
                    percentage: percentage,
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final int rank;
  final String activity;
  final int count;
  final double percentage;

  const _ActivityItem({
    required this.rank,
    required this.activity,
    required this.count,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color getRankColor() {
      if (rank == 1) return Colors.amber;
      if (rank == 2) return Colors.grey.shade400;
      if (rank == 3) return Colors.brown.shade400;
      return colorScheme.primary;
    }

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: getRankColor().withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              rank.toString(),
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: getRankColor(),
              ),
            ),
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
                  Expanded(
                    child: Text(
                      activity,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '$count회 (${percentage.toStringAsFixed(0)}%)',
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
                  minHeight: 4,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(getRankColor()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
