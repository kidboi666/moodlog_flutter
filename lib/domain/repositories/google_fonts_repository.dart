import 'package:moodlog/domain/entities/font/font_type.dart';

abstract class GoogleFontsRepository {
  Future<List<GoogleFontEntity>> getAllFonts();

  Future<List<GoogleFontEntity>> getFontsBySubset(String subset);

  Future<List<GoogleFontEntity>> searchFonts(String query);

  Future<List<GoogleFontEntity>> getFontsByCategory(String category);
}
