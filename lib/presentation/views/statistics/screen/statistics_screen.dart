import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/statistics/statistics_viewmodel.dart';
import '../widgets/mood_calendar_card.dart';
import '../widgets/mood_distribution_card.dart';
import '../widgets/mood_trend_card.dart';
import '../widgets/overall_stats_card.dart';
import '../widgets/recent_activity_card.dart';

class StatisticsScreen extends StatelessWidget {
  final StatisticsViewModel viewModel;

  const StatisticsScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.tab_statistics)),
      body: Container(
        padding: Spacing.containerHorizontalPadding,
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return ListView(
              children: [
                OverallStatsCard(viewModel: viewModel),
                SizedBox(height: Spacing.xl),
                MoodCalendarCard(viewModel: viewModel),
                SizedBox(height: Spacing.xl),
                MoodDistributionCard(viewModel: viewModel),
                SizedBox(height: Spacing.xl),
                MoodTrendCard(viewModel: viewModel),
                SizedBox(height: Spacing.xl),
                RecentActivityCard(viewModel: viewModel),
                SizedBox(height: kBottomNavigationBarHeight),
              ],
            );
          },
        ),
      ),
    );
  }
}
