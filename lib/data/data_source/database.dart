import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../common/constants/enum.dart';
import '../../common/utils/converter.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/stat.dart';
import 'schema.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Stats])
class MoodLogDatabase extends _$MoodLogDatabase {
  MoodLogDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

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
