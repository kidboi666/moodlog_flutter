import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import 'mood_calendar_card.dart';
import 'mood_distribution_card.dart';
import 'mood_trend_card.dart';
import 'overall_stats_card.dart';
import 'recent_activity_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.tab_statistics),
            actionsPadding: Spacing.containerHorizontalPadding,
            actions: [
              IconButton.filledTonal(
                onPressed: () => context.push(Routes.profile),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: Spacing.xl),
                OverallStatsCard(),
                const SizedBox(height: Spacing.xl),
                MoodCalendarCard(),
                const SizedBox(height: Spacing.xl),
                MoodDistributionCard(),
                const SizedBox(height: Spacing.xl),
                MoodTrendCard(),
                const SizedBox(height: Spacing.xl),
                RecentActivityCard(),
                const SizedBox(height: kBottomNavigationBarHeight * 3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
