import 'dart:io';

import 'package:flutter/foundation.dart';

class AdmobService {
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
      return 'ca-app-pub-2882120764375432/9496783234';
    }
    if (Platform.isIOS) {
      return null;
    }
    return null;
  }
}
