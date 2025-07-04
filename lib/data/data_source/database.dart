import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/constants/enum.dart';
import '../../core/utils/converter.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/stat.dart';
import 'schema.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Stats])
class MoodLogDatabase extends _$MoodLogDatabase {
  MoodLogDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mood_log.db'));

    if (kDebugMode) {
      if (await file.exists()) {
        await file.delete();
        print('Database file deleted successfully');
      }
    }

    return NativeDatabase(file);
  });
}
