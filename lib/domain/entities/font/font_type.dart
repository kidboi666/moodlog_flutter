sealed class FontType {
  const FontType();

  String get displayName;
  String get fontName;

  bool get isLocal => this is LocalFont;
  bool get isGoogle => this is GoogleFontEntity;
}

class LocalFont extends FontType {
  final String _key;
  final String _flutterFontFamily;
  final String _displayName;
  final double? fixedFontSize;

  const LocalFont({
    required String key,
    required String flutterFontFamily,
    required String displayName,
    this.fixedFontSize,
  })  : _key = key,
        _flutterFontFamily = flutterFontFamily,
        _displayName = displayName;

  String get key => _key;

  @override
  String get displayName => _displayName;

  @override
  String get fontName => _flutterFontFamily;

  static const pretendard = LocalFont(
    key: 'pretendard',
    flutterFontFamily: 'Pretendard',
    displayName: 'Pretendard',
  );

  static const List<LocalFont> values = [
    pretendard,
  ];

  static LocalFont? fromKey(String? key) {
    if (key == null) return null;
    try {
      return values.firstWhere((font) => font.key == key);
    } catch (e) {
      return null;
    }
  }
}

class GoogleFontEntity extends FontType {
  final String family;
  final String category;
  final List<String> subsets;
  final int popularity;

  const GoogleFontEntity({
    required this.family,
    required this.category,
    required this.subsets,
    required this.popularity,
  });

  @override
  String get displayName => family;

  @override
  String get fontName => family;

  bool get supportsKorean => subsets.contains('korean');
  bool get supportsJapanese => subsets.contains('japanese');
  bool get supportsLatin => subsets.contains('latin');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GoogleFontEntity && other.family == family;
  }

  @override
  int get hashCode => family.hashCode;
}
