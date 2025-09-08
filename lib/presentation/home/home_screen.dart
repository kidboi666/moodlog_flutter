import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/glower.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/routing.dart';
import '../../core/ui/widgets/empty_entries_box.dart';
import '../../core/ui/widgets/fade_in.dart';
import '../../core/ui/widgets/journal_card.dart';
import '../../domain/entities/journal.dart';
import 'home_viewmodel.dart';
import 'widgets/horizontal_calendar.dart';
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
        journalUseCase: context.read(),
      ),
      child: _HomeScreenContent(),
    );
  }
}
