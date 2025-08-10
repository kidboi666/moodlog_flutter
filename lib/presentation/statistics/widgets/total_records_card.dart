import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../domain/entities/journal.dart';
import '../viewmodel/statistics_viewmodel.dart';
import 'base_card.dart';

class TotalRecordsCard extends StatelessWidget {
  const TotalRecordsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final totalJournals = context.select<StatisticsViewModel, int>(
      (vm) => vm.totalJournals,
    );
    final allJournals = context.select<StatisticsViewModel, List<Journal>>(
      (vm) => vm.allJournals,
    );
    final firstRecordDate = allJournals.isNotEmpty
        ? allJournals
              .map((j) => j.createdAt)
              .reduce((a, b) => a.isBefore(b) ? a : b)
        : null;
    final daysSinceFirstRecord = firstRecordDate != null
        ? DateTime.now().difference(firstRecordDate).inDays + 1
        : 0;

    return BaseCard(
      title: t.statistics_total_record_description,
      icon: Icons.edit_note,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  totalJournals.toString(),
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  t.statistics_total_records_count_unit,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (firstRecordDate != null) ...[
            const SizedBox(height: Spacing.lg),
            Container(
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(Roundness.cardInner),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.statistics_total_records_first_record,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${firstRecordDate.year}.${firstRecordDate.month.toString().padLeft(2, '0')}.${firstRecordDate.day.toString().padLeft(2, '0')}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.statistics_total_records_period,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        t.statistics_total_records_period_days(
                          daysSinceFirstRecord,
                        ),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (daysSinceFirstRecord > 0) ...[
                    const SizedBox(height: Spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.statistics_total_records_avg_frequency,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          t.statistics_total_records_weekly_frequency(
                            (totalJournals / daysSinceFirstRecord * 7)
                                .toStringAsFixed(1),
                          ),
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
