import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';
import 'stat_item.dart';

class OverallStatsCard extends StatelessWidget {
  const OverallStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StatisticsViewModel>();
    final totalJournals = viewModel.totalJournals;
    final currentStreak = viewModel.currentStreak;
    final maxStreak = viewModel.maxStreak;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_total_title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatItem(
                label: t.statistics_total_record_description,
                value: t.statistics_total_record(totalJournals),
                icon: Icons.edit_note,
              ),
              StatItem(
                label: t.statistics_total_streak_description,
                value: t.statistics_total_streak(currentStreak),
                icon: Icons.local_fire_department,
              ),
              StatItem(
                label: t.statistics_total_streak_max_description,
                value: t.statistics_total_streak_max(maxStreak),
                icon: Icons.emoji_events,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
