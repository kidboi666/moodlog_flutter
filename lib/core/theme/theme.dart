import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/enum.dart';
import 'colors.dart';

abstract final class AppTheme {
  static ThemeData lightTheme(ColorTheme colorTheme, FontFamily fontFamily) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColor.colorMap[colorTheme]!,
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
      fontFamily: fontFamily.value,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _getTextTheme(fontFamily),
      colorScheme: colorScheme,
    );
  }

  static ThemeData darkTheme(ColorTheme colorTheme, FontFamily fontFamily) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColor.colorMap[colorTheme]!,
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
      fontFamily: fontFamily.value,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _getTextTheme(fontFamily),
      colorScheme: colorScheme,
    );
  }

  static const _boldFontWeight = FontWeight.bold;

  static TextTheme _getTextTheme(FontFamily fontFamily) {
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

    if (fontFamily == FontFamily.orbitOfTheMoon) {
      return baseTheme.apply(fontSizeFactor: 1.2);
    }

    if (fontFamily == FontFamily.restart) {
      return baseTheme.apply(fontSizeFactor: 1.2);
    }

    if (fontFamily == FontFamily.overcome) {
      return baseTheme.apply(fontSizeFactor: 1.2);
    }

    return baseTheme;
  }
}
