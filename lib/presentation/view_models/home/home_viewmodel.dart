import 'package:flutter/cupertino.dart';

import '../../../core/extensions/date_time.dart';

enum DateItem { date, day }

class HomeViewModel extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  final List<Map<DateItem, String>> dateItems = List.generate(
    DateTime.now().lastDateOfMonth,
    (index) {
      return {
        DateItem.date: '${index + 1}',
        DateItem.day: '월화수목금토일'[index % 7],
      };
    },
  );

  void onSelectedDateChange(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
