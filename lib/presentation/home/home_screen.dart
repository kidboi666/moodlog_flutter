import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/ui/widgets/glower.dart';
import 'home_viewmodel.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/journal_sliver_list.dart';
import 'widgets/welcome_zone.dart';

part 'home_screen_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        observeJournalListUseCase: context.read(),
        userProvider: context.read(),
        journalUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
