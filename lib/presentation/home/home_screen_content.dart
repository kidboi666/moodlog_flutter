part of 'home_screen.dart';

typedef HomeCalendarState = ({DateTime selectedDate, String? nickname});

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Glower(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: SliverToBoxAdapter(
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
          SliverPadding(
            padding: Spacing.containerHorizontalPadding,
            sliver: Builder(
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
                final isSelectedDateInFuture = context
                    .select<HomeViewModel, bool>(
                      (vm) => vm.isSelectedDateInFuture,
                    );

                if (isLoading) {
                  return SliverToBoxAdapter(
                    child: FadeIn(
                      delay: isFirstRender
                          ? DelayMs.medium * 5
                          : DelayMs.medium,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                if (journal.isEmpty) {
                  return SliverToBoxAdapter(
                    child: FadeIn(
                      delay: isFirstRender
                          ? DelayMs.medium * 5
                          : DelayMs.medium,
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
                            onDismissed: () => context
                                .read<HomeViewModel>()
                                .deleteJournal(e.id),
                          ),
                          const SizedBox(height: Spacing.xl),
                        ],
                      ),
                    );
                  }, childCount: journal.length),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight * 3),
          ),
        ],
      ),
    );
  }
}
