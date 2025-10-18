import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/statistics/statistics_view_model.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/weekly/weekly_activity_pattern.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/weekly/weekly_emotion_keywords.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/weekly/weekly_mood_line_chart.dart';
import 'package:moodlog/presentation/screens/statistics/widgets/weekly/weekly_summary_card.dart';
import 'package:moodlog/presentation/widgets/glower.dart';
import 'package:provider/provider.dart';

part 'statistics_content.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StatisticsViewModel(
        checkInRepository: context.read(),
        userProvider: context.read(),
      ),
      child: _StatisticsScreenContent(),
    );
  }
}
