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
  static const VerificationMeta _moodNameMeta = const VerificationMeta(
    'moodName',
  );
  @override
  late final GeneratedColumn<String> moodName = GeneratedColumn<String>(
    'mood_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUriMeta = const VerificationMeta(
    'imageUri',
  );
  @override
  late final GeneratedColumn<String> imageUri = GeneratedColumn<String>(
    'image_uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiResponseEnabledMeta = const VerificationMeta(
    'aiResponseEnabled',
  );
  @override
  late final GeneratedColumn<bool> aiResponseEnabled = GeneratedColumn<bool>(
    'ai_response_enabled',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ai_response_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    content,
    moodName,
    imageUri,
    aiResponseEnabled,
    aiResponse,
    createdAt,
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
    if (data.containsKey('mood_name')) {
      context.handle(
        _moodNameMeta,
        moodName.isAcceptableOrUnknown(data['mood_name']!, _moodNameMeta),
      );
    } else if (isInserting) {
      context.missing(_moodNameMeta);
    }
    if (data.containsKey('image_uri')) {
      context.handle(
        _imageUriMeta,
        imageUri.isAcceptableOrUnknown(data['image_uri']!, _imageUriMeta),
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
    }
    if (data.containsKey('ai_response')) {
      context.handle(
        _aiResponseMeta,
        aiResponse.isAcceptableOrUnknown(data['ai_response']!, _aiResponseMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
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
      moodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_name'],
      )!,
      imageUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_uri'],
      ),
      aiResponseEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ai_response_enabled'],
      ),
      aiResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_response'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalsTable createAlias(String alias) {
    return $JournalsTable(attachedDatabase, alias);
  }
}

