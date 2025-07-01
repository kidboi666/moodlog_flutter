import 'package:flutter/material.dart';

import '../constants/enum.dart';
import 'colors.dart';

abstract final class AppTheme {
  static ThemeData lightTheme(ColorTheme colorTheme) => ThemeData(
    fontFamily: 'LeeSeoyun',
    brightness: Brightness.light,
    textTheme: _textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.colorMap[colorTheme]!,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme(ColorTheme colorTheme) => ThemeData(
    fontFamily: 'LeeSeoyun',
    brightness: Brightness.dark,
    textTheme: _textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.colorMap[colorTheme]!,
      brightness: Brightness.dark,
    ),
  );

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
