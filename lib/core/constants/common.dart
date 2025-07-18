import 'dart:io';

import 'package:flutter/painting.dart';

abstract final class Spacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;

  static const containerHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );
  static const paddingVertical = EdgeInsets.symmetric(vertical: 16.0);
  static const containerMarginTop = EdgeInsets.only(top: 28.0);
  static const containerPaddingTop = EdgeInsets.only(top: 80.0);
  static const containerPaddingBottom = EdgeInsets.only(bottom: 180.0);
  static const headerVerticalPadding = EdgeInsets.symmetric(vertical: 12.0);
  static const calendarScrollSize = 44.0;
  static const aiResponseGap = 26.0;
  static const horCalendarDateHeight = 60.0;

  static get tabBarHeight => Platform.isIOS ? 60.0 : 80.0;

  static get keyboardVerticalOffset => Platform.isIOS ? 140.0 : 0.0;
}

abstract final class SnapPoint {
  static const delete = 0.3;
  static const journalWrite = 0.7;
  static const logout = 0.3;
  static const auth = 0.6;
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
  static const themeMode = 'theme_mode';
  static const languageCode = 'language_code';
  static const nickname = 'nick_name';
  static const onboardingCompleted = 'onboarding_completed';
  static const aiPersonality = 'ai_personality';
  static const hasNotificationEnabled = 'has_notification_enabled';
  static const hasAutoSyncEnabled = 'has_auto_sync_enabled';
  static const colorTheme = 'color_theme';
  static const fontFamily = 'font_family';
}
