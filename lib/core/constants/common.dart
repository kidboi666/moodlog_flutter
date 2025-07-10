import 'dart:io';

import 'package:flutter/painting.dart';

abstract final class Spacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;

  static const EdgeInsetsGeometry containerHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsetsGeometry paddingVertical = EdgeInsets.symmetric(
    vertical: 16.0,
  );
  static const EdgeInsetsGeometry containerMarginTop = EdgeInsets.only(
    top: 28.0,
  );
  static const EdgeInsetsGeometry containerPaddingTop = EdgeInsets.only(
    top: 80.0,
  );
  static const EdgeInsetsGeometry containerPaddingBottom = EdgeInsets.only(
    bottom: 180.0,
  );
  static const EdgeInsetsGeometry headerVerticalPadding = EdgeInsets.symmetric(
    vertical: 12.0,
  );
  static const double bottomNavigationBarHeight = 80.0;
  static const double calendarScrollSize = 44.0;
  static const double aiResponseGap = 26.0;
  static const double horCalendarDateHeight = 60.0;

  static double get tabBarHeight => Platform.isIOS ? 60.0 : 80.0;

  static double get keyboardVerticalOffset => Platform.isIOS ? 140.0 : 0.0;
}

abstract final class SnapPoint {
  static const double delete = 0.3;
  static const double journalWrite = 0.7;
  static const double logout = 0.3;
  static const double auth = 0.6;
}

const Map<String, String> weekDays = {
  'mon': 'Mon',
  'tue': 'Tue',
  'wed': 'Wed',
  'thu': 'Thu',
  'fri': 'Fri',
  'sat': 'Sat',
  'sun': 'Sun',
};

const Map<String, String> months = {
  'jan': 'Jan',
  'feb': 'Feb',
  'mar': 'Mar',
  'apr': 'Apr',
  'may': 'May',
  'jun': 'Jun',
  'jul': 'Jul',
  'aug': 'Aug',
  'sep': 'Sep',
  'oct': 'Oct',
  'nov': 'Nov',
  'dec': 'Dec',
};

abstract final class DelayMs {
  static const lazy = Duration(milliseconds: 1000);
  static const medium = Duration(milliseconds: 500);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
}

abstract final class DurationMs {
  static const lazy = Duration(milliseconds: 1000);
  static const medium = Duration(milliseconds: 500);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
}

abstract final class Emoji {
  static const shakeHand = '👋';
  static const pencil = '✏️';
  static const rational = '🧠';
  static const balanced = '⚖️';
  static const compassionate = '💝';
}

abstract final class PreferenceKeys {
  static const isFirstLaunch = 'is_first_launch';
  static const themeMode = 'theme_mode';
  static const languageCode = 'language_code';
  static const lastActiveDate = 'last_active_date';
  static const firstLaunchedDate = 'first_launched_date';
  static const nickname = 'nick_name';
  static const aiPersonality = 'ai_personality';
  static const hasNotificationEnabled = 'has_notification_enabled';
  static const hasAutoSyncEnabled = 'has_auto_sync_enabled';
  static const colorTheme = 'color_theme';
  static const fontFamily = 'font_family';
}
