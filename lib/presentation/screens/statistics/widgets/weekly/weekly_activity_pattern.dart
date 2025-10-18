import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/widgets/base_card.dart';
import 'package:provider/provider.dart';

class WeeklyActivityPattern extends StatelessWidget {
  const WeeklyActivityPattern({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final dayPattern = context.select<StatisticsViewModel, Map<int, int>>(
      (vm) => vm.weeklyDayPattern,
    );

    final maxCount = dayPattern.values.isEmpty
        ? 0
        : dayPattern.values.reduce((a, b) => a > b ? a : b);

    return BaseCard(
      title: t.statistics_weekly_activity_pattern,
      icon: Icons.bar_chart,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final dayOfWeek = index + 1;
              final count = dayPattern[dayOfWeek] ?? 0;
              return _DayBar(
                dayOfWeek: dayOfWeek,
                count: count,
                maxCount: maxCount,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  final int dayOfWeek;
  final int count;
  final int maxCount;

  const _DayBar({
    required this.dayOfWeek,
    required this.count,
    required this.maxCount,
  });

  String _getDayLabel(BuildContext context, int dayOfWeek) {
    final t = AppLocalizations.of(context)!;
    switch (dayOfWeek) {
      case 1:
        return t.calendar_weekday_mon;
      case 2:
        return t.calendar_weekday_tue;
      case 3:
        return t.calendar_weekday_wed;
      case 4:
        return t.calendar_weekday_thu;
      case 5:
        return t.calendar_weekday_fri;
      case 6:
        return t.calendar_weekday_sat;
      case 7:
        return t.calendar_weekday_sun;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final barHeight = maxCount > 0 ? (count / maxCount * 100).clamp(8.0, 100.0) : 8.0;
    final isHighest = count == maxCount && count > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: textTheme.labelSmall?.copyWith(
            color: isHighest ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: isHighest ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        CommonSizedBox.heightXs,
        Container(
          width: 28,
          height: barHeight,
          decoration: BoxDecoration(
            color: isHighest
                ? colorScheme.primary
                : colorScheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        CommonSizedBox.heightXs,
        Text(
          _getDayLabel(context, dayOfWeek),
          style: textTheme.labelSmall?.copyWith(
            color: isHighest ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: isHighest ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
