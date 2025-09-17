import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import 'hello.dart';
import 'weather_widget.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  @override
  void initState() {
    super.initState();
    Future.delayed(DelayMS.lazy * 3, () {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Hello(),
      secondChild: WeatherWidget(),
      crossFadeState: crossFadeState,
      duration: DurationMS.quick,
    );
  }
}
