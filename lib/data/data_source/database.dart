import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/constants/enum.dart';
import '../../core/utils/converter.dart';
import '../../domain/entities/app/stat.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/entities/journal/journal_tag.dart';
import '../../domain/entities/journal/tag.dart';
import 'schema.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Stats, Tags, JournalTags])
class MoodLogDatabase extends _$MoodLogDatabase {
  MoodLogDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.createIndex(
            Index(
              'journals',
              'CREATE INDEX journals_created_at ON journals (created_at)',
            ),
          );
        }
        if (from <= 2) {
          await migrator.addColumn(journals, journals.latitude);
          await migrator.addColumn(journals, journals.longitude);
          await migrator.addColumn(journals, journals.address);
        }
        if (from <= 3) {
          await migrator.addColumn(journals, journals.temperature);
          await migrator.addColumn(journals, journals.weatherIcon);
          await migrator.addColumn(journals, journals.weatherDescription);
        }
        if (from <= 4) {
          await migrator.createTable(tags);
          await migrator.createTable(journalTags);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mood_log.db'));

    return NativeDatabase(file);
  });
}
