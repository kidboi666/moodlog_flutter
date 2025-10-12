import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/ui/widgets/glower.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/average_mood_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/current_streak_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/max_streak_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/mood_distribution_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/mood_trend_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/representative_mood_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/total_records_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/writing_frequency_card.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/yearly_journal_tracker.dart';
import 'package:provider/provider.dart';

part 'statistics_content.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatisticsViewModel(
        journalRepository: context.read(),
        userProvider: context.read(),
      ),
      child: _StatisticsScreenContent(),
    );
  }
}
