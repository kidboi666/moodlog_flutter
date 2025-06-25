import '../../core/constants/common.dart';

extension DateTimeExtension on DateTime {
  String get monthName => months.values.elementAt(month - 1);

  String get weekdayName => weekDays.values.elementAt(weekday - 1);

  int get lastDateOfMonth => DateTime(year, month + 1, 0).day;

  int get firstDateOfMonth => DateTime(year, month + 1, 1).day;
}
