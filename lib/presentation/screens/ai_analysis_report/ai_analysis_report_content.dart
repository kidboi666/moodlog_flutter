part of 'ai_analysis_report_view.dart';

class _AiAnalysisReportContent extends StatelessWidget {
  const _AiAnalysisReportContent();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<AiAnalysisReportViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.statistics_ai_report_title),
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, AiAnalysisReportViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.hasError || viewModel.report == null) {
      return Center(child: Text('Error: ${viewModel.error ?? 'Report not available.'}'));
    }

    final report = viewModel.report!;
    final t = AppLocalizations.of(context)!;

    // Check if there is enough data for analysis
    if (report.summary.isNotEmpty &&
        report.positiveKeywords.isEmpty &&
        report.negativeKeywords.isEmpty) {
      return _buildNotEnoughDataWidget(context);
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSummaryCard(context, report.summary),
        const SizedBox(height: 16),
        _buildKeywordsCard(
          context,
          title: t.ai_report_positive_keywords,
          icon: Icons.sentiment_very_satisfied,
          keywords: report.positiveKeywords,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        const SizedBox(height: 16),
        _buildKeywordsCard(
          context,
          title: t.ai_report_negative_keywords,
          icon: Icons.sentiment_very_dissatisfied,
          keywords: report.negativeKeywords,
          color: Theme.of(context).colorScheme.errorContainer,
        ),
      ],
    );
  }

  Widget _buildNotEnoughDataWidget(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 80),
            const SizedBox(height: 20),
            Text(
              t.ai_report_not_enough_data,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String summary) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.statistics_ai_report_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> keywords,
    required Color color,
  }) {
    final t = AppLocalizations.of(context)!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(height: 24),
            if (keywords.isEmpty)
              Text(
                t.ai_report_no_keywords,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: keywords
                    .map((keyword) => Chip(
                          label: Text(keyword),
                          backgroundColor: color,
                          side: BorderSide.none,
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
