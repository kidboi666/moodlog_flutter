import 'package:flutter/material.dart';

import '../../view_models/home/home_viewmodel.dart';
import '../../widgets/journal_card.dart';
import 'home_horizontal_calendar.dart';
import 'home_welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

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
              homeViewModel: viewModel,
              selectedDate: viewModel.selectedDate,
              onSelectedDateChange: viewModel.onSelectedDateChange,
            ),
            const SizedBox(height: 20),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: viewModel.journal
                      .map(
                        (e) => JournalCard(
                          id: e.id,
                          content: e.content ?? '',
                          moodName: e.moodName,
                          createdAt: e.createdAt,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
