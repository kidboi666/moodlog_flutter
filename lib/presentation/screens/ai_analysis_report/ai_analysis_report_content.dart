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

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSummaryCard(context, report.summary),
        const SizedBox(height: 16),
        _buildKeywordsCard(
          context,
          title: t.ai_report_positive_keywords,
          keywords: report.positiveKeywords,
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: 16),
        _buildKeywordsCard(
          context,
          title: t.ai_report_negative_keywords,
          keywords: report.negativeKeywords,
          color: Colors.red.shade100,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, String summary) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📝 ${AppLocalizations.of(context)!.statistics_ai_report_title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordsCard(
    BuildContext context, {
    required String title,
    required List<String> keywords,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (keywords.isEmpty)
              Text(
                'No keywords found.', // TODO: Localize
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
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
