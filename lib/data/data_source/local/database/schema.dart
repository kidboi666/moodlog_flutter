import 'package:drift/drift.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/converter.dart';
import 'package:moodlog/domain/entities/app/stat.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/entities/journal/check_in_emotion.dart';
import 'package:moodlog/domain/entities/journal/check_in_tag.dart';
import 'package:moodlog/domain/entities/journal/emotion.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

// CheckIns - 분석용 데이터 테이블
@UseRowClass(CheckIn)
@TableIndex(name: 'check_ins_created_at', columns: {#createdAt})
class CheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get moodType => intEnum<MoodType>()();

  IntColumn get sleepQuality => integer().nullable()();

  TextColumn get emotionNames =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get tagNames =>
      text().map(const StringListConverter()).nullable()();

  TextColumn get memo => text().nullable()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();

  TextColumn get address => text().nullable()();

  RealColumn get temperature => real().nullable()();

  TextColumn get weatherIcon => text().nullable()();

  TextColumn get weatherDescription => text().nullable()();
}

// Journals - 기록용 컨텐츠 테이블
@UseRowClass(Journal)
@TableIndex(name: 'journals_created_at', columns: {#createdAt})
class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get content => text()();

  TextColumn get imageUri =>
      text().map(const StringListConverter()).nullable()();

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

@UseRowClass(CheckInTag)
@TableIndex(name: 'check_in_tags_check_in_id', columns: {#checkInId})
@TableIndex(name: 'check_in_tags_tag_id', columns: {#tagId})
class CheckInTags extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get checkInId =>
      integer().references(CheckIns, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {checkInId, tagId},
  ];
}

@UseRowClass(Emotion)
@TableIndex(name: 'emotions_name', columns: {#name})
class Emotions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(max: 50)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@UseRowClass(CheckInEmotion)
@TableIndex(name: 'check_in_emotions_check_in_id', columns: {#checkInId})
@TableIndex(name: 'check_in_emotions_emotion_id', columns: {#emotionId})
class CheckInEmotions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get checkInId =>
      integer().references(CheckIns, #id, onDelete: KeyAction.cascade)();

  IntColumn get emotionId =>
      integer().references(Emotions, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {checkInId, emotionId},
  ];
}
