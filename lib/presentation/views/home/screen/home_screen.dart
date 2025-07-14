import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/routes.dart';
import '../../../../domain/entities/journal.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/journal_card.dart';
import '../../../widgets/shake_emoji.dart';
import '../widgets/empty_box.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: FadeIn(
            delay: DelayMs.medium,
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.home_hello,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const ShakeEmoji(emoji: Emoji.shakeHand),
              ],
            ),
          ),
          actionsPadding: Spacing.containerHorizontalPadding,
          actions: [
            IconButton.filledTonal(
              onPressed: () => context.push(Routes.profile),
              icon: Icon(Icons.person),
            ),
          ],
        ),
        SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeZone(),
                const SizedBox(height: Spacing.xl),
                HorizontalCalendar(),
                const SizedBox(height: Spacing.xl),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver:
              Selector<
                HomeViewModel,
                ({bool isFirstRender, List<Journal> journal, bool isLoading})
              >(
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
                        child: EmptyBox(),
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
                        ),
                      );
                    }, childCount: viewModel.journal.length),
                  );
                },
              ),
        ),
        SliverToBoxAdapter(
          child: const SizedBox(height: kBottomNavigationBarHeight),
        ),
      ],
    );
  }
}
