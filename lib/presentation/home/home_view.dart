import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/ui/widgets/fade_in.dart';
import '../../core/ui/widgets/glower.dart';
import 'home_view_model.dart';
import 'widgets/app_drawer.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_floating_action_button.dart';
import 'widgets/journal_sliver_list.dart';
import 'widgets/unified_calendar.dart';
import 'widgets/welcome_zone.dart';

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
