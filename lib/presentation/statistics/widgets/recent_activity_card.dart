import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'activity_item.dart';
import 'base_card.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatisticsViewModel>(context);

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.statistics_recent_title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.lg),
          if (viewModel.recentJournals.isEmpty)
            Text(AppLocalizations.of(context)!.statistics_recent_empty)
          else
            ...viewModel.recentJournals.map((journal) {
              return ActivityItem(
                date: DateFormat('yyyy.MM.dd').format(journal.createdAt),
                note: journal.content ?? '',
                emoji: journal.moodType.emoji,
              );
            }),
        ],
      ),
    );
  }
}
