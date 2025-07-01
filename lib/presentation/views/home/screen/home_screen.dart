import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/journal_card.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Spacing.paddingHorizontal,
      child: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: true,
            bottom: false,
            sliver: SliverToBoxAdapter(
              child: WelcomeZone(viewModel: viewModel),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: HorizontalCalendar(viewModel: viewModel)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final e = viewModel.journal[index];
              return FadeIn(
                delay: DelayMs.medium * 5,
                child: JournalCard(
                  id: e.id,
                  content: e.content ?? '',
                  moodType: e.moodType,
                  createdAt: e.createdAt,
                ),
              );
            }, childCount: viewModel.journal.length),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(
              height: Spacing.bottomNavigationBarHeight * 2,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
