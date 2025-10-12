import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/converter.dart';
import 'package:moodlog/domain/entities/app/stat.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/journal_tag.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

// Drift 어노테이션: 이 테이블에서 생성되는 행 데이터를 Tag 클래스로 매핑
@UseRowClass(Journal)
// 테이블 인덱스 생성 어노테이션: [name]: 인덱스 이름, [columns]: 인덱스를 생성할 컬럼 목록
@TableIndex(name: 'journals_created_at', columns: {#createdAt})
class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get moodType => intEnum<MoodType>()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  BoolColumn get aiResponseEnabled => boolean()();

  TextColumn get imageUri =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get content => text().nullable()();

  TextColumn get aiResponse => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  TextColumn get tagNames =>
      text().map(const StringListConverter()).nullable()();

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

  IntColumn get journalId =>
      integer().references(Journals, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {journalId, tagId},
  ];
}