class Journal extends DataClass implements Insertable<Journal> {
  final int id;
  final String? content;
  final String moodName;
  final String? imageUri;
  final bool? aiResponseEnabled;
  final String? aiResponse;
  final DateTime createdAt;
  const Journal({
    required this.id,
    this.content,
    required this.moodName,
    this.imageUri,
    this.aiResponseEnabled,
    this.aiResponse,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['mood_name'] = Variable<String>(moodName);
    if (!nullToAbsent || imageUri != null) {
      map['image_uri'] = Variable<String>(imageUri);
    }
    if (!nullToAbsent || aiResponseEnabled != null) {
      map['ai_response_enabled'] = Variable<bool>(aiResponseEnabled);
    }
    if (!nullToAbsent || aiResponse != null) {
      map['ai_response'] = Variable<String>(aiResponse);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JournalsCompanion toCompanion(bool nullToAbsent) {
    return JournalsCompanion(
      id: Value(id),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      moodName: Value(moodName),
      imageUri: imageUri == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUri),
      aiResponseEnabled: aiResponseEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(aiResponseEnabled),
      aiResponse: aiResponse == null && nullToAbsent
          ? const Value.absent()
          : Value(aiResponse),
      createdAt: Value(createdAt),
    );
  }

  factory Journal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Journal(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String?>(json['content']),
      moodName: serializer.fromJson<String>(json['moodName']),
      imageUri: serializer.fromJson<String?>(json['imageUri']),
      aiResponseEnabled: serializer.fromJson<bool?>(json['aiResponseEnabled']),
      aiResponse: serializer.fromJson<String?>(json['aiResponse']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String?>(content),
      'moodName': serializer.toJson<String>(moodName),
      'imageUri': serializer.toJson<String?>(imageUri),
      'aiResponseEnabled': serializer.toJson<bool?>(aiResponseEnabled),
      'aiResponse': serializer.toJson<String?>(aiResponse),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Journal copyWith({
    int? id,
    Value<String?> content = const Value.absent(),
    String? moodName,
    Value<String?> imageUri = const Value.absent(),
    Value<bool?> aiResponseEnabled = const Value.absent(),
    Value<String?> aiResponse = const Value.absent(),
    DateTime? createdAt,
  }) => Journal(
    id: id ?? this.id,
    content: content.present ? content.value : this.content,
    moodName: moodName ?? this.moodName,
    imageUri: imageUri.present ? imageUri.value : this.imageUri,
    aiResponseEnabled: aiResponseEnabled.present
        ? aiResponseEnabled.value
        : this.aiResponseEnabled,
    aiResponse: aiResponse.present ? aiResponse.value : this.aiResponse,
    createdAt: createdAt ?? this.createdAt,
  );
  Journal copyWithCompanion(JournalsCompanion data) {
    return Journal(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      moodName: data.moodName.present ? data.moodName.value : this.moodName,
      imageUri: data.imageUri.present ? data.imageUri.value : this.imageUri,
      aiResponseEnabled: data.aiResponseEnabled.present
          ? data.aiResponseEnabled.value
          : this.aiResponseEnabled,
      aiResponse: data.aiResponse.present
          ? data.aiResponse.value
          : this.aiResponse,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Journal(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('moodName: $moodName, ')
          ..write('imageUri: $imageUri, ')
          ..write('aiResponseEnabled: $aiResponseEnabled, ')
          ..write('aiResponse: $aiResponse, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    content,
    moodName,
    imageUri,
    aiResponseEnabled,
    aiResponse,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Journal &&
          other.id == this.id &&
          other.content == this.content &&
          other.moodName == this.moodName &&
          other.imageUri == this.imageUri &&
          other.aiResponseEnabled == this.aiResponseEnabled &&
          other.aiResponse == this.aiResponse &&
          other.createdAt == this.createdAt);
}

class JournalsCompanion extends UpdateCompanion<Journal> {
  final Value<int> id;
  final Value<String?> content;
  final Value<String> moodName;
  final Value<String?> imageUri;
  final Value<bool?> aiResponseEnabled;
  final Value<String?> aiResponse;
  final Value<DateTime> createdAt;
  const JournalsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.moodName = const Value.absent(),
    this.imageUri = const Value.absent(),
    this.aiResponseEnabled = const Value.absent(),
    this.aiResponse = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  JournalsCompanion.insert({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    required String moodName,
    this.imageUri = const Value.absent(),
    this.aiResponseEnabled = const Value.absent(),
    this.aiResponse = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : moodName = Value(moodName);
  static Insertable<Journal> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? moodName,
    Expression<String>? imageUri,
    Expression<bool>? aiResponseEnabled,
    Expression<String>? aiResponse,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (moodName != null) 'mood_name': moodName,
      if (imageUri != null) 'image_uri': imageUri,
      if (aiResponseEnabled != null) 'ai_response_enabled': aiResponseEnabled,
      if (aiResponse != null) 'ai_response': aiResponse,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  JournalsCompanion copyWith({
    Value<int>? id,
    Value<String?>? content,
    Value<String>? moodName,
    Value<String?>? imageUri,
    Value<bool?>? aiResponseEnabled,
    Value<String?>? aiResponse,
    Value<DateTime>? createdAt,
  }) {
    return JournalsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      moodName: moodName ?? this.moodName,
      imageUri: imageUri ?? this.imageUri,
      aiResponseEnabled: aiResponseEnabled ?? this.aiResponseEnabled,
      aiResponse: aiResponse ?? this.aiResponse,
      createdAt: createdAt ?? this.createdAt,
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
    if (moodName.present) {
      map['mood_name'] = Variable<String>(moodName.value);
    }
    if (imageUri.present) {
      map['image_uri'] = Variable<String>(imageUri.value);
    }
    if (aiResponseEnabled.present) {
      map['ai_response_enabled'] = Variable<bool>(aiResponseEnabled.value);
    }
    if (aiResponse.present) {
      map['ai_response'] = Variable<String>(aiResponse.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('moodName: $moodName, ')
          ..write('imageUri: $imageUri, ')
          ..write('aiResponseEnabled: $aiResponseEnabled, ')
          ..write('aiResponse: $aiResponse, ')
          ..write('createdAt: $createdAt')
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
  late final GeneratedColumn<String> lastActiveDate = GeneratedColumn<String>(
    'last_active_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
        DriftSqlType.string,
        data['${effectivePrefix}last_active_date'],
      )!,
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class Stat extends DataClass implements Insertable<Stat> {
  final int id;
  final int currentStreak;
  final int maxStreak;
  final String lastActiveDate;
  const Stat({
    required this.id,
    required this.currentStreak,
    required this.maxStreak,
    required this.lastActiveDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_streak'] = Variable<int>(currentStreak);
    map['max_streak'] = Variable<int>(maxStreak);
    map['last_active_date'] = Variable<String>(lastActiveDate);
    return map;
  }

  StatsCompanion toCompanion(bool nullToAbsent) {
    return StatsCompanion(
      id: Value(id),
      currentStreak: Value(currentStreak),
      maxStreak: Value(maxStreak),
      lastActiveDate: Value(lastActiveDate),
    );
  }

  factory Stat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stat(
      id: serializer.fromJson<int>(json['id']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      maxStreak: serializer.fromJson<int>(json['maxStreak']),
      lastActiveDate: serializer.fromJson<String>(json['lastActiveDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'maxStreak': serializer.toJson<int>(maxStreak),
      'lastActiveDate': serializer.toJson<String>(lastActiveDate),
    };
  }

  Stat copyWith({
    int? id,
    int? currentStreak,
    int? maxStreak,
    String? lastActiveDate,
  }) => Stat(
    id: id ?? this.id,
    currentStreak: currentStreak ?? this.currentStreak,
    maxStreak: maxStreak ?? this.maxStreak,
    lastActiveDate: lastActiveDate ?? this.lastActiveDate,
  );
  Stat copyWithCompanion(StatsCompanion data) {
    return Stat(
      id: data.id.present ? data.id.value : this.id,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      maxStreak: data.maxStreak.present ? data.maxStreak.value : this.maxStreak,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stat(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currentStreak, maxStreak, lastActiveDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stat &&
          other.id == this.id &&
          other.currentStreak == this.currentStreak &&
          other.maxStreak == this.maxStreak &&
          other.lastActiveDate == this.lastActiveDate);
}

class StatsCompanion extends UpdateCompanion<Stat> {
  final Value<int> id;
  final Value<int> currentStreak;
  final Value<int> maxStreak;
  final Value<String> lastActiveDate;
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
    required String lastActiveDate,
  }) : lastActiveDate = Value(lastActiveDate);
  static Insertable<Stat> custom({
    Expression<int>? id,
    Expression<int>? currentStreak,
    Expression<int>? maxStreak,
    Expression<String>? lastActiveDate,
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
    Value<String>? lastActiveDate,
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
      map['last_active_date'] = Variable<String>(lastActiveDate.value);
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

class $AppStateTable extends AppState
    with TableInfo<$AppStateTable, AppStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isInitialAppMeta = const VerificationMeta(
    'isInitialApp',
  );
  @override
  late final GeneratedColumn<bool> isInitialApp = GeneratedColumn<bool>(
    'is_initial_app',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_initial_app" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDarkModeMeta = const VerificationMeta(
    'isDarkMode',
  );
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
    'is_dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dark_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>(
        'last_active_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _firstExecutedDateMeta = const VerificationMeta(
    'firstExecutedDate',
  );
  @override
  late final GeneratedColumn<DateTime> firstExecutedDate =
      GeneratedColumn<DateTime>(
        'first_executed_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    isInitialApp,
    isDarkMode,
    lastActiveDate,
    firstExecutedDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('is_initial_app')) {
      context.handle(
        _isInitialAppMeta,
        isInitialApp.isAcceptableOrUnknown(
          data['is_initial_app']!,
          _isInitialAppMeta,
        ),
      );
    }
    if (data.containsKey('is_dark_mode')) {
      context.handle(
        _isDarkModeMeta,
        isDarkMode.isAcceptableOrUnknown(
          data['is_dark_mode']!,
          _isDarkModeMeta,
        ),
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
    }
    if (data.containsKey('first_executed_date')) {
      context.handle(
        _firstExecutedDateMeta,
        firstExecutedDate.isAcceptableOrUnknown(
          data['first_executed_date']!,
          _firstExecutedDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppStateData(
      isInitialApp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_initial_app'],
      )!,
      isDarkMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dark_mode'],
      )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_date'],
      ),
      firstExecutedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_executed_date'],
      )!,
    );
  }

  @override
  $AppStateTable createAlias(String alias) {
    return $AppStateTable(attachedDatabase, alias);
  }
}

class AppStateData extends DataClass implements Insertable<AppStateData> {
  final bool isInitialApp;
  final bool isDarkMode;
  final DateTime? lastActiveDate;
  final DateTime firstExecutedDate;
  const AppStateData({
    required this.isInitialApp,
    required this.isDarkMode,
    this.lastActiveDate,
    required this.firstExecutedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['is_initial_app'] = Variable<bool>(isInitialApp);
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    }
    map['first_executed_date'] = Variable<DateTime>(firstExecutedDate);
    return map;
  }

  AppStateCompanion toCompanion(bool nullToAbsent) {
    return AppStateCompanion(
      isInitialApp: Value(isInitialApp),
      isDarkMode: Value(isDarkMode),
      lastActiveDate: lastActiveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDate),
      firstExecutedDate: Value(firstExecutedDate),
    );
  }

  factory AppStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppStateData(
      isInitialApp: serializer.fromJson<bool>(json['isInitialApp']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
      lastActiveDate: serializer.fromJson<DateTime?>(json['lastActiveDate']),
      firstExecutedDate: serializer.fromJson<DateTime>(
        json['firstExecutedDate'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isInitialApp': serializer.toJson<bool>(isInitialApp),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
      'lastActiveDate': serializer.toJson<DateTime?>(lastActiveDate),
      'firstExecutedDate': serializer.toJson<DateTime>(firstExecutedDate),
    };
  }

  AppStateData copyWith({
    bool? isInitialApp,
    bool? isDarkMode,
    Value<DateTime?> lastActiveDate = const Value.absent(),
    DateTime? firstExecutedDate,
  }) => AppStateData(
    isInitialApp: isInitialApp ?? this.isInitialApp,
    isDarkMode: isDarkMode ?? this.isDarkMode,
    lastActiveDate: lastActiveDate.present
        ? lastActiveDate.value
        : this.lastActiveDate,
    firstExecutedDate: firstExecutedDate ?? this.firstExecutedDate,
  );
  AppStateData copyWithCompanion(AppStateCompanion data) {
    return AppStateData(
      isInitialApp: data.isInitialApp.present
          ? data.isInitialApp.value
          : this.isInitialApp,
      isDarkMode: data.isDarkMode.present
          ? data.isDarkMode.value
          : this.isDarkMode,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
      firstExecutedDate: data.firstExecutedDate.present
          ? data.firstExecutedDate.value
          : this.firstExecutedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppStateData(')
          ..write('isInitialApp: $isInitialApp, ')
          ..write('isDarkMode: $isDarkMode, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('firstExecutedDate: $firstExecutedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(isInitialApp, isDarkMode, lastActiveDate, firstExecutedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppStateData &&
          other.isInitialApp == this.isInitialApp &&
          other.isDarkMode == this.isDarkMode &&
          other.lastActiveDate == this.lastActiveDate &&
          other.firstExecutedDate == this.firstExecutedDate);
}

class AppStateCompanion extends UpdateCompanion<AppStateData> {
  final Value<bool> isInitialApp;
  final Value<bool> isDarkMode;
  final Value<DateTime?> lastActiveDate;
  final Value<DateTime> firstExecutedDate;
  final Value<int> rowid;
  const AppStateCompanion({
    this.isInitialApp = const Value.absent(),
    this.isDarkMode = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.firstExecutedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppStateCompanion.insert({
    this.isInitialApp = const Value.absent(),
    this.isDarkMode = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.firstExecutedDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AppStateData> custom({
    Expression<bool>? isInitialApp,
    Expression<bool>? isDarkMode,
    Expression<DateTime>? lastActiveDate,
    Expression<DateTime>? firstExecutedDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (isInitialApp != null) 'is_initial_app': isInitialApp,
      if (isDarkMode != null) 'is_dark_mode': isDarkMode,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
      if (firstExecutedDate != null) 'first_executed_date': firstExecutedDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppStateCompanion copyWith({
    Value<bool>? isInitialApp,
    Value<bool>? isDarkMode,
    Value<DateTime?>? lastActiveDate,
    Value<DateTime>? firstExecutedDate,
    Value<int>? rowid,
  }) {
    return AppStateCompanion(
      isInitialApp: isInitialApp ?? this.isInitialApp,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      firstExecutedDate: firstExecutedDate ?? this.firstExecutedDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isInitialApp.present) {
      map['is_initial_app'] = Variable<bool>(isInitialApp.value);
    }
    if (isDarkMode.present) {
      map['is_dark_mode'] = Variable<bool>(isDarkMode.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    if (firstExecutedDate.present) {
      map['first_executed_date'] = Variable<DateTime>(firstExecutedDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppStateCompanion(')
          ..write('isInitialApp: $isInitialApp, ')
          ..write('isDarkMode: $isDarkMode, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('firstExecutedDate: $firstExecutedDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoodLogDatabase extends GeneratedDatabase {
  _$MoodLogDatabase(QueryExecutor e) : super(e);
  $MoodLogDatabaseManager get managers => $MoodLogDatabaseManager(this);
  late final $JournalsTable journals = $JournalsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  late final $AppStateTable appState = $AppStateTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    journals,
    stats,
    appState,
  ];
}

typedef $$JournalsTableCreateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      Value<String?> content,
      required String moodName,
      Value<String?> imageUri,
      Value<bool?> aiResponseEnabled,
      Value<String?> aiResponse,
      Value<DateTime> createdAt,
    });
typedef $$JournalsTableUpdateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      Value<String?> content,
      Value<String> moodName,
      Value<String?> imageUri,
      Value<bool?> aiResponseEnabled,
      Value<String?> aiResponse,
      Value<DateTime> createdAt,
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

  ColumnFilters<String> get moodName => $composableBuilder(
    column: $table.moodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUri => $composableBuilder(
    column: $table.imageUri,
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  ColumnOrderings<String> get moodName => $composableBuilder(
    column: $table.moodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUri => $composableBuilder(
    column: $table.imageUri,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  GeneratedColumn<String> get moodName =>
      $composableBuilder(column: $table.moodName, builder: (column) => column);

  GeneratedColumn<String> get imageUri =>
      $composableBuilder(column: $table.imageUri, builder: (column) => column);

  GeneratedColumn<bool> get aiResponseEnabled => $composableBuilder(
    column: $table.aiResponseEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiResponse => $composableBuilder(
    column: $table.aiResponse,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
                Value<String> moodName = const Value.absent(),
                Value<String?> imageUri = const Value.absent(),
                Value<bool?> aiResponseEnabled = const Value.absent(),
                Value<String?> aiResponse = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JournalsCompanion(
                id: id,
                content: content,
                moodName: moodName,
                imageUri: imageUri,
                aiResponseEnabled: aiResponseEnabled,
                aiResponse: aiResponse,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> content = const Value.absent(),
                required String moodName,
                Value<String?> imageUri = const Value.absent(),
                Value<bool?> aiResponseEnabled = const Value.absent(),
                Value<String?> aiResponse = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JournalsCompanion.insert(
                id: id,
                content: content,
                moodName: moodName,
                imageUri: imageUri,
                aiResponseEnabled: aiResponseEnabled,
                aiResponse: aiResponse,
                createdAt: createdAt,
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
      required String lastActiveDate,
    });
typedef $$StatsTableUpdateCompanionBuilder =
    StatsCompanion Function({
      Value<int> id,
      Value<int> currentStreak,
      Value<int> maxStreak,
      Value<String> lastActiveDate,
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

  ColumnFilters<String> get lastActiveDate => $composableBuilder(
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

  ColumnOrderings<String> get lastActiveDate => $composableBuilder(
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

  GeneratedColumn<String> get lastActiveDate => $composableBuilder(
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
                Value<String> lastActiveDate = const Value.absent(),
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
                required String lastActiveDate,
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
typedef $$AppStateTableCreateCompanionBuilder =
    AppStateCompanion Function({
      Value<bool> isInitialApp,
      Value<bool> isDarkMode,
      Value<DateTime?> lastActiveDate,
      Value<DateTime> firstExecutedDate,
      Value<int> rowid,
    });
typedef $$AppStateTableUpdateCompanionBuilder =
    AppStateCompanion Function({
      Value<bool> isInitialApp,
      Value<bool> isDarkMode,
      Value<DateTime?> lastActiveDate,
      Value<DateTime> firstExecutedDate,
      Value<int> rowid,
    });

class $$AppStateTableFilterComposer
    extends Composer<_$MoodLogDatabase, $AppStateTable> {
  $$AppStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isInitialApp => $composableBuilder(
    column: $table.isInitialApp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstExecutedDate => $composableBuilder(
    column: $table.firstExecutedDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppStateTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $AppStateTable> {
  $$AppStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isInitialApp => $composableBuilder(
    column: $table.isInitialApp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstExecutedDate => $composableBuilder(
    column: $table.firstExecutedDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppStateTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $AppStateTable> {
  $$AppStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isInitialApp => $composableBuilder(
    column: $table.isInitialApp,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstExecutedDate => $composableBuilder(
    column: $table.firstExecutedDate,
    builder: (column) => column,
  );
}

class $$AppStateTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $AppStateTable,
          AppStateData,
          $$AppStateTableFilterComposer,
          $$AppStateTableOrderingComposer,
          $$AppStateTableAnnotationComposer,
          $$AppStateTableCreateCompanionBuilder,
          $$AppStateTableUpdateCompanionBuilder,
          (
            AppStateData,
            BaseReferences<_$MoodLogDatabase, $AppStateTable, AppStateData>,
          ),
          AppStateData,
          PrefetchHooks Function()
        > {
  $$AppStateTableTableManager(_$MoodLogDatabase db, $AppStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<bool> isInitialApp = const Value.absent(),
                Value<bool> isDarkMode = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<DateTime> firstExecutedDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppStateCompanion(
                isInitialApp: isInitialApp,
                isDarkMode: isDarkMode,
                lastActiveDate: lastActiveDate,
                firstExecutedDate: firstExecutedDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<bool> isInitialApp = const Value.absent(),
                Value<bool> isDarkMode = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<DateTime> firstExecutedDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppStateCompanion.insert(
                isInitialApp: isInitialApp,
                isDarkMode: isDarkMode,
                lastActiveDate: lastActiveDate,
                firstExecutedDate: firstExecutedDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppStateTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $AppStateTable,
      AppStateData,
      $$AppStateTableFilterComposer,
      $$AppStateTableOrderingComposer,
      $$AppStateTableAnnotationComposer,
      $$AppStateTableCreateCompanionBuilder,
      $$AppStateTableUpdateCompanionBuilder,
      (
        AppStateData,
        BaseReferences<_$MoodLogDatabase, $AppStateTable, AppStateData>,
      ),
      AppStateData,
      PrefetchHooks Function()
    >;

class $MoodLogDatabaseManager {
  final _$MoodLogDatabase _db;
  $MoodLogDatabaseManager(this._db);
  $$JournalsTableTableManager get journals =>
      $$JournalsTableTableManager(_db, _db.journals);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
  $$AppStateTableTableManager get appState =>
      $$AppStateTableTableManager(_db, _db.appState);
}
