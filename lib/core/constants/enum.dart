import 'package:flutter/material.dart' as material;

enum LanguageCode {
  ko,
  en;

  String get displayName {
    switch (this) {
      case LanguageCode.ko:
        return '한국어';
      case LanguageCode.en:
        return 'English';
    }
  }

  String get code {
    switch (this) {
      case LanguageCode.ko:
        return 'ko';
      case LanguageCode.en:
        return 'en';
    }
  }
}

enum AiPersonality { rational, balanced, compassionate }

enum SimpleTextAlign {
  left(material.TextAlign.left, material.Icons.format_align_left),
  center(material.TextAlign.center, material.Icons.format_align_center),
  right(material.TextAlign.right, material.Icons.format_align_right);

  const SimpleTextAlign(this.textAlign, this.icon);

  final material.TextAlign textAlign;
  final material.IconData icon;

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
  teal,
  blue,
  purple,
  green,
  orange,
  pink;

  static ColorTheme fromString(String? value) {
    switch (value) {
      case 'teal':
        return ColorTheme.teal;
      case 'blue':
        return ColorTheme.blue;
      case 'purple':
        return ColorTheme.purple;
      case 'green':
        return ColorTheme.green;
      case 'orange':
        return ColorTheme.orange;
      case 'pink':
        return ColorTheme.pink;
      default:
        return ColorTheme.blue;
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
  leeSeoyun;

  String get displayName {
    switch (this) {
      case FontFamily.pretendard:
        return 'Pretendard';
      case FontFamily.leeSeoyun:
        return 'LeeSeoyun';
    }
  }
}
