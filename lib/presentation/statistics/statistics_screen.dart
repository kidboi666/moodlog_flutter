import 'package:flutter/material.dart';
import 'package:moodlog/presentation/layout/glower.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import 'statistics_viewmodel.dart';
import 'widgets/average_mood_card.dart';
import 'widgets/current_streak_card.dart';
import 'widgets/max_streak_card.dart';
import 'widgets/mood_distribution_card.dart';
import 'widgets/mood_trend_card.dart';
import 'widgets/representative_mood_card.dart';
import 'widgets/total_records_card.dart';
import 'widgets/writing_frequency_card.dart';
import 'widgets/yearly_journal_tracker.dart';

part 'statistics_screen_content.dart';

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
