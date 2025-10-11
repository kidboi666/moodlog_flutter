import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/routing/routes.dart';
import '../../core/ui/widgets/glower.dart';
import 'home_view_model.dart';
import 'widgets/app_drawer.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/journal_sliver_list.dart';
import 'widgets/title_bar.dart';
import 'widgets/welcome_zone.dart';

part 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        observeJournalListUseCase: context.read(),
        userProvider: context.read(),
        journalUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
