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
                CommonSizedBox.heightXl,
                const WeeklySummaryCard(),
                CommonSizedBox.heightXl,
                const WeeklyMoodLineChart(),
                CommonSizedBox.heightXl,
                const WeeklyActivityPattern(),
                CommonSizedBox.heightXl,
                const WeeklyEmotionKeywords(),
                CommonSizedBox.homeBottomPadding,
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
                CommonSizedBox.heightXl,
                const MonthlySummaryCard(),
                CommonSizedBox.heightXl,
                const MonthlyCalendarHeatmap(),
                CommonSizedBox.heightXl,
                const MonthlyWeeklyComparison(),
                CommonSizedBox.heightXl,
                const MonthlyTopActivities(),
                CommonSizedBox.heightXl,
                const MonthlyEmotionDistribution(),
                CommonSizedBox.homeBottomPadding,
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
                CommonSizedBox.heightXl,
                const YearlyDashboardCard(),
                CommonSizedBox.heightXl,
                const YearlyMonthlyTrendChart(),
                CommonSizedBox.heightXl,
                const YearlyQuarterComparison(),
                CommonSizedBox.heightXl,
                const YearlyGrowthIndicator(),
                CommonSizedBox.heightXl,
                const YearlyActivityReport(),
                CommonSizedBox.homeBottomPadding,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
