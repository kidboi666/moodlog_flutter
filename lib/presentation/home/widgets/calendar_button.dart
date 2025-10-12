import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 40,
      child: FloatingActionButton.small(
        heroTag: 'calendar_button',
        onPressed: () {
          // TODO: Implement calendar view logic
        },
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(178),
        elevation: 2,
        child: const Icon(Icons.calendar_today_outlined),
      ),
    );
  }
}
