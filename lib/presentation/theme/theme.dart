import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodlog/domain/entities/font/font_type.dart';
import 'package:moodlog/presentation/theme/colors.dart';

abstract final class AppTheme {
  static ThemeData lightTheme(FontType fontType) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.lightTheme.primaryColor,
      brightness: Brightness.light,
    );
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainerLowest,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: colorScheme.surfaceContainer,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      fontFamily: fontType is LocalFont ? fontType.fontName : null,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _getTextTheme(fontType),
      colorScheme: AppColors.lightGrayColorScheme,
    );
  }

  static ThemeData darkTheme(FontType fontType) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.darkTheme.primaryColor,
      brightness: Brightness.dark,
    );
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainerLowest,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: colorScheme.surfaceContainer,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      fontFamily: fontType is LocalFont ? fontType.fontName : null,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _getTextTheme(fontType),
      colorScheme: AppColors.darkGrayColorScheme,
    );
  }

  static const _boldFontWeight = FontWeight.bold;

  static TextTheme _getTextTheme(FontType fontType) {
    const baseTheme = TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: _boldFontWeight),
      displayMedium: TextStyle(fontSize: 45, fontWeight: _boldFontWeight),
      displaySmall: TextStyle(fontSize: 36, fontWeight: _boldFontWeight),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: _boldFontWeight),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: _boldFontWeight),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: _boldFontWeight),
      titleLarge: TextStyle(fontSize: 22, fontWeight: _boldFontWeight),
      titleMedium: TextStyle(fontSize: 16, fontWeight: _boldFontWeight),
      titleSmall: TextStyle(fontSize: 14, fontWeight: _boldFontWeight),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
      labelLarge: TextStyle(fontSize: 14, fontWeight: _boldFontWeight),
      labelMedium: TextStyle(fontSize: 12, fontWeight: _boldFontWeight),
      labelSmall: TextStyle(fontSize: 11, fontWeight: _boldFontWeight),
    );

    if (fontType is GoogleFontEntity) {
      try {
        return GoogleFonts.getTextTheme(
          fontType.family,
          baseTheme,
        );
      } catch (e) {
        return baseTheme;
      }
    }

    return baseTheme;
  }
}
