import 'dart:io';

import 'package:flutter/foundation.dart';

class AdmobHelper {
  static String? get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9214589741';
      }
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2435281174';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-2882120764375432/5576653867';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-2882120764375432/9391227055';
    }
    return null;
  }

  static String? get nativeAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/2247696110';
      }
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/3986624511';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-2882120764375432/1522692937';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-2882120764375432/6431690091';
    }
    return null;
  }
}
