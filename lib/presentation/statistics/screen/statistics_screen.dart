import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../widgets/avatar.dart';
import '../viewmodel/statistics_viewmodel.dart';
import '../widgets/mood_calendar_card.dart';
import '../widgets/mood_distribution_card.dart';
import '../widgets/mood_trend_card.dart';
import '../widgets/overall_stats_card.dart';
import '../widgets/recent_activity_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Selector<StatisticsViewModel, String?>(
            selector: (_, viewModel) => viewModel.profileImage,
            builder: (_, profileImage, _) => SliverAppBar(
              title: Text(AppLocalizations.of(context)!.tab_statistics),
              actionsPadding: Spacing.containerHorizontalPadding,
              actions: [
                Avatar(
                  photoUrl: profileImage,
                  onTap: () => context.push(Routes.profile),
                ),
              ],
            ),
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
