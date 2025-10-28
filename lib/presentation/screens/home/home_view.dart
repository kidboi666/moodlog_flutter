import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/screens/home/widgets/app_drawer.dart';
import 'package:moodlog/presentation/screens/home/widgets/home_app_bar.dart';
import 'package:moodlog/presentation/screens/home/widgets/home_floating_action_button.dart';
import 'package:moodlog/presentation/screens/home/widgets/mood_summary_card.dart';
import 'package:moodlog/presentation/screens/home/widgets/timeline_sliver_list.dart';
import 'package:moodlog/presentation/screens/home/widgets/unified_calendar.dart';
import 'package:moodlog/presentation/screens/home/widgets/welcome_zone.dart';
import 'package:moodlog/presentation/widgets/banner_ad_widget.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

part 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        userProvider: context.read(),
        journalUseCase: context.read(),
        checkInUseCase: context.read(),
        observeJournalListUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
        moodSummaryUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
