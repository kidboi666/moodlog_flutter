import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

extension DateTimeExtension on DateTime {
  int get lastDateOfMonth => DateTime(year, month + 1, 0).day;

  int get firstDateOfMonth => DateTime(year, month + 1, 1).day;

  String getLocalizedWeekdayName(AppLocalizations localizations) {
    switch (weekday) {
      case DateTime.monday:
        return localizations.common_weekday_mon;
      case DateTime.tuesday:
        return localizations.common_weekday_tue;
      case DateTime.wednesday:
        return localizations.common_weekday_wed;
      case DateTime.thursday:
        return localizations.common_weekday_thu;
      case DateTime.friday:
        return localizations.common_weekday_fri;
      case DateTime.saturday:
        return localizations.common_weekday_sat;
      case DateTime.sunday:
        return localizations.common_weekday_sun;
      default:
        return '';
    }
  }

  String getLocalizedWeekdayShortName(AppLocalizations localizations) {
    switch (weekday) {
      case DateTime.monday:
        return localizations.common_weekday_mon_short;
      case DateTime.tuesday:
        return localizations.common_weekday_tue_short;
      case DateTime.wednesday:
        return localizations.common_weekday_wed_short;
      case DateTime.thursday:
        return localizations.common_weekday_thu_short;
      case DateTime.friday:
        return localizations.common_weekday_fri_short;
      case DateTime.saturday:
        return localizations.common_weekday_sat_short;
      case DateTime.sunday:
        return localizations.common_weekday_sun_short;
      default:
        return '';
    }
  }

  String getLocalizedMonthName(AppLocalizations localizations) {
    switch (month) {
      case 1:
        return localizations.common_month_jan;
      case 2:
        return localizations.common_month_feb;
      case 3:
        return localizations.common_month_mar;
      case 4:
        return localizations.common_month_apr;
      case 5:
        return localizations.common_month_may;
      case 6:
        return localizations.common_month_jun;
      case 7:
        return localizations.common_month_jul;
      case 8:
        return localizations.common_month_aug;
      case 9:
        return localizations.common_month_sep;
      case 10:
        return localizations.common_month_oct;
      case 11:
        return localizations.common_month_nov;
      case 12:
        return localizations.common_month_dec;
      default:
        return '';
    }
  }

  bool isSameDay(DateTime otherDate) {
    return year == otherDate.year &&
        month == otherDate.month &&
        day == otherDate.day;
  }

  bool isSameMonth(DateTime otherDate) {
    return year == otherDate.year && month == otherDate.month;
  }

  bool isSameYear(DateTime otherDate) {
    return year == otherDate.year;
  }

  String formatted(AppLocalizations t) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(year, month, day);

    if (dateOnly == today) {
      return '${t.common_date_today} ${DateFormat('HH:mm').format(this)}';
    } else if (dateOnly == today.subtract(Duration(days: 1))) {
      return '${t.common_date_yesterday} ${DateFormat('HH:mm').format(this)}';
    } else if (now.year == year) {
      return DateFormat('MM.dd HH:mm').format(this);
    } else {
      return DateFormat('yyyy.MM.dd HH:mm').format(this);
    }
  }

  String formattedLocalizedFullDate(AppLocalizations t) {
    return DateFormat(t.common_date_full).format(this);
  }

  String formattedDotNation() {
    return DateFormat('yyyy.MM.dd').format(this);
  }

  String formattedDotNationWithTime() {
    return DateFormat('yyyy.MM.dd HH:mm').format(this);
  }

  String formattedDotNationWithMonth() {
    return DateFormat('yyyy.MM').format(this);
  }

  String formattedTime(TimeFormat timeFormat) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(year, month, day);

    final timePattern = timeFormat == TimeFormat.hour24 ? 'HH:mm' : 'hh:mm a';

    if (dateOnly == today) {
      return DateFormat(timePattern).format(this);
    } else if (dateOnly == today.subtract(Duration(days: 1))) {
      return DateFormat(timePattern).format(this);
    } else if (now.year == year) {
      return DateFormat('MM.dd $timePattern').format(this);
    } else {
      return DateFormat('yyyy.MM.dd $timePattern').format(this);
    }
  }
}
