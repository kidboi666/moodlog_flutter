import 'package:flutter/material.dart';

import '../../widgets/screen_view.dart';
import 'home_calendar_box.dart';
import 'home_welcome_zone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  void onSelectedDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeZone(),
          CalendarBox(
            selectedDate: _selectedDate,
            onSelectedDateChange: onSelectedDateChange,
          ),
          // ListView(
          //   children: [
          // JournalCard(
          //   content: 'adsasdfdfasdfsdff',
          //   moodColor: Colors.orange,
          //   createdAt: DateTime.now(),
          // ),
          // JournalCard(
          //   content: 'adsasdfdfasdfsdfddf',
          //   moodColor: Colors.orange,
          //   createdAt: DateTime.now(),
          // ),
          // ],
          // ),
        ],
      ),
    );
  }
}
