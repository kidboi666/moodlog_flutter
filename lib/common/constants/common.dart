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
  static const imagePickerBoxInnerPadding = EdgeInsets.only(right: 8.0);
  static const calendarScrollSize = 44.0;
  static const aiResponseGap = 26.0;
  static const horCalendarDateHeight = 60.0;
}

abstract final class DelayMs {
  static const lazy = Duration(milliseconds: 1000);
  static const medium = Duration(milliseconds: 500);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
}

abstract final class DurationMs {
  static const debounceMedium = Duration(milliseconds: 4000);
  static const lazy = Duration(milliseconds: 900);
  static const medium = Duration(milliseconds: 600);
  static const quick = Duration(milliseconds: 300);
  static const instant = Duration(milliseconds: 150);
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
  static const textAlign = 'text_align';
  static const lastAiUsageDate = 'last_ai_usage_date';
}

abstract final class DebounceKeys {
  static const aiResponse = 'ai_response';
}
