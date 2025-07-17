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
      fontFamily: fontFamily.displayName,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _textTheme,
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
      fontFamily: fontFamily.displayName,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      textTheme: _textTheme,
      colorScheme: colorScheme,
    );
  }

  static const _boldFontWeight = FontWeight.bold;

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(fontWeight: _boldFontWeight),
    displayMedium: TextStyle(fontWeight: _boldFontWeight),
    displaySmall: TextStyle(fontWeight: _boldFontWeight),
    headlineLarge: TextStyle(fontWeight: _boldFontWeight),
    headlineMedium: TextStyle(fontWeight: _boldFontWeight),
    headlineSmall: TextStyle(fontWeight: _boldFontWeight),
    titleLarge: TextStyle(fontWeight: _boldFontWeight),
    titleMedium: TextStyle(fontWeight: _boldFontWeight),
    titleSmall: TextStyle(fontWeight: _boldFontWeight),
  );
}
