import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/widgets/scale_wrapper.dart';

extension WidgetScaleExtension on Widget {
  Widget scale({
    double scaleValue = 0.90,
    Duration duration = DurationMS.instant,
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
