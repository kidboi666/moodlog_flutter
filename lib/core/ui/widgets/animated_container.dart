import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class AnimatedNavigatorContainer extends StatelessWidget {
  final int currentIndex;
  final List<Widget> children;

  const AnimatedNavigatorContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children.mapIndexed((int index, Widget navigator) {
        return AnimatedSlide(
          offset: Offset(0, index == currentIndex ? 0 : 0.01),
          curve: Curves.easeInOut,
          duration: DurationMS.medium,
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: DurationMS.medium,
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      }).toList(),
    );
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
    ignoring: index != currentIndex,
    child: TickerMode(enabled: index == currentIndex, child: navigator),
  );
}
