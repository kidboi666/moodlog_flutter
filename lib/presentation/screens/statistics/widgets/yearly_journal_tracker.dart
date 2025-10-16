import 'package:flutter/material.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/home/widgets/yearly_tracker/yearly_grid.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/base_card.dart';
import 'package:provider/provider.dart';

class YearlyJournalTracker extends StatelessWidget {
  const YearlyJournalTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final yearlyCheckIns = context
        .select<StatisticsViewModel, Map<DateTime, List<CheckIn>>>(
          (vm) => vm.yearlyCheckIns,
        );

    // 데이터 존재 여부 확인
    final hasAnyCheckIns = yearlyCheckIns.values.any(
      (checkInList) => checkInList.isNotEmpty,
    );

    return BaseCard(
      title: t.home_yearly_tracker_title,
      icon: Icons.grid_4x4,
      child: hasAnyCheckIns
          ? YearlyGrid(now: now, yearlyJournals: yearlyCheckIns)
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
