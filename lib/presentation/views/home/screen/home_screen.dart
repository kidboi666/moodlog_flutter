import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/common.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/routes.dart';
import '../../../view_models/home/home_viewmodel.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/journal_card.dart';
import '../../../widgets/shake_emoji.dart';
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
    return Scaffold(
      appBar: AppBar(
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
      body: ListenableBuilder(
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
      ),
    );
  }
}
