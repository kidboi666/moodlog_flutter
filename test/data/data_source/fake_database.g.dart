// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_database.dart';

// ignore_for_file: type=lint
abstract class _$FakeDatabase extends GeneratedDatabase {
  _$FakeDatabase(QueryExecutor e) : super(e);
  $FakeDatabaseManager get managers => $FakeDatabaseManager(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [];
}

class $FakeDatabaseManager {
  final _$FakeDatabase _db;
  $FakeDatabaseManager(this._db);
}
