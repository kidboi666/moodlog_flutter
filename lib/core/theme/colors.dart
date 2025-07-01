import 'package:flutter/material.dart';

import '../constants/enum.dart';

abstract final class AppColor {
  static final Map<ColorTheme, Color> colorMap = {
    ColorTheme.teal: Colors.teal,
    ColorTheme.blue: Colors.blue,
    ColorTheme.purple: Colors.purple,
    ColorTheme.green: Colors.green,
    ColorTheme.orange: Colors.orange,
    ColorTheme.pink: Colors.pink,
  };
}
