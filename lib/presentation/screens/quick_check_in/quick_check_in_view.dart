import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/domain/use_cases/create_quick_check_in_use_case.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/screens/quick_check_in/widgets/activity_input_page.dart';
import 'package:moodlog/presentation/screens/quick_check_in/widgets/emotion_keyword_page.dart';
import 'package:moodlog/presentation/screens/quick_check_in/widgets/mood_selection_page.dart';
import 'package:moodlog/presentation/screens/quick_check_in/widgets/quick_memo_page.dart';
import 'package:moodlog/presentation/screens/quick_check_in/widgets/sleep_quality_page.dart';
import 'package:moodlog/presentation/widgets/pagination_dot.dart';
import 'package:provider/provider.dart';

part 'quick_check_in_content.dart';

class QuickCheckInScreen extends StatelessWidget {
  const QuickCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuickCheckInViewModel(
        totalSteps: 5,
        createQuickCheckInUseCase: context.read<CreateQuickCheckInUseCase>(),
        getCurrentLocationUseCase: context.read<GetCurrentLocationUseCase>(),
        weatherUseCase: context.read<WeatherUseCase>(),
        journalRepository: context.read<JournalRepository>(),
      ),
      child: _QuickCheckInContent(),
    );
  }
}
