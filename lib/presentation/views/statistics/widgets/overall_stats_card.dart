import 'package:flutter/material.dart';
import 'package:moodlog/presentation/views/statistics/widgets/base_card.dart';
import 'package:moodlog/presentation/views/statistics/widgets/stat_item.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../view_models/statistics/statistics_viewmodel.dart';

class OverallStatsCard extends StatelessWidget {
  final StatisticsViewModel viewModel;

  const OverallStatsCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_total_title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatItem(
                label: AppLocalizations.of(
                  context,
                )!.statistics_total_record_description,
                value: AppLocalizations.of(
                  context,
                )!.statistics_total_record(viewModel.totalJournals.toString()),
                icon: Icons.edit_note,
              ),
              StatItem(
                label: AppLocalizations.of(
                  context,
                )!.statistics_total_streak_description,
                value: AppLocalizations.of(
                  context,
                )!.statistics_total_streak(viewModel.currentStreak),
                icon: Icons.local_fire_department,
              ),
              StatItem(
                label: AppLocalizations.of(
                  context,
                )!.statistics_total_streak_max_description,
                value: AppLocalizations.of(
                  context,
                )!.statistics_total_streak_max(viewModel.maxStreak),
                icon: Icons.emoji_events,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
