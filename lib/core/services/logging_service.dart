import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingService {
  static void initialize(Level level) {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      // kDebugMode를 사용하여 디버그 모드에서만 로그가 출력되도록 합니다.
      if (kDebugMode) {
        debugPrint('${record.level.name}: ${record.time}: ${record.message}');
        if (record.error != null) {
          debugPrint('Error: ${record.error}');
        }
        if (record.stackTrace != null) {
          debugPrint('StackTrace: ${record.stackTrace}');
        }
      }
    });
  }
}
