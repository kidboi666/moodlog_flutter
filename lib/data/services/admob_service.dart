import 'dart:io';

import 'package:flutter/foundation.dart';

class AdmobService {
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
}
