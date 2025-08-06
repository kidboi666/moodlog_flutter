import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../../common/routing/routes.dart';
import '../../core/widgets/avatar.dart';
import '../../home/widgets/representative_mood_card.dart';
import '../../home/widgets/yearly_journal_tracker.dart';
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
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Builder(
            builder: (context) {
              final profileImage = context.select<StatisticsViewModel, String?>(
                (vm) => vm.profileImage,
              );

              return SliverAppBar(
                title: Text(t.tab_statistics),
                actionsPadding: Spacing.containerHorizontalPadding,
                actions: [
                  Avatar(
                    photoUrl: profileImage,
                    onTap: () => context.push(Routes.profile),
                  ),
                ],
              );
            },
          ),
          Builder(
            builder: (context) {
              final isLoading = context.select<StatisticsViewModel, bool>(
                (vm) => vm.isLoading,
              );

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
                    const RepresentativeMoodCard(),
                    const SizedBox(height: Spacing.xl),
                    const YearlyJournalTracker(),
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
                    const MoodDistributionCard(),
                    const SizedBox(height: Spacing.xl),
                    const MoodTrendCard(),
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
