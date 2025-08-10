import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../statistics/statistics_viewmodel.dart';
import '../../statistics/widgets/base_card.dart';
import 'yearly_tracker/yearly_grid.dart';

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

        return BaseCard(
          title: t.home_yearly_tracker_title,
          icon: Icons.grid_4x4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목과 년도 표시
              Row(
                children: [
                  Text(
                    '${now.year}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.lg),

              YearlyGrid(now: now, yearlyJournals: yearlyJournals),
            ],
          ),
        );
      },
    );
  }
}
