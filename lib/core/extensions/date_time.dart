import 'package:intl/intl.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

import '../../core/constants/common.dart';

extension DateTimeExtension on DateTime {
  String get monthName => months.values.elementAt(month - 1);

  String get weekdayName => weekDays.values.elementAt(weekday - 1);

  int get lastDateOfMonth => DateTime(year, month + 1, 0).day;

  int get firstDateOfMonth => DateTime(year, month + 1, 1).day;

  String formatted(AppLocalizations localizations) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(year, month, day);

    if (dateOnly == today) {
      return '${localizations.common_date_today} ${DateFormat('HH:mm').format(this)}';
    } else if (dateOnly == today.subtract(Duration(days: 1))) {
      return '${localizations.common_date_yesterday} ${DateFormat('HH:mm').format(this)}';
    } else if (now.year == year) {
      return DateFormat('MM.dd HH:mm').format(this);
    } else {
      return DateFormat('yyyy.MM.dd HH:mm').format(this);
    }
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
}
