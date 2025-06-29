import 'package:flutter/material.dart';
import 'package:moodlog/domain/repositories/app_state_repository.dart';
import 'package:provider/provider.dart';

import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/journal_card.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AppStateRepository>().isLoading;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return CustomScrollView(
            slivers: [
              SliverSafeArea(
                top: true,
                bottom: false,
                sliver: SliverToBoxAdapter(child: WelcomeZone()),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: HorizontalCalendar(
                  homeViewModel: viewModel,
                  selectedDate: viewModel.selectedDate,
                  onSelectedDateChange: viewModel.onSelectedDateChange,
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final e = viewModel.journal[index];
                  return JournalCard(
                    id: e.id,
                    content: e.content ?? '',
                    moodName: e.moodName,
                    createdAt: e.createdAt,
                  );
                }, childCount: viewModel.journal.length),
              ),
            ],
          );
        },
      ),
    );
  }
}
