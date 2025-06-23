import 'package:drift/drift.dart';

class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text().nullable()();

  TextColumn get moodName => text()();

  TextColumn get imageUri => text().nullable()();

  BoolColumn get aiResponseEnabled =>
      boolean().withDefault(const Constant(false)).nullable()();

  TextColumn get aiResponse => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get currentStreak => integer().withDefault(const Constant(0))();

  IntColumn get maxStreak => integer().withDefault(const Constant(0))();

  TextColumn get lastActiveDate => text()();
}

class AppState extends Table {
  BoolColumn get isInitialApp => boolean().withDefault(const Constant(true))();

  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();

  DateTimeColumn get lastActiveDate => dateTime().nullable()();

  DateTimeColumn get firstExecutedDate =>
      dateTime().withDefault(currentDateAndTime)();
}
