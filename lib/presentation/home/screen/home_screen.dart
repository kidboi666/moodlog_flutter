import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/routing/routes.dart';
import '../../../domain/entities/journal.dart';
import '../../ui/widgets/avatar.dart';
import '../../ui/widgets/empty_entries_box.dart';
import '../../ui/widgets/fade_in.dart';
import '../../ui/widgets/journal_card.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/weather_widget.dart';
import '../widgets/welcome_zone.dart';

typedef HomeFeedState = ({
  bool isFirstRender,
  List<Journal> journal,
  bool isLoading,
  DateTime selectedDate,
  bool isSelectedDateInFuture,
});

typedef HomeCalendarState = ({DateTime selectedDate, String? nickname});

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),
        SliverAppBar(
          title: FadeIn(delay: DelayMs.medium, child: const WeatherWidget()),
          actionsPadding: Spacing.containerHorizontalPadding,
          actions: [
            Selector<HomeViewModel, String?>(
              selector: (_, viewModel) => viewModel.profileImage,
              builder: (context, profileImage, _) {
                return Avatar(
                  photoUrl: profileImage,
                  onTap: () => context.push(Routes.profile),
                );
              },
            ),
          ],
        ),

        SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver: Selector<HomeViewModel, HomeCalendarState>(
            selector: (_, viewModel) => (
              selectedDate: viewModel.selectedDate,
              nickname: viewModel.nickname,
            ),
            builder: (_, viewModel, _) => SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeZone(),
                  const SizedBox(height: Spacing.xl),
                  const HorizontalCalendar(),
                  const SizedBox(height: Spacing.xl),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver: Selector<HomeViewModel, HomeFeedState>(
            selector: (_, viewModel) => (
              isFirstRender: viewModel.isFirstRender,
              journal: viewModel.journal,
              isLoading: viewModel.isLoading,
              selectedDate: viewModel.selectedDate,
              isSelectedDateInFuture: viewModel.isSelectedDateInFuture,
            ),
            builder: (_, viewModel, _) {
              if (viewModel.isLoading) {
                return SliverToBoxAdapter(
                  child: FadeIn(
                    delay: viewModel.isFirstRender
                        ? DelayMs.medium * 5
                        : DelayMs.medium,
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              if (viewModel.journal.isEmpty) {
                return SliverToBoxAdapter(
                  child: FadeIn(
                    delay: viewModel.isFirstRender
                        ? DelayMs.medium * 5
                        : DelayMs.medium,
                    child: EmptyEntriesBox(
                      isDisabled: viewModel.isSelectedDateInFuture,
                      onPressed: () => context.pushToWriteFromSelectedDate(
                        viewModel.selectedDate,
                      ),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final e = viewModel.journal[index];
                  return FadeIn(
                    delay: viewModel.isFirstRender
                        ? DelayMs.medium * (5 + index)
                        : DelayMs.medium,
                    child: Column(
                      children: [
                        JournalCard(
                          id: e.id,
                          content: e.content ?? '',
                          moodType: e.moodType,
                          coverImg: e.imageUri?.isNotEmpty == true
                              ? e.imageUri!.first
                              : null,
                          createdAt: e.createdAt,
                          onTap: () => context.pushToJournalFromHome(e.id),
                          onDismissed: () =>
                              context.read<HomeViewModel>().deleteJournal(e.id),
                        ),
                        const SizedBox(height: Spacing.xl),
                      ],
                    ),
                  );
                }, childCount: viewModel.journal.length),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: kBottomNavigationBarHeight * 3),
        ),
      ],
    );
  }
}
