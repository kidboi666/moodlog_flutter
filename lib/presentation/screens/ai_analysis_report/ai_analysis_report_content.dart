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
      body: Center(
        child: viewModel.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.science_outlined, size: 80),
                  const SizedBox(height: 20),
                  Text(
                    t.common_developing,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
      ),
    );
  }
}
