import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/l10n/app_localizations.dart';
import '../../statistics/viewmodel/statistics_viewmodel.dart';
import 'yearly_tracker/yearly_grid.dart';
import 'yearly_tracker/yearly_tracker_legend.dart';

class YearlyJournalTracker extends StatelessWidget {
  const YearlyJournalTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<StatisticsViewModel>(
      builder: (context, viewModel, child) {
        final now = DateTime.now();
        final yearlyJournals = viewModel.yearlyJournals;

        return Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목과 년도 표시
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.home_yearly_tracker_title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${now.year}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),

              YearlyGrid(now: now, yearlyJournals: yearlyJournals),

              const SizedBox(height: Spacing.sm),

              // 범례
              const YearlyTrackerLegend(),
            ],
          ),
        );
      },
    );
  }
}
