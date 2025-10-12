import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/ui/widgets/glower.dart';
import 'package:moodlog/presentation/home/widgets/app_drawer.dart';
import 'package:moodlog/presentation/home/widgets/calendar_button.dart';
import 'package:moodlog/presentation/home/widgets/home_app_bar.dart';
import 'package:moodlog/presentation/home/widgets/home_floating_action_button.dart';
import 'package:moodlog/presentation/home/widgets/horizontal_calendar.dart';
import 'package:moodlog/presentation/home/widgets/journal_sliver_list.dart';
import 'package:moodlog/presentation/home/widgets/welcome_zone.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

part 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        userProvider: context.read(),
        journalUseCase: context.read(),
        observeJournalListUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
