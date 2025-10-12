import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/base_card.dart';
import 'package:moodlog/core/ui/widgets/statistic_display.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:provider/provider.dart';

class TotalRecordsCard extends StatelessWidget {
  const TotalRecordsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: StatisticDisplay(
              value: totalJournals.toString(),
              unit: t.statistics_total_records_count_unit,
            ),
          ),
          if (firstRecordDate != null) ...[
            CommonSizedBox.heightLg,
            InfoContainer(
              child: Column(
                children: [
                  InfoRow(
                    label: t.statistics_total_records_first_record,
                    value:
                        '${firstRecordDate.year}.${firstRecordDate.month.toString().padLeft(2, '0')}.${firstRecordDate.day.toString().padLeft(2, '0')}',
                  ),
                  CommonSizedBox.heightSm,
                  InfoRow(
                    label: t.statistics_total_records_period,
                    value: t.statistics_total_records_period_days(
                      daysSinceFirstRecord,
                    ),
                  ),
                  if (daysSinceFirstRecord > 0) ...[
                    CommonSizedBox.heightSm,
                    InfoRow(
                      label: t.statistics_total_records_avg_frequency,
                      value: t.statistics_total_records_weekly_frequency(
                        (totalJournals / daysSinceFirstRecord * 7)
                            .toStringAsFixed(1),
                      ),
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
