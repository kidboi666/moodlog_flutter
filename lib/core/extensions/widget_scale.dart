import 'package:flutter/material.dart';

import '../../core/constants/common.dart';
import '../../presentation/ui/widgets/scale_wrapper.dart';

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
