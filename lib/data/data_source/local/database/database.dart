import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/utils/converter.dart';
import '../../../../domain/entities/app/stat.dart';
import '../../../../domain/entities/journal/journal.dart';
import '../../../../domain/entities/journal/journal_tag.dart';
import '../../../../domain/entities/journal/tag.dart';
import 'schema.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Stats, Tags, JournalTags])
class MoodLogDatabase extends _$MoodLogDatabase {
  MoodLogDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from == 1) {
          await m.createIndex(
            Index(
              'journals',
              'CREATE INDEX journals_created_at ON journals (created_at)',
            ),
          );
        }
        if (from <= 2) {
          await m.addColumn(journals, journals.latitude);
          await m.addColumn(journals, journals.longitude);
          await m.addColumn(journals, journals.address);
        }
        if (from <= 3) {
          await m.addColumn(journals, journals.temperature);
          await m.addColumn(journals, journals.weatherIcon);
          await m.addColumn(journals, journals.weatherDescription);
        }
        if (from <= 4) {
          await m.createTable(tags);
          await m.createTable(journalTags);
        }
        if (from <= 5) {
          await m.addColumn(journals, journals.tagNames);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
