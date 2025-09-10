import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../home/widgets/yearly_tracker/yearly_grid.dart';
import '../statistics_viewmodel.dart';
import 'base_card.dart';

class YearlyJournalTracker extends StatelessWidget {
  const YearlyJournalTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final yearlyJournals = context
        .select<StatisticsViewModel, Map<DateTime, List<Journal>>>(
          (vm) => vm.yearlyJournals,
        );

    // 데이터 존재 여부 확인
    final hasAnyJournals = yearlyJournals.values.any(
      (journalList) => journalList.isNotEmpty,
    );

    return BaseCard(
      title: t.home_yearly_tracker_title,
      icon: Icons.grid_4x4,
      child: hasAnyJournals
          ? YearlyGrid(now: now, yearlyJournals: yearlyJournals)
          : _buildEmptyState(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.grid_4x4_outlined,
            size: 64,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            t.home_representative_mood_empty,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
