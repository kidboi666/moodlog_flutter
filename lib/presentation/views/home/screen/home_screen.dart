import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/journal_card.dart';
import '../widgets/empty_box.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Container(
          padding: Spacing.containerHorizontalPadding,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: Spacing.xl)),
              SliverSafeArea(
                top: true,
                bottom: false,
                sliver: SliverToBoxAdapter(
                  child: WelcomeZone(viewModel: widget.viewModel),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: Spacing.xl)),
              SliverToBoxAdapter(
                child: HorizontalCalendar(viewModel: widget.viewModel),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: Spacing.xl)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final e = widget.viewModel.journal[index];
                  return FadeIn(
                    delay: DelayMs.medium,
                    child: JournalCard(
                      id: e.id,
                      content: e.content ?? '',
                      moodType: e.moodType,
                      createdAt: e.createdAt,
                    ),
                  );
                }, childCount: widget.viewModel.journal.length),
              ),
              if (widget.viewModel.journal.isEmpty &&
                  !widget.viewModel.isLoading)
                SliverToBoxAdapter(child: FadeIn(child: EmptyBox())),
              SliverToBoxAdapter(
                child: const SizedBox(height: kBottomNavigationBarHeight),
              ),
            ],
          ),
        );
      },
    );
  }
}
