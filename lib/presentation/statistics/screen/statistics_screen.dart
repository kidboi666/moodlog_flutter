import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';
import '../../core/widgets/avatar.dart';
import '../viewmodel/statistics_viewmodel.dart';
import '../widgets/average_mood_card.dart';
import '../widgets/current_streak_card.dart';
import '../widgets/max_streak_card.dart';
import '../widgets/mood_distribution_card.dart';
import '../widgets/mood_trend_card.dart';
import '../widgets/total_records_card.dart';
import '../widgets/writing_frequency_card.dart';

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
          Selector<StatisticsViewModel, bool>(
            selector: (_, viewModel) => viewModel.isLoading,
            builder: (_, isLoading, __) {
              if (isLoading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SliverPadding(
                padding: Spacing.containerHorizontalPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: Spacing.xl),
                    const TotalRecordsCard(),
                    const SizedBox(height: Spacing.xl),
                    const CurrentStreakCard(),
                    const SizedBox(height: Spacing.xl),
                    const MaxStreakCard(),
                    const SizedBox(height: Spacing.xl),
                    const AverageMoodCard(),
                    const SizedBox(height: Spacing.xl),
                    const WritingFrequencyCard(),
                    const SizedBox(height: Spacing.xl),
                    // const MoodCalendarCard(),
                    // const SizedBox(height: Spacing.xl),
                    const MoodDistributionCard(),
                    const SizedBox(height: Spacing.xl),
                    const MoodTrendCard(),
                    // const RecentActivityCard(),
                    const SizedBox(height: kBottomNavigationBarHeight * 3),
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
