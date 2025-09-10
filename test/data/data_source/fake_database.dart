import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/converter.dart';
import 'package:moodlog/data/data_source/schema.dart';
import 'package:moodlog/domain/entities/app/stat.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/journal_tag.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

part 'fake_database.g.dart';

@DriftDatabase(tables: [Journals, Stats, Tags, JournalTags])
class FakeDatabase extends _$FakeDatabase {
  FakeDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
