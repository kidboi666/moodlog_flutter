import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';

abstract final class AppColor {
  static final Map<ColorTheme, Color> colorMap = {
    ColorTheme.red: Colors.red,
    ColorTheme.pink: Colors.pink,
    ColorTheme.purple: Colors.purple,
    ColorTheme.deepPurple: Colors.deepPurple,
    ColorTheme.indigo: Colors.indigo,
    ColorTheme.blue: Colors.blue,
    ColorTheme.lightBlue: Colors.lightBlue,
    ColorTheme.cyan: Colors.cyan,
    ColorTheme.teal: Colors.teal,
    ColorTheme.green: Colors.green,
    ColorTheme.lightGreen: Colors.lightGreen,
    ColorTheme.lime: Colors.lime,
    ColorTheme.yellow: Colors.yellow,
    ColorTheme.amber: Colors.amber,
    ColorTheme.orange: Colors.orange,
    ColorTheme.deepOrange: Colors.deepOrange,
    ColorTheme.brown: Colors.brown,
    ColorTheme.grey: Colors.grey,
    ColorTheme.blueGrey: Colors.blueGrey,
  };
}
