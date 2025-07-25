// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $JournalsTable extends Journals with TableInfo<$JournalsTable, Journal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MoodType, int> moodType =
      GeneratedColumn<int>(
        'mood_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MoodType>($JournalsTable.$convertermoodType);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> imageUri =
      GeneratedColumn<String>(
        'image_uri',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($JournalsTable.$converterimageUri);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _aiResponseEnabledMeta = const VerificationMeta(
    'aiResponseEnabled',
  );
  @override
  late final GeneratedColumn<bool> aiResponseEnabled = GeneratedColumn<bool>(
    'ai_response_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_response_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _aiResponseMeta = const VerificationMeta(
    'aiResponse',
  );
  @override
  late final GeneratedColumn<String> aiResponse = GeneratedColumn<String>(
    'ai_response',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    content,
    moodType,
    imageUri,
    createdAt,
    aiResponseEnabled,
    aiResponse,
    latitude,
    longitude,
    address,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Journal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('ai_response_enabled')) {
      context.handle(
        _aiResponseEnabledMeta,
        aiResponseEnabled.isAcceptableOrUnknown(
          data['ai_response_enabled']!,
          _aiResponseEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aiResponseEnabledMeta);
    }
    if (data.containsKey('ai_response')) {
      context.handle(
        _aiResponseMeta,
        aiResponse.isAcceptableOrUnknown(data['ai_response']!, _aiResponseMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Journal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Journal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      moodType: $JournalsTable.$convertermoodType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}mood_type'],
        )!,
      ),
      imageUri: $JournalsTable.$converterimageUri.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_uri'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      aiResponseEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_response_enabled'],
      )!,
      aiResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_response'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
    );
  }

  @override
  $JournalsTable createAlias(String alias) {
    return $JournalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MoodType, int, int> $convertermoodType =
      const EnumIndexConverter<MoodType>(MoodType.values);
  static TypeConverter<List<String>?, String?> $converterimageUri =
      const StringListConverter();
}

