import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/ui/widgets/empty_entries_box.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../../../core/ui/widgets/journal_card.dart';
import '../home_view_model.dart';

class JournalSliverList extends StatelessWidget {
  const JournalSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final (
      :isFirstRender,
      :journal,
      :isLoading,
      :selectedDate,
      :isSelectedDateInFuture,
    ) = context.select(
      (HomeViewModel vm) => (
        isFirstRender: vm.isFirstRender,
        journal: vm.journal,
        isLoading: vm.isLoading,
        selectedDate: vm.selectedDate,
        isSelectedDateInFuture: vm.isSelectedDateInFuture,
      ),
    );

    if (isLoading) {
      return SliverToBoxAdapter(
        child: FadeIn(
          delay: isFirstRender ? DelayMS.medium * 5 : DelayMS.medium,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (journal.isEmpty) {
      return SliverToBoxAdapter(
        child: FadeIn(
          delay: isFirstRender ? DelayMS.medium * 5 : DelayMS.medium,
          child: EmptyEntriesBox(
            isDisabled: isSelectedDateInFuture,
            onPressed: () => context.pushToWriteFromSelectedDate(selectedDate),
          ),
        ),
      );
    }

    return SliverList(
      key: ValueKey(selectedDate),
      delegate: SliverChildBuilderDelegate((context, index) {
        final e = journal[index];
        return FadeIn(
          delay: isFirstRender ? DelayMS.medium * (5 + index) : DelayMS.medium,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xl),
            child: JournalCard(
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
          ),
        );
      }, childCount: journal.length),
    );
  }
}
