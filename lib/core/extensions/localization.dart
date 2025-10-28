import 'package:flutter/material.dart' hide ThemeMode;
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';

extension MoodTypeExtension on MoodType {
  String getDisplayName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case MoodType.veryHappy:
        return t.common_mood_verygood;
      case MoodType.happy:
        return t.common_mood_good;
      case MoodType.neutral:
        return t.common_mood_neutral;
      case MoodType.sad:
        return t.common_mood_bad;
      case MoodType.verySad:
        return t.common_mood_verybad;
    }
  }
}

extension FontFamilyExtension on FontFamily {
  String getDisplayName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case FontFamily.pretendard:
        return t.settings_common_font_family_pretendard;
      case FontFamily.leeSeoyun:
        return t.settings_common_font_family_leeSeoyun;
      case FontFamily.orbitOfTheMoon:
        return t.settings_common_font_family_orbitOfTheMoon;
      case FontFamily.restart:
        return t.settings_common_font_family_restart;
      case FontFamily.overcome:
        return t.settings_common_font_family_overcome;
      case FontFamily.system:
        return t.settings_common_font_family_system;
      case FontFamily.notoSansKR:
        return 'Noto Sans KR';
      case FontFamily.notoSerifKR:
        return 'Noto Serif KR';
      case FontFamily.blackHanSans:
        return 'Black Han Sans';
      case FontFamily.doHyeon:
        return 'Do Hyeon';
      case FontFamily.jua:
        return 'Jua';
      case FontFamily.roboto:
        return 'Roboto';
      case FontFamily.openSans:
        return 'Open Sans';
      case FontFamily.lora:
        return 'Lora';
      case FontFamily.notoSansJP:
        return 'Noto Sans JP';
    }
  }
}

extension ThemeModeExtension on ThemeMode {
  String getDisplayName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case ThemeMode.light:
        return t.settings_common_theme_light;
      case ThemeMode.dark:
        return t.settings_common_theme_dark;
      case ThemeMode.system:
        return t.settings_common_theme_system;
    }
  }
}
