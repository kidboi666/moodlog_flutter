import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/presentation/screens/mood_summary/mood_summary_view_model.dart';
import 'package:provider/provider.dart';

part 'mood_summary_content.dart';

class MoodSummaryScreen extends StatelessWidget {
  const MoodSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoodSummaryViewModel(
        moodSummaryUseCase: context.read(),
      ),
      child: const _MoodSummaryContent(),
    );
  }
}
