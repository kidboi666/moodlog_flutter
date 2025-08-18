part of 'entries_screen.dart';

typedef EntriesSelectorType = ({
  bool isLoading,
  List<Journal> entries,
  EntriesViewMode viewMode,
});

class _EntriesScreenContent extends StatelessWidget {
  // 날짜별로 저널 그룹화
  Map<DateTime, List<Journal>> _groupJournalsByDate(List<Journal> journals) {
    final Map<DateTime, List<Journal>> groupedJournals = {};

    for (final journal in journals) {
      final date = DateTime(
        journal.createdAt.year,
        journal.createdAt.month,
        journal.createdAt.day,
      );

      if (groupedJournals[date] == null) {
        groupedJournals[date] = [];
      }
      groupedJournals[date]!.add(journal);
    }

    return groupedJournals;
  }

  // 요일과 날짜 포맷팅
  String _formatDateWithWeekday(DateTime date, AppLocalizations t) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return '${t.common_date_today} (${date.getLocalizedWeekdayShortName(t)})';
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return '${t.common_date_yesterday} (${date.getLocalizedWeekdayShortName(t)})';
    } else {
      return '${date.day}${t.common_unit_day} (${date.getLocalizedWeekdayShortName(t)})';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EntriesViewModel>();

    return Glower(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Builder(
            builder: (context) {
              final selectedMonth = context.select<EntriesViewModel, DateTime>(
                (vm) => vm.selectedMonth,
              );
              return Text(selectedMonth.formattedDotNationWithMonth());
            },
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.setPreviousMonth,
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
                onPressed: viewModel.toggleViewMode,
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
            Builder(
              builder: (context) {
                final entries = context.select<EntriesViewModel, List<Journal>>(
                  (vm) => vm.entries,
                );
                final isLoading = context.select<EntriesViewModel, bool>(
                  (vm) => vm.isLoading,
                );
                final viewMode = context
                    .select<EntriesViewModel, EntriesViewMode>(
                      (vm) => vm.viewMode,
                    );

                if (isLoading) {
                  return SliverToBoxAdapter(
                    child: const CircularProgressIndicator(),
                  );
                }

                if (viewMode == EntriesViewMode.calendar) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: Spacing.containerHorizontalPadding,
                      child: EntriesCalendarView(),
                    ),
                  );
                }

                if (entries.isEmpty) {
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

                // 날짜별 그룹화된 저널 표시
                final groupedJournals = _groupJournalsByDate(entries);
                final sortedDates = groupedJournals.keys.toList()
                  ..sort((a, b) => b.compareTo(a)); // 최신 날짜부터

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final date = sortedDates[index];
                    final journalsForDate = groupedJournals[date]!;
                    final t = AppLocalizations.of(context)!;
                    final colorScheme = Theme.of(context).colorScheme;
                    final textTheme = Theme.of(context).textTheme;

                    return Padding(
                      padding: Spacing.containerHorizontalPadding,
                      child: FadeIn(
                        delay:
                            DelayMs.medium + Duration(milliseconds: index * 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 날짜 헤더
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Spacing.sm,
                                vertical: Spacing.xs,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _formatDateWithWeekday(date, t),
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${journalsForDate.length}',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.outline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Spacing.lg),

                            // 해당 날짜의 저널들
                            ...journalsForDate.asMap().entries.map((entry) {
                              final journalIndex = entry.key;
                              final journal = entry.value;

                              return Column(
                                children: [
                                  JournalCard(
                                    id: journal.id,
                                    content: journal.content ?? '',
                                    moodType: journal.moodType,
                                    coverImg:
                                        journal.imageUri?.isNotEmpty == true
                                        ? journal.imageUri!.first
                                        : null,
                                    createdAt: journal.createdAt,
                                    onTap: () => context
                                        .pushToJournalFromEntries(journal.id),
                                    onDismissed: () =>
                                        viewModel.deleteJournal(journal.id),
                                  ),
                                  if (journalIndex < journalsForDate.length - 1)
                                    const SizedBox(height: Spacing.lg),
                                ],
                              );
                            }),
                            const SizedBox(height: Spacing.xxl),
                          ],
                        ),
                      ),
                    );
                  }, childCount: sortedDates.length),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight * 3),
            ),
          ],
        ),
      ),
    );
  }
}
