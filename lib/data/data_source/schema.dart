import 'package:drift/drift.dart';

import '../../common/constants/enum.dart';
import '../../common/utils/converter.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/stat.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/journal_tag.dart';

@UseRowClass(Journal)
@TableIndex(name: 'journals_created_at', columns: {#createdAt})
class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().nullable()();

  IntColumn get moodType => intEnum<MoodType>()();

  TextColumn get imageUri =>
      text().map(const StringListConverter()).nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  BoolColumn get aiResponseEnabled => boolean()();

  TextColumn get aiResponse => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  TextColumn get address => text().nullable()();

  RealColumn get temperature => real().nullable()();

  TextColumn get weatherIcon => text().nullable()();

  TextColumn get weatherDescription => text().nullable()();
}

@UseRowClass(Stat)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  IntColumn get maxStreak => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastActiveDate => dateTime()();
}

@UseRowClass(Tag)
@TableIndex(name: 'tags_name', columns: {#name})
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(max: 50)();

  TextColumn get color => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@UseRowClass(JournalTag)
@TableIndex(name: 'journal_tags_journal_id', columns: {#journalId})
@TableIndex(name: 'journal_tags_tag_id', columns: {#tagId})
class JournalTags extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get journalId => integer().references(Journals, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId => integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
