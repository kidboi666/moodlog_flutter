import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/widgets/scaled_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing_extension.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/routing/routes.dart';
import '../../../domain/entities/journal.dart';
import '../../widgets/avatar.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/journal_card.dart';
import '../../widgets/shake_emoji.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/empty_box.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/welcome_zone.dart';

typedef HomeFeedState = ({
  bool isFirstRender,
  List<Journal> journal,
  bool isLoading,
});

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
              children: [
                Text(t.home_hello, style: textTheme.displayMedium),
                const ShakeEmoji(emoji: Emoji.shakeHand),
              ],
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
        const SliverPadding(
          padding: Spacing.containerHorizontalPadding,
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeZone(),
                SizedBox(height: Spacing.xl),
                HorizontalCalendar(),
                SizedBox(height: Spacing.xl),
              ],
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
                    child: const EmptyBox(),
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScaledElevatedButton(onPressed: () {}, child: Text('asdf')),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: kBottomNavigationBarHeight * 3),
        ),
      ],
    );
  }
}
