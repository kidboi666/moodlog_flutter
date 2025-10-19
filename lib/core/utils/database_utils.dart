import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseUtils {
  static Future<void> cleanupOldDatabase() async {
    const cleanupFlagKey = 'db_cleanup_v2_completed';

    try {
      final prefs = await SharedPreferences.getInstance();
      final isCleanupCompleted = prefs.getBool(cleanupFlagKey) ?? false;

      if (!isCleanupCompleted) {
        final dbFolder = await getApplicationDocumentsDirectory();
        final oldDbFile = File(p.join(dbFolder.path, 'db.sqlite'));

        if (await oldDbFile.exists()) {
          await oldDbFile.delete();
          debugPrint('Old database file deleted successfully');
        }

        await prefs.setBool(cleanupFlagKey, true);
      }
    } catch (e) {
      debugPrint('Error during database cleanup: $e');
    }
  }
}
