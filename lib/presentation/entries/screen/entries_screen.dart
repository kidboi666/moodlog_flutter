import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/extensions/routing.dart';
import '../../../domain/entities/journal.dart';
import '../../core/widgets/empty_entries_box.dart';
import '../../core/widgets/fade_in.dart';
import '../../core/widgets/journal_card.dart';
import '../viewmodel/entries_viewmodel.dart';
import '../widgets/entries_calendar_view.dart';
import '../widgets/tag_filter_section.dart';

typedef EntriesSelectorType = ({
  bool isLoading,
  List<Journal> entries,
  EntriesViewMode viewMode,
});

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Selector<EntriesViewModel, DateTime>(
          selector: (_, viewModel) => viewModel.selectedMonth,
          builder: (_, selectedMonth, _) =>
              Text(selectedMonth.formattedDotNationWithMonth()),
        ),
        leading: Selector<EntriesViewModel, Function>(
          selector: (_, viewModel) => viewModel.setPreviousMonth,
          builder: (_, setPreviousMonth, _) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setPreviousMonth(),
          ),
        ),
        actions: [
          Selector<EntriesViewModel, EntriesViewMode>(
            selector: (_, viewModel) => viewModel.viewMode,
            builder: (_, viewMode, _) => IconButton(
              icon: Icon(
                viewMode == EntriesViewMode.list
                    ? Icons.calendar_month
                    : Icons.view_list,
              ),
              onPressed: () =>
                  context.read<EntriesViewModel>().toggleViewMode(),
            ),
          ),
          Selector<EntriesViewModel, Function>(
            selector: (_, viewModel) => viewModel.setNextMonth,
            builder: (_, setNextMonth, _) => IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => setNextMonth(),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),
          const SliverToBoxAdapter(child: TagFilterSection()),
          const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),
          Selector<EntriesViewModel, EntriesSelectorType>(
            selector: (_, viewModel) => (
              entries: viewModel.entries,
              isLoading: viewModel.isLoading,
              viewMode: viewModel.viewMode,
            ),
            builder: (_, viewModel, _) {
              if (viewModel.isLoading) {
                return SliverToBoxAdapter(
                  child: const CircularProgressIndicator(),
                );
              }

              if (viewModel.viewMode == EntriesViewMode.calendar) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: Spacing.containerHorizontalPadding,
                    child: EntriesCalendarView(),
                  ),
                );
              }

              if (viewModel.entries.isEmpty) {
                return SliverToBoxAdapter(
                  child: FadeIn(
                    delay: DelayMs.medium,
                    child: Padding(
                      padding: Spacing.containerHorizontalPadding,
                      child: EmptyEntriesBox(),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final e = viewModel.entries[index];
                  return Padding(
                    padding: Spacing.containerHorizontalPadding,
                    child: FadeIn(
                      delay: DelayMs.medium,
                      child: Column(
                        children: [
                          JournalCard(
                            id: e.id,
                            content: e.content ?? '',
                            moodType: e.moodType,
                            createdAt: e.createdAt,
                            onTap: () => context.pushToJournalFromEntries(e.id),
                            onDismissed: () => context
                                .read<EntriesViewModel>()
                                .deleteJournal(e.id),
                          ),
                          const SizedBox(height: Spacing.xl),
                        ],
                      ),
                    ),
                  );
                }, childCount: viewModel.entries.length),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight * 3),
          ),
        ],
      ),
    );
  }
}
