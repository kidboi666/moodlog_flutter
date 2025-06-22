import 'package:flutter/material.dart';

import '../../../core/extensions/date_time.dart';
import 'home_date_and_day.dart';

enum DateItem { date, day }

class HorizontalCalendar extends StatefulWidget {
  final List<Map<DateItem, String>> dateItems;
  final DateTime selectedDate;
  final Function(DateTime) onSelectedDateChange;

  HorizontalCalendar({
    super.key,
    required this.selectedDate,
    required this.onSelectedDateChange,
  }) : dateItems = List.generate(DateTime.now().lastDateOfMonth, (index) {
         return {
           DateItem.date: '${index + 1}',
           DateItem.day: '월화수목금토일'[index % 7],
         };
       });

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: widget.dateItems
            .map(
              (item) => DateAndDay(
                day: item[DateItem.day] ?? '',
                date: item[DateItem.date] ?? '',
                selectedDate: widget.selectedDate,
                onTap: widget.onSelectedDateChange,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
