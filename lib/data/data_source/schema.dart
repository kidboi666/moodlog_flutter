import 'package:drift/drift.dart';
import 'package:moodlog/core/utils/converter.dart';

import '../../core/constants/enum.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/stat.dart';

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
}

@UseRowClass(Stat)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  IntColumn get maxStreak => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastActiveDate => dateTime()();
}
