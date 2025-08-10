import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/routing.dart';
import '../../core/routing/routes.dart';
import '../../domain/entities/journal.dart';
import '../ui/widgets/avatar.dart';
import '../ui/widgets/empty_entries_box.dart';
import '../ui/widgets/fade_in.dart';
import '../ui/widgets/journal_card.dart';
import 'home_viewmodel.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/weather_widget.dart';
import 'widgets/welcome_zone.dart';

part 'home_screen_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        journalRepository: context.read(),
        userProvider: context.read(),
        deleteJournalUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        getCurrentWeatherUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
