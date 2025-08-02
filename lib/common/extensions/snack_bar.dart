import 'package:flutter/material.dart';

typedef SnackBarController =
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason>;

extension ScaffoldMessengerExtension on BuildContext {
  void showSnackBar(
    SnackBar snackBar, {
    AnimationStyle? snackBarAnimationStyle,
  }) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar, snackBarAnimationStyle: snackBarAnimationStyle);
  }
}
