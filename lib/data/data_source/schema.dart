import 'package:drift/drift.dart';

import '../../domain/entities/app_state.dart';
import '../../domain/entities/journal.dart';
import '../../domain/entities/stat.dart';

@UseRowClass(Journal)
class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().nullable()();

  TextColumn get moodName => text()();

  TextColumn get imageUri => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@UseRowClass(Stat)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  IntColumn get maxStreak => integer().withDefault(const Constant(0))();

  TextColumn get lastActiveDate => text()();
}

@UseRowClass(AppState)
class AppStates extends Table {
  BoolColumn get isInitialApp => boolean().withDefault(const Constant(true))();

  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();

  DateTimeColumn get lastActiveDate => dateTime().nullable()();

  DateTimeColumn get firstExecutedDate =>
      dateTime().withDefault(currentDateAndTime)();
}
