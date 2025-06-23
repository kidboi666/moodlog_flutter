import 'package:flutter/material.dart';

import '../../view_models/home/home_viewmodel.dart';
import '../../widgets/journal_card.dart';
import 'home_horizontal_calendar.dart';
import 'home_welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel homeViewModel;

  const HomeScreen({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            WelcomeZone(),
            const SizedBox(height: 20),
            HorizontalCalendar(
              homeViewModel: homeViewModel,
              selectedDate: homeViewModel.selectedDate,
              onSelectedDateChange: homeViewModel.onSelectedDateChange,
            ),
            const SizedBox(height: 20),
            // ListView(
            //   shrinkWrap: true,
            //   children: [
            JournalCard(
              content: 'adsasdfdfasdfsdff',
              moodColor: Colors.orange,
              createdAt: DateTime.now(),
            ),
            // JournalCard(
            //   content: 'adsasdfdfasdfsdfddf',
            //   moodColor: Colors.orange,
            //   createdAt: DateTime.now(),
            // ),
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}
