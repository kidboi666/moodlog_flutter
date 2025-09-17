import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/extensions/routing.dart';
import '../../../core/ui/widgets/empty_entries_box.dart';
import '../../../core/ui/widgets/fade_in.dart';
import '../../../core/ui/widgets/journal_card.dart';
import '../../../domain/entities/journal/journal.dart';
import '../home_viewmodel.dart';

class JournalSliverList extends StatelessWidget {
  const JournalSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isFirstRender = context.select<HomeViewModel, bool>(
          (vm) => vm.isFirstRender,
        );
        final journal = context.select<HomeViewModel, List<Journal>>(
          (vm) => vm.journal,
        );
        final isLoading = context.select<HomeViewModel, bool>(
          (vm) => vm.isLoading,
        );
        final selectedDate = context.select<HomeViewModel, DateTime>(
          (vm) => vm.selectedDate,
        );
        final isSelectedDateInFuture = context.select<HomeViewModel, bool>(
          (vm) => vm.isSelectedDateInFuture,
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
                onPressed: () =>
                    context.pushToWriteFromSelectedDate(selectedDate),
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final e = journal[index];
            return FadeIn(
              delay: isFirstRender
                  ? DelayMS.medium * (5 + index)
                  : DelayMS.medium,
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
          }, childCount: journal.length),
        );
      },
    );
  }
}
