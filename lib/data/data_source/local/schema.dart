import 'package:drift/drift.dart';
import 'package:moodlog/core/utils/converter.dart';

import '../../../core/constants/enum.dart';
import '../../../domain/entities/journal.dart';
import '../../../domain/entities/stat.dart';

@UseRowClass(Journal)
class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().nullable()();

  IntColumn get moodType => intEnum<MoodType>()();

  TextColumn get imageUri =>
      text().map(const StringListConverter()).nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@UseRowClass(Stat)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  IntColumn get maxStreak => integer().withDefault(const Constant(0))();

  TextColumn get lastActiveDate => text()();
}
