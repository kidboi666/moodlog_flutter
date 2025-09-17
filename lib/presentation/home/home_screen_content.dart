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
            sliver: JournalSliverList(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight * 3),
          ),
        ],
      ),
    );
  }
}
