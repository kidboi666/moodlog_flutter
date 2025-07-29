import 'dart:io';

import 'package:flutter/foundation.dart';

class AdmobService {
  static String? get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2435281174';
      }
    }
    if (Platform.isAndroid) {
      return 'ca-app-pub-2882120764375432/9550707836';
    }
    if (Platform.isIOS) {
      return null;
    }
    return null;
  }
}
