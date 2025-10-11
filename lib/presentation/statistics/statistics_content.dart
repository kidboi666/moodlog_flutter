part of 'statistics_view.dart';

class _StatisticsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tab_statistics),
      ),
      body: Glower(
        child: CustomScrollView(
          slivers: [
            Builder(
              builder: (context) {
                final isLoading = context.select<StatisticsViewModel, bool>(
                  (vm) => vm.isLoading,
                );

                if (isLoading) {
                  return const SliverFillRemaining(
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
      ),
    );
  }
}
