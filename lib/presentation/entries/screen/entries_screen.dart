import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/routing_extension.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../domain/entities/journal.dart';
import '../../widgets/fade_in.dart';
import '../../widgets/journal_card.dart';
import '../viewmodel/entries_viewmodel.dart';

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
            icon: Icon(Icons.arrow_back),
            onPressed: () => setPreviousMonth(),
          ),
        ),
        actions: [
          Selector<EntriesViewModel, Function>(
            selector: (_, viewModel) => viewModel.setNextMonth,
            builder: (_, setNextMonth, _) => IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => setNextMonth(),
            ),
          ),
        ],
      ),
      body: Container(
        padding: Spacing.containerHorizontalPadding,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const SizedBox(height: Spacing.xl)),
            Selector<EntriesViewModel, List<Journal>>(
              selector: (_, viewModel) => viewModel.entries,
              builder: (_, entries, _) => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final e = entries[index];
                  return FadeIn(
                    delay: DelayMs.medium,
                    child: JournalCard(
                      id: e.id,
                      content: e.content ?? '',
                      moodType: e.moodType,
                      createdAt: e.createdAt,
                      onTap: () => context.pushToJournalFromEntries(e.id),
                    ),
                  );
                }, childCount: entries.length),
              ),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: kBottomNavigationBarHeight),
            ),
          ],
        ),
      ),
    );
  }
}
