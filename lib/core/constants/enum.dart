import 'package:flutter/material.dart';

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
}

enum AiPersonality { rational, balanced, compassionate }

enum SimpleTextAlign {
  left(TextAlign.left, Icons.format_align_left),
  center(TextAlign.center, Icons.format_align_center),
  right(TextAlign.right, Icons.format_align_right);

  const SimpleTextAlign(this.textAlign, this.icon);

  final TextAlign textAlign;
  final IconData icon;

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

  String get displayName {
    switch (this) {
      case MoodType.veryHappy:
        return '매우 행복';
      case MoodType.happy:
        return '행복';
      case MoodType.neutral:
        return '보통';
      case MoodType.sad:
        return '슬픔';
      case MoodType.verySad:
        return '매우 슬픔';
    }
  }

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

enum ThemeMode {
  light,
  dark,
  system;

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
}
