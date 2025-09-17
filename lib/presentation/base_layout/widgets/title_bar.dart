import 'package:flutter/material.dart';
import 'package:moodlog/presentation/base_layout/widgets/weather_widget.dart';

import '../../../core/constants/common.dart';
import 'hello.dart';

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
    Future.delayed(DelayMS.oneSecond * 3, () {
      setState(() => crossFadeState = CrossFadeState.showSecond);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Hello(key: const ValueKey('hello')),
      secondChild: WeatherWidget(key: const ValueKey('weather')),
      crossFadeState: crossFadeState,
      duration: DurationMS.quick,
    );
  }
}
