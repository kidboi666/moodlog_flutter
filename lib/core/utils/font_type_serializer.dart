import 'package:moodlog/domain/entities/font/font_type.dart';

class FontTypeSerializer {
  static String serialize(FontType fontType) {
    if (fontType is LocalFont) {
      return 'local:${fontType.key}';
    } else if (fontType is GoogleFontEntity) {
      return 'google:${fontType.family}';
    }
    throw Exception('Unknown FontType: $fontType');
  }

  static FontType deserialize(String? serialized) {
    if (serialized == null || serialized.isEmpty) {
      return LocalFont.pretendard;
    }

    final parts = serialized.split(':');
    if (parts.length != 2) {
      return LocalFont.pretendard;
    }

    final type = parts[0];
    final value = parts[1];

    if (type == 'local') {
      return LocalFont.fromKey(value) ?? LocalFont.pretendard;
    } else if (type == 'google') {
      return GoogleFontEntity(
        family: value,
        category: 'sans-serif',
        subsets: [],
        popularity: 0,
      );
    }

    return LocalFont.pretendard;
  }
}
