import 'package:flutter/material.dart';

import '../../presentation/widgets/scaled_button.dart';
import '../constants/common.dart';

extension WidgetScaleExtension on Widget {
  Widget scale({
    double scaleValue = 0.90,
    Duration duration = DurationMs.instant,
    Curve curve = Curves.easeInOut,
  }) {
    return ScaleWrapper(
      scaleValue: scaleValue,
      duration: duration,
      curve: curve,
      child: this,
    );
  }
}
