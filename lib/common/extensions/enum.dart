import 'package:flutter/material.dart' hide ThemeMode;

import '../../common/constants/enum.dart';
import '../l10n/app_localizations.dart';

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

extension AiPersonalityExtension on AiPersonality {
  String getTitle(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case AiPersonality.rational:
        return t.onboarding_personality_rational_title;
      case AiPersonality.balanced:
        return t.onboarding_personality_balanced_title;
      case AiPersonality.compassionate:
        return t.onboarding_personality_compassionate_title;
    }
  }

  String getDescription(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (this) {
      case AiPersonality.rational:
        return t.onboarding_personality_rational_description;
      case AiPersonality.balanced:
        return t.onboarding_personality_balanced_description;
      case AiPersonality.compassionate:
        return t.onboarding_personality_compassionate_description;
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
