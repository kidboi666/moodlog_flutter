import 'package:flutter/material.dart';

import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/journal_card.dart';
import '../widgets/empty_box.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
          const EmptyBox(),
        ],
      ),
    );
  }
}
