import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:moodlog/presentation/widgets/statistic_display.dart';
import 'package:provider/provider.dart';

class CurrentStreakCard extends StatelessWidget {
  const CurrentStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final currentStreak = context.select<StatisticsViewModel, int>(
      (vm) => vm.currentStreak,
    );
    final allCheckIns = context.select<StatisticsViewModel, List<CheckIn>>(
      (vm) => vm.allCheckIns,
    );
    final lastRecordDate = allCheckIns.isNotEmpty
        ? allCheckIns
              .map((c) => c.createdAt)
              .reduce((a, b) => a.isAfter(b) ? a : b)
        : null;
    final daysSinceLastRecord = lastRecordDate != null
        ? DateTime.now().difference(lastRecordDate).inDays
        : 0;
    final isStreakActive = daysSinceLastRecord <= 1;
    final streakStatus = isStreakActive
        ? t.statistics_streak_status_active
        : t.statistics_streak_status_inactive;
    final streakColor = isStreakActive
        ? colorScheme.primary
        : colorScheme.error;

    return BaseCard(
      title: t.statistics_total_streak_description,
      icon: Icons.emoji_events,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      currentStreak.toString(),
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: streakColor,
                      ),
                    ),
                    CommonSizedBox.widthXs,
                    Text(
                      t.common_unit_day,
                      style: textTheme.titleLarge?.copyWith(
                        color: streakColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                CommonSizedBox.heightXs,
                StatusIndicator(status: streakStatus, color: streakColor),
              ],
            ),
          ),
          if (lastRecordDate != null) ...[
            CommonSizedBox.heightLg,
            InfoContainer(
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                children: [
                  InfoRow(
                    label: t.statistics_streak_last_record,
                    value: daysSinceLastRecord == 0
                        ? t.common_date_today
                        : daysSinceLastRecord == 1
                        ? t.common_date_yesterday
                        : t.statistics_streak_days_ago(daysSinceLastRecord),
                  ),
                  if (!isStreakActive && currentStreak > 0) ...[
                    CommonSizedBox.heightSm,
                    InfoRow(
                      label: t.statistics_streak_stopped,
                      value: t.statistics_streak_stopped_days(
                        daysSinceLastRecord - 1,
                      ),
                      labelColor: colorScheme.error,
                      valueColor: colorScheme.error,
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (isStreakActive && currentStreak > 0) ...[
            CommonSizedBox.heightMd,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Roundness.cardInner),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  CommonSizedBox.widthSm,
                  Expanded(
                    child: Text(
                      t.statistics_streak_encouragement,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
