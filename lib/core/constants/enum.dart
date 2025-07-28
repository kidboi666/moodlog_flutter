import 'package:flutter/material.dart' as material;

import 'common.dart';

enum LanguageCode {
  ko,
  en;

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

  String get displayName {
    switch (this) {
      case LanguageCode.ko:
        return '한국어';
      case LanguageCode.en:
        return 'English';
    }
  }

  String get value {
    switch (this) {
      case LanguageCode.ko:
        return 'ko';
      case LanguageCode.en:
        return 'en';
    }
  }
}

enum AiPersonality {
  rational,
  balanced,
  compassionate;

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

  String get emoji {
    switch (this) {
      case AiPersonality.rational:
        return Emoji.rational;
      case AiPersonality.balanced:
        return Emoji.balanced;
      case AiPersonality.compassionate:
        return Emoji.compassionate;
    }
  }

  String get value {
    switch (this) {
      case AiPersonality.rational:
        return 'rational';
      case AiPersonality.balanced:
        return 'balanced';
      case AiPersonality.compassionate:
        return 'compassionate';
    }
  }
}

enum SimpleTextAlign {
  left(
    material.TextAlign.left,
    material.Icons.format_align_left,
    material.MainAxisAlignment.start,
    material.CrossAxisAlignment.start,
  ),
  center(
    material.TextAlign.center,
    material.Icons.format_align_center,
    material.MainAxisAlignment.center,
    material.CrossAxisAlignment.center,
  ),
  right(
    material.TextAlign.right,
    material.Icons.format_align_right,
    material.MainAxisAlignment.end,
    material.CrossAxisAlignment.end,
  );

  const SimpleTextAlign(
    this.textAlign,
    this.icon,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  );

  final material.TextAlign textAlign;
  final material.IconData icon;
  final material.MainAxisAlignment mainAxisAlignment;
  final material.CrossAxisAlignment crossAxisAlignment;

  SimpleTextAlign get next {
    final currentIndex = SimpleTextAlign.values.indexOf(this);
    final nextIndex = (currentIndex + 1) % SimpleTextAlign.values.length;
    return SimpleTextAlign.values[nextIndex];
  }
}

enum MoodType {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad;

  String get emoji {
    switch (this) {
      case MoodType.veryHappy:
        return '😄';
      case MoodType.happy:
        return '😊';
      case MoodType.neutral:
        return '😐';
      case MoodType.sad:
        return '😢';
      case MoodType.verySad:
        return '😭';
    }
  }

  int get score {
    switch (this) {
      case MoodType.veryHappy:
        return 5;
      case MoodType.happy:
        return 4;
      case MoodType.neutral:
        return 3;
      case MoodType.sad:
        return 2;
      case MoodType.verySad:
        return 1;
    }
  }

  int get colorValue {
    switch (this) {
      case MoodType.veryHappy:
        return 0xFF4CAF50;
      case MoodType.happy:
        return 0xFF8BC34A;
      case MoodType.neutral:
        return 0xFFFFEB3B;
      case MoodType.sad:
        return 0xFFFF9800;
      case MoodType.verySad:
        return 0xFFF44336;
    }
  }
}

enum ColorTheme {
  blue,
  indigo,
  red,
  purple,
  green,
  orange;

  static ColorTheme fromString(String? value) {
    switch (value) {
      case 'red':
        return ColorTheme.red;
      case 'blue':
        return ColorTheme.blue;
      case 'purple':
        return ColorTheme.purple;
      case 'green':
        return ColorTheme.green;
      case 'orange':
        return ColorTheme.orange;
      case 'indigo':
        return ColorTheme.indigo;
      default:
        return ColorTheme.blue;
    }
  }

  String get value {
    switch (this) {
      case ColorTheme.red:
        return 'red';
      case ColorTheme.blue:
        return 'blue';
      case ColorTheme.purple:
        return 'purple';
      case ColorTheme.green:
        return 'green';
      case ColorTheme.orange:
        return 'orange';
      case ColorTheme.indigo:
        return 'indigo';
    }
  }
}

enum ThemeMode {
  light,
  dark,
  system;

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

  String get value {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  material.ThemeMode get materialThemeMode {
    switch (this) {
      case ThemeMode.light:
        return material.ThemeMode.light;
      case ThemeMode.dark:
        return material.ThemeMode.dark;
      case ThemeMode.system:
        return material.ThemeMode.system;
    }
  }
}

enum FontFamily {
  pretendard,
  leeSeoyun,
  orbitOfTheMoon,
  restart,
  overcome,
  system;

  static FontFamily fromString(String? value) {
    switch (value) {
      case 'pretendard':
        return FontFamily.pretendard;
      case 'leeSeoyun':
        return FontFamily.leeSeoyun;
      case 'orbitOfTheMoon':
        return FontFamily.orbitOfTheMoon;
      case 'restart':
        return FontFamily.restart;
      case 'overcome':
        return FontFamily.overcome;
      case 'system':
        return FontFamily.system;
      default:
        return FontFamily.pretendard;
    }
  }

  String get value {
    switch (this) {
      case FontFamily.pretendard:
        return 'pretendard';
      case FontFamily.leeSeoyun:
        return 'leeSeoyun';
      case FontFamily.orbitOfTheMoon:
        return 'orbitOfTheMoon';
      case FontFamily.restart:
        return 'restart';
      case FontFamily.overcome:
        return 'overcome';
      case FontFamily.system:
        return 'system';
    }
  }

  double? get fixedFontSize {
    switch (this) {
      case FontFamily.leeSeoyun:
        return 16.0;
      case FontFamily.orbitOfTheMoon:
        return 15.0;
      case FontFamily.restart:
        return 15.0;
      case FontFamily.pretendard:
        return 16.0;
      case FontFamily.overcome:
        return 16.0;
      case FontFamily.system:
        return 16.0;
    }
  }
}

enum LoginType {
  google,
  kakao,
  anonymous;

  String get value {
    switch (this) {
      case LoginType.google:
        return 'google';
      case LoginType.kakao:
        return 'kakao';
      case LoginType.anonymous:
        return 'anonymous';
    }
  }

  static LoginType fromString(String? value) {
    switch (value) {
      case 'google':
        return LoginType.google;
      case 'kakao':
        return LoginType.kakao;
      case 'anonymous':
        return LoginType.anonymous;
      default:
        return LoginType.anonymous;
    }
  }
}

enum SignInSource { profile, first }

enum JournalSource {
  home,
  write,
  entries;

  String get value {
    switch (this) {
      case JournalSource.home:
        return 'home';
      case JournalSource.write:
        return 'write';
      case JournalSource.entries:
        return 'entries';
    }
  }
}

enum SpinnerType { button, screen, element }