class JournalsCompanion extends UpdateCompanion<Journal> {
  final Value<int> id;
  final Value<String?> content;
  final Value<MoodType> moodType;
  final Value<List<String>?> imageUri;
  final Value<DateTime> createdAt;
  final Value<bool> aiResponseEnabled;
  final Value<String?> aiResponse;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> address;
  const JournalsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.moodType = const Value.absent(),
    this.imageUri = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.aiResponseEnabled = const Value.absent(),
    this.aiResponse = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
  });
  JournalsCompanion.insert({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    required MoodType moodType,
    this.imageUri = const Value.absent(),
    this.createdAt = const Value.absent(),
    required bool aiResponseEnabled,
    this.aiResponse = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
  }) : moodType = Value(moodType),
       aiResponseEnabled = Value(aiResponseEnabled);
  static Insertable<Journal> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<int>? moodType,
    Expression<String>? imageUri,
    Expression<DateTime>? createdAt,
    Expression<bool>? aiResponseEnabled,
    Expression<String>? aiResponse,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (moodType != null) 'mood_type': moodType,
      if (imageUri != null) 'image_uri': imageUri,
      if (createdAt != null) 'created_at': createdAt,
      if (aiResponseEnabled != null) 'ai_response_enabled': aiResponseEnabled,
      if (aiResponse != null) 'ai_response': aiResponse,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
    });
  }

  JournalsCompanion copyWith({
    Value<int>? id,
    Value<String?>? content,
    Value<MoodType>? moodType,
    Value<List<String>?>? imageUri,
    Value<DateTime>? createdAt,
    Value<bool>? aiResponseEnabled,
    Value<String?>? aiResponse,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? address,
  }) {
    return JournalsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      moodType: moodType ?? this.moodType,
      imageUri: imageUri ?? this.imageUri,
      createdAt: createdAt ?? this.createdAt,
      aiResponseEnabled: aiResponseEnabled ?? this.aiResponseEnabled,
      aiResponse: aiResponse ?? this.aiResponse,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (moodType.present) {
      map['mood_type'] = Variable<int>(
        $JournalsTable.$convertermoodType.toSql(moodType.value),
      );
    }
    if (imageUri.present) {
      map['image_uri'] = Variable<String>(
        $JournalsTable.$converterimageUri.toSql(imageUri.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (aiResponseEnabled.present) {
      map['ai_response_enabled'] = Variable<bool>(aiResponseEnabled.value);
    }
    if (aiResponse.present) {
      map['ai_response'] = Variable<String>(aiResponse.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('moodType: $moodType, ')
          ..write('imageUri: $imageUri, ')
          ..write('createdAt: $createdAt, ')
          ..write('aiResponseEnabled: $aiResponseEnabled, ')
          ..write('aiResponse: $aiResponse, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $StatsTable extends Stats with TableInfo<$StatsTable, Stat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxStreakMeta = const VerificationMeta(
    'maxStreak',
  );
  @override
  late final GeneratedColumn<int> maxStreak = GeneratedColumn<int>(
    'max_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>(
        'last_active_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentStreak,
    maxStreak,
    lastActiveDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<Stat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('max_streak')) {
      context.handle(
        _maxStreakMeta,
        maxStreak.isAcceptableOrUnknown(data['max_streak']!, _maxStreakMeta),
      );
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
        _lastActiveDateMeta,
        lastActiveDate.isAcceptableOrUnknown(
          data['last_active_date']!,
          _lastActiveDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastActiveDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      maxStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_streak'],
      )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_date'],
      )!,
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class StatsCompanion extends UpdateCompanion<Stat> {
  final Value<int> id;
  final Value<int> currentStreak;
  final Value<int> maxStreak;
  final Value<DateTime> lastActiveDate;
  const StatsCompanion({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.maxStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
  });
  StatsCompanion.insert({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.maxStreak = const Value.absent(),
    required DateTime lastActiveDate,
  }) : lastActiveDate = Value(lastActiveDate);
  static Insertable<Stat> custom({
    Expression<int>? id,
    Expression<int>? currentStreak,
    Expression<int>? maxStreak,
    Expression<DateTime>? lastActiveDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (maxStreak != null) 'max_streak': maxStreak,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
    });
  }

  StatsCompanion copyWith({
    Value<int>? id,
    Value<int>? currentStreak,
    Value<int>? maxStreak,
    Value<DateTime>? lastActiveDate,
  }) {
    return StatsCompanion(
      id: id ?? this.id,
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (maxStreak.present) {
      map['max_streak'] = Variable<int>(maxStreak.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsCompanion(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoodLogDatabase extends GeneratedDatabase {
  _$MoodLogDatabase(QueryExecutor e) : super(e);
  $MoodLogDatabaseManager get managers => $MoodLogDatabaseManager(this);
  late final $JournalsTable journals = $JournalsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  late final Index journalsCreatedAt = Index(
    'journals_created_at',
    'CREATE INDEX journals_created_at ON journals (created_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    journals,
    stats,
    journalsCreatedAt,
  ];
}

typedef $$JournalsTableCreateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      Value<String?> content,
      required MoodType moodType,
      Value<List<String>?> imageUri,
      Value<DateTime> createdAt,
      required bool aiResponseEnabled,
      Value<String?> aiResponse,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
    });
typedef $$JournalsTableUpdateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      Value<String?> content,
      Value<MoodType> moodType,
      Value<List<String>?> imageUri,
      Value<DateTime> createdAt,
      Value<bool> aiResponseEnabled,
      Value<String?> aiResponse,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
    });

class $$JournalsTableFilterComposer
    extends Composer<_$MoodLogDatabase, $JournalsTable> {
  $$JournalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MoodType, MoodType, int> get moodType =>
      $composableBuilder(
        column: $table.moodType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get imageUri => $composableBuilder(
    column: $table.imageUri,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aiResponseEnabled => $composableBuilder(
    column: $table.aiResponseEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalsTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $JournalsTable> {
  $$JournalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodType => $composableBuilder(
    column: $table.moodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUri => $composableBuilder(
    column: $table.imageUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aiResponseEnabled => $composableBuilder(
    column: $table.aiResponseEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalsTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $JournalsTable> {
  $$JournalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoodType, int> get moodType =>
      $composableBuilder(column: $table.moodType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get imageUri =>
      $composableBuilder(column: $table.imageUri, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get aiResponseEnabled => $composableBuilder(
    column: $table.aiResponseEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$JournalsTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $JournalsTable,
          Journal,
          $$JournalsTableFilterComposer,
          $$JournalsTableOrderingComposer,
          $$JournalsTableAnnotationComposer,
          $$JournalsTableCreateCompanionBuilder,
          $$JournalsTableUpdateCompanionBuilder,
          (Journal, BaseReferences<_$MoodLogDatabase, $JournalsTable, Journal>),
          Journal,
          PrefetchHooks Function()
        > {
  $$JournalsTableTableManager(_$MoodLogDatabase db, $JournalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<MoodType> moodType = const Value.absent(),
                Value<List<String>?> imageUri = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> aiResponseEnabled = const Value.absent(),
                Value<String?> aiResponse = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => JournalsCompanion(
                id: id,
                content: content,
                moodType: moodType,
                imageUri: imageUri,
                createdAt: createdAt,
                aiResponseEnabled: aiResponseEnabled,
                aiResponse: aiResponse,
                latitude: latitude,
                longitude: longitude,
                address: address,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> content = const Value.absent(),
                required MoodType moodType,
                Value<List<String>?> imageUri = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required bool aiResponseEnabled,
                Value<String?> aiResponse = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => JournalsCompanion.insert(
                id: id,
                content: content,
                moodType: moodType,
                imageUri: imageUri,
                createdAt: createdAt,
                aiResponseEnabled: aiResponseEnabled,
                aiResponse: aiResponse,
                latitude: latitude,
                longitude: longitude,
                address: address,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $JournalsTable,
      Journal,
      $$JournalsTableFilterComposer,
      $$JournalsTableOrderingComposer,
      $$JournalsTableAnnotationComposer,
      $$JournalsTableCreateCompanionBuilder,
      $$JournalsTableUpdateCompanionBuilder,
      (Journal, BaseReferences<_$MoodLogDatabase, $JournalsTable, Journal>),
      Journal,
      PrefetchHooks Function()
    >;
typedef $$StatsTableCreateCompanionBuilder =
    StatsCompanion Function({
      Value<int> id,
      Value<int> currentStreak,
      Value<int> maxStreak,
      required DateTime lastActiveDate,
    });
typedef $$StatsTableUpdateCompanionBuilder =
    StatsCompanion Function({
      Value<int> id,
      Value<int> currentStreak,
      Value<int> maxStreak,
      Value<DateTime> lastActiveDate,
    });

class $$StatsTableFilterComposer
    extends Composer<_$MoodLogDatabase, $StatsTable> {
  $$StatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStreak => $composableBuilder(
    column: $table.maxStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StatsTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $StatsTable> {
  $$StatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStreak => $composableBuilder(
    column: $table.maxStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StatsTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $StatsTable> {
  $$StatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxStreak =>
      $composableBuilder(column: $table.maxStreak, builder: (column) => column);

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );
}

class $$StatsTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $StatsTable,
          Stat,
          $$StatsTableFilterComposer,
          $$StatsTableOrderingComposer,
          $$StatsTableAnnotationComposer,
          $$StatsTableCreateCompanionBuilder,
          $$StatsTableUpdateCompanionBuilder,
          (Stat, BaseReferences<_$MoodLogDatabase, $StatsTable, Stat>),
          Stat,
          PrefetchHooks Function()
        > {
  $$StatsTableTableManager(_$MoodLogDatabase db, $StatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> maxStreak = const Value.absent(),
                Value<DateTime> lastActiveDate = const Value.absent(),
              }) => StatsCompanion(
                id: id,
                currentStreak: currentStreak,
                maxStreak: maxStreak,
                lastActiveDate: lastActiveDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> maxStreak = const Value.absent(),
                required DateTime lastActiveDate,
              }) => StatsCompanion.insert(
                id: id,
                currentStreak: currentStreak,
                maxStreak: maxStreak,
                lastActiveDate: lastActiveDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StatsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $StatsTable,
      Stat,
      $$StatsTableFilterComposer,
      $$StatsTableOrderingComposer,
      $$StatsTableAnnotationComposer,
      $$StatsTableCreateCompanionBuilder,
      $$StatsTableUpdateCompanionBuilder,
      (Stat, BaseReferences<_$MoodLogDatabase, $StatsTable, Stat>),
      Stat,
      PrefetchHooks Function()
    >;

class $MoodLogDatabaseManager {
  final _$MoodLogDatabase _db;
  $MoodLogDatabaseManager(this._db);
  $$JournalsTableTableManager get journals =>
      $$JournalsTableTableManager(_db, _db.journals);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
}
