part of 'statistics_screen.dart';

class _StatisticsScreenContent extends StatelessWidget {
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
