import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/converter.dart';
import 'package:moodlog/data/data_source/local/database/schema.dart';
import 'package:moodlog/domain/entities/app/stat.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/check_in_emotion.dart';
import 'package:moodlog/domain/entities/journal/check_in_activity.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [CheckIns, Journals, Stats, Activities, CheckInActivities, Emotions, CheckInEmotions])
class MoodLogDatabase extends _$MoodLogDatabase {
  MoodLogDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }

  Future<void> clearAllTables() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'moodlog_v2.db'));

    return NativeDatabase(file);
  });
}
