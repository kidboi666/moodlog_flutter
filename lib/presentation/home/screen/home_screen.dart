import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../domain/entities/journal.dart';
import '../../widgets/avatar.dart';
import '../../widgets/empty_entries_box.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/journal_card.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

typedef HomeFeedState = ({
  bool isFirstRender,
  List<Journal> journal,
  bool isLoading,
});

typedef HomeCalendarState = ({DateTime selectedDate, String? nickname});

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),
        SliverAppBar(
          title: FadeIn(
            delay: DelayMs.medium,
            child: Row(
              children: [Text(t.home_hello, style: textTheme.displaySmall)],
            ),
          ),
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
                    child: const EmptyEntriesBox(),
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
                    child: JournalCard(
                      id: e.id,
                      content: e.content ?? '',
                      moodType: e.moodType,
                      createdAt: e.createdAt,
                      onTap: () => context.pushToJournalFromHome(e.id),
                      onDismissed: () =>
                          context.read<HomeViewModel>().deleteJournal(e.id),
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
