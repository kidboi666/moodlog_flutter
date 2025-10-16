import 'package:flutter/material.dart' as material;

enum AsyncState { idle, loading, success, error }

enum LanguageCode {
  ko,
  en,
  ja;

  static LanguageCode fromString(String? value) {
    switch (value) {
      case 'en':
        return LanguageCode.en;
      case 'ko':
        return LanguageCode.ko;
      case 'ja':
        return LanguageCode.ja;
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
      case LanguageCode.ja:
        return '日本語';
    }
  }

  String get value {
    switch (this) {
      case LanguageCode.ko:
        return 'ko';
      case LanguageCode.en:
        return 'en';
      case LanguageCode.ja:
        return 'ja';
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
        return Emoji.rational.displayEmoji;
      case AiPersonality.balanced:
        return Emoji.balanced.displayEmoji;
      case AiPersonality.compassionate:
        return Emoji.compassionate.displayEmoji;
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

  String get value {
    switch (this) {
      case SimpleTextAlign.left:
        return 'left';
      case SimpleTextAlign.center:
        return 'center';
      case SimpleTextAlign.right:
        return 'right';
    }
  }

  static SimpleTextAlign fromString(String? value) {
    switch (value) {
      case 'left':
        return SimpleTextAlign.left;
      case 'center':
        return SimpleTextAlign.center;
      case 'right':
        return SimpleTextAlign.right;
      default:
        return SimpleTextAlign.left;
    }
  }
}

enum MoodType {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad;

  String get value {
    return switch (this) {
      MoodType.veryHappy => 'veryHappy',
      MoodType.happy => 'happy',
      MoodType.neutral => 'neutral',
      MoodType.sad => 'sad',
      MoodType.verySad => 'verySad',
    };
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

  material.Color get color => material.Color(colorValue);

  double get sliderValue => switch (this) {
    MoodType.verySad => 0.0,
    MoodType.sad => 1.0,
    MoodType.neutral => 2.0,
    MoodType.happy => 3.0,
    MoodType.veryHappy => 4.0,
  };

  static MoodType fromSlider(num value) {
    return switch (value) {
      0.0 => MoodType.verySad,
      1.0 => MoodType.sad,
      2.0 => MoodType.neutral,
      3.0 => MoodType.happy,
      4.0 => MoodType.veryHappy,
      _ => MoodType.neutral,
    };
  }
}

enum ColorTheme {
  red,
  pink,
  purple,
  deepPurple,
  indigo,
  blue,
  lightBlue,
  cyan,
  teal,
  green,
  lightGreen,
  lime,
  yellow,
  amber,
  orange,
  deepOrange,
  brown,
  grey,
  blueGrey;

  static ColorTheme fromString(String? value) {
    switch (value) {
      case 'red':
        return ColorTheme.red;
      case 'pink':
        return ColorTheme.pink;
      case 'purple':
        return ColorTheme.purple;
      case 'deepPurple':
        return ColorTheme.deepPurple;
      case 'indigo':
        return ColorTheme.indigo;
      case 'blue':
        return ColorTheme.blue;
      case 'lightBlue':
        return ColorTheme.lightBlue;
      case 'cyan':
        return ColorTheme.cyan;
      case 'teal':
        return ColorTheme.teal;
      case 'green':
        return ColorTheme.green;
      case 'lightGreen':
        return ColorTheme.lightGreen;
      case 'lime':
        return ColorTheme.lime;
      case 'yellow':
        return ColorTheme.yellow;
      case 'amber':
        return ColorTheme.amber;
      case 'orange':
        return ColorTheme.orange;
      case 'deepOrange':
        return ColorTheme.deepOrange;
      case 'brown':
        return ColorTheme.brown;
      case 'grey':
        return ColorTheme.grey;
      case 'blueGrey':
        return ColorTheme.blueGrey;
      default:
        return ColorTheme.blue;
    }
  }

  String get value {
    switch (this) {
      case ColorTheme.red:
        return 'red';
      case ColorTheme.pink:
        return 'pink';
      case ColorTheme.purple:
        return 'purple';
      case ColorTheme.deepPurple:
        return 'deepPurple';
      case ColorTheme.indigo:
        return 'indigo';
      case ColorTheme.blue:
        return 'blue';
      case ColorTheme.lightBlue:
        return 'lightBlue';
      case ColorTheme.cyan:
        return 'cyan';
      case ColorTheme.teal:
        return 'teal';
      case ColorTheme.green:
        return 'green';
      case ColorTheme.lightGreen:
        return 'lightGreen';
      case ColorTheme.lime:
        return 'lime';
      case ColorTheme.yellow:
        return 'yellow';
      case ColorTheme.amber:
        return 'amber';
      case ColorTheme.orange:
        return 'orange';
      case ColorTheme.deepOrange:
        return 'deepOrange';
      case ColorTheme.brown:
        return 'brown';
      case ColorTheme.grey:
        return 'grey';
      case ColorTheme.blueGrey:
        return 'blueGrey';
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

enum TimeFormat {
  hour24,
  hour12;

  static TimeFormat fromString(String? value) {
    switch (value) {
      case 'hour24':
        return TimeFormat.hour24;
      case 'hour12':
        return TimeFormat.hour12;
      default:
        return TimeFormat.hour24;
    }
  }

  String get value {
    switch (this) {
      case TimeFormat.hour24:
        return 'hour24';
      case TimeFormat.hour12:
        return 'hour12';
    }
  }
}

enum FontFamily {
  pretendard(isLocal: true),
  leeSeoyun(isLocal: true),
  orbitOfTheMoon(isLocal: true),
  restart(isLocal: true),
  overcome(isLocal: true),
  system(isLocal: true),

  notoSansKR(isLocal: false, googleName: 'Noto Sans KR'),
  notoSerifKR(isLocal: false, googleName: 'Noto Serif KR'),
  blackHanSans(isLocal: false, googleName: 'Black Han Sans'),
  doHyeon(isLocal: false, googleName: 'Do Hyeon'),
  jua(isLocal: false, googleName: 'Jua'),
  roboto(isLocal: false, googleName: 'Roboto'),
  openSans(isLocal: false, googleName: 'Open Sans'),
  lora(isLocal: false, googleName: 'Lora'),
  notoSansJP(isLocal: false, googleName: 'Noto Sans JP');

  const FontFamily({
    required this.isLocal,
    this.googleName,
  });

  final bool isLocal;
  final String? googleName;

  bool get isGoogleFont => !isLocal;

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
      case 'notoSansKR':
        return FontFamily.notoSansKR;
      case 'notoSerifKR':
        return FontFamily.notoSerifKR;
      case 'blackHanSans':
        return FontFamily.blackHanSans;
      case 'doHyeon':
        return FontFamily.doHyeon;
      case 'jua':
        return FontFamily.jua;
      case 'roboto':
        return FontFamily.roboto;
      case 'openSans':
        return FontFamily.openSans;
      case 'lora':
        return FontFamily.lora;
      case 'notoSansJP':
        return FontFamily.notoSansJP;
      default:
        return FontFamily.pretendard;
    }
  }

  String get value {
    if (isLocal) {
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
        default:
          return name;
      }
    }
    return name;
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
      default:
        return null;
    }
  }
}

enum LoginMethod {
  google,
  apple,
  anonymous;

  String get value {
    switch (this) {
      case LoginMethod.google:
        return 'google';
      case LoginMethod.apple:
        return 'apple';
      case LoginMethod.anonymous:
        return 'anonymous';
    }
  }

  static LoginMethod fromString(String? value) {
    switch (value) {
      case 'google':
        return LoginMethod.google;
      case 'apple':
        return LoginMethod.apple;
      case 'anonymous':
        return LoginMethod.anonymous;
      default:
        return LoginMethod.anonymous;
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

enum EntryType {
  quickCheckIn,
  fullJournal;

  String get value {
    switch (this) {
      case EntryType.quickCheckIn:
        return 'quickCheckIn';
      case EntryType.fullJournal:
        return 'fullJournal';
    }
  }

  static EntryType fromString(String? value) {
    switch (value) {
      case 'quickCheckIn':
        return EntryType.quickCheckIn;
      case 'fullJournal':
        return EntryType.fullJournal;
      default:
        return EntryType.fullJournal;
    }
  }
}

enum SpinnerType { button, center, expanded }

enum LockType {
  none,
  pin;

  static LockType fromString(String? value) {
    switch (value) {
      case 'none':
        return LockType.none;
      case 'pin':
        return LockType.pin;
      default:
        return LockType.none;
    }
  }

  String get value {
    switch (this) {
      case LockType.none:
        return 'none';
      case LockType.pin:
        return 'pin';
    }
  }
}

enum Emoji {
  shakeHand,
  pencil,
  rational,
  balanced,
  compassionate;

  String get displayEmoji {
    switch (this) {
      case Emoji.shakeHand:
        return '👋';
      case Emoji.pencil:
        return '✏️';
      case Emoji.rational:
        return '🧠';
      case Emoji.balanced:
        return '⚖️';
      case Emoji.compassionate:
        return '💝';
    }
  }
}
