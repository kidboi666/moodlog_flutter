import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

class AiAnalysisReportScreen extends StatelessWidget {
  const AiAnalysisReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.statistics_ai_report_title),
      ),
      body: Center(
        child: Column(
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
