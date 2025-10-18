part of 'statistics_view.dart';

class _StatisticsScreenContent extends StatefulWidget {
  @override
  State<_StatisticsScreenContent> createState() =>
      _StatisticsScreenContentState();
}

class _StatisticsScreenContentState extends State<_StatisticsScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLoading = context.select<StatisticsViewModel, bool>(
      (vm) => vm.isLoading,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.tab_statistics),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: t.statistics_weekly),
            Tab(text: t.statistics_monthly),
            Tab(text: t.statistics_yearly),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: const [
                _WeeklyStatisticsTab(),
                _MonthlyStatisticsTab(),
                _YearlyStatisticsTab(),
              ],
            ),
    );
  }
}

class _WeeklyStatisticsTab extends StatelessWidget {
  const _WeeklyStatisticsTab();

  @override
  Widget build(BuildContext context) {
    return Glower(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: Spacing.xl),
                const WeeklySummaryCard(),
                const SizedBox(height: Spacing.xl),
                const WeeklyMoodLineChart(),
                const SizedBox(height: Spacing.xl),
                const WeeklyActivityPattern(),
                const SizedBox(height: Spacing.xl),
                const WeeklyEmotionKeywords(),
                const SizedBox(height: kBottomNavigationBarHeight * 3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyStatisticsTab extends StatelessWidget {
  const _MonthlyStatisticsTab();

  @override
  Widget build(BuildContext context) {
    return Glower(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: Spacing.xl),
                const MonthlySummaryCard(),
                const SizedBox(height: Spacing.xl),
                const MonthlyCalendarHeatmap(),
                const SizedBox(height: Spacing.xl),
                const MonthlyWeeklyComparison(),
                const SizedBox(height: Spacing.xl),
                const MonthlyTopActivities(),
                const SizedBox(height: Spacing.xl),
                const MonthlyEmotionDistribution(),
                const SizedBox(height: kBottomNavigationBarHeight * 3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _YearlyStatisticsTab extends StatelessWidget {
  const _YearlyStatisticsTab();

  @override
  Widget build(BuildContext context) {
    return Glower(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: Spacing.xl),
                const YearlyDashboardCard(),
                const SizedBox(height: Spacing.xl),
                const YearlyMonthlyTrendChart(),
                const SizedBox(height: Spacing.xl),
                const YearlyQuarterComparison(),
                const SizedBox(height: Spacing.xl),
                const YearlyGrowthIndicator(),
                const SizedBox(height: Spacing.xl),
                const YearlyActivityReport(),
                const SizedBox(height: kBottomNavigationBarHeight * 3),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
