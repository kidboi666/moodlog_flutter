part of 'statistics_view.dart';

class _StatisticsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.tab_statistics)),
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
            const SizedBox(height: Spacing.xl),
            SectionHeader(title: t.statistics_ai_report_title),
            Consumer<StatisticsViewModel>(
              builder: (context, viewModel, child) {
                final isProUser = viewModel.isProUser;
                return MenuListTile(
                  title: t.statistics_ai_report_title,
                  subtitle: t.statistics_ai_report_subtitle,
                  icon: Icons.auto_awesome,
                  onTap: () {
                    if (!isProUser) {
                      _showProFeatureDialog(context);
                    } else {
                      context.push(Routes.aiAnalysisReport);
                    }
                  },
                  trailing: isProUser
                      ? const Icon(Icons.arrow_forward_ios)
                      : const Icon(
                          Icons.workspace_premium,
                          color: Colors.amber,
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

void _showProFeatureDialog(BuildContext context) {
  final t = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('👑 ${t.proFeatureDialogTitle}'),
      content: Text(t.proFeatureDialogContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common_confirm_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.push(Routes.purchase);
          },
          child: Text(t.proFeatureDialogUpgradeButton),
        ),
      ],
    ),
  );
}
