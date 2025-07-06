import 'package:flutter/material.dart' hide ThemeMode;

import '../constants/common.dart';
import '../constants/enum.dart';
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

  String getEmoji(BuildContext context) {
    switch (this) {
      case AiPersonality.rational:
        return Emoji.rational;
      case AiPersonality.balanced:
        return Emoji.balanced;
      case AiPersonality.compassionate:
        return Emoji.compassionate;
    }
  }

  static AiPersonality fromString(String? value) {
    switch (value) {
      case 'balanced':
        return AiPersonality.balanced;
      case 'rational':
        return AiPersonality.rational;
      case 'compassionate':
        return AiPersonality.compassionate;
      default:
        return AiPersonality.balanced;
    }
  }
}

extension LanguageCodeExtension on LanguageCode {
  static LanguageCode fromString(String? value) {
    switch (value) {
      case 'en':
        return LanguageCode.en;
      case 'ko':
        return LanguageCode.ko;
      default:
        return LanguageCode.ko;
    }
  }
}

extension ThemeModeExtension on ThemeMode {
  static ThemeMode fromString(String? value) {
    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String get displayName {
    switch (this) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
