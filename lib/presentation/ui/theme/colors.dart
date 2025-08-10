import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';

abstract final class AppColor {
  static final Map<ColorTheme, Color> colorMap = {
    ColorTheme.red: Colors.red,
    ColorTheme.blue: Colors.blue,
    ColorTheme.purple: Colors.purple,
    ColorTheme.green: Colors.green,
    ColorTheme.orange: Colors.orange,
    ColorTheme.indigo: Colors.indigo,
  };
}
