// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CheckInsTable extends CheckIns with TableInfo<$CheckInsTable, CheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MoodType, int> moodType =
      GeneratedColumn<int>(
        'mood_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MoodType>($CheckInsTable.$convertermoodType);
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
    'sleep_quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  emotionNames = GeneratedColumn<String>(
    'emotion_names',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($CheckInsTable.$converteremotionNames);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  activityNames = GeneratedColumn<String>(
    'activity_names',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($CheckInsTable.$converteractivityNames);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
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
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherIconMeta = const VerificationMeta(
    'weatherIcon',
  );
  @override
  late final GeneratedColumn<String> weatherIcon = GeneratedColumn<String>(
    'weather_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherDescriptionMeta =
      const VerificationMeta('weatherDescription');
  @override
  late final GeneratedColumn<String> weatherDescription =
      GeneratedColumn<String>(
        'weather_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    moodType,
    sleepQuality,
    emotionNames,
    activityNames,
    memo,
    latitude,
    longitude,
    address,
    temperature,
    weatherIcon,
    weatherDescription,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
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
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('weather_icon')) {
      context.handle(
        _weatherIconMeta,
        weatherIcon.isAcceptableOrUnknown(
          data['weather_icon']!,
          _weatherIconMeta,
        ),
      );
    }
    if (data.containsKey('weather_description')) {
      context.handle(
        _weatherDescriptionMeta,
        weatherDescription.isAcceptableOrUnknown(
          data['weather_description']!,
          _weatherDescriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckIn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      moodType: $CheckInsTable.$convertermoodType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}mood_type'],
        )!,
      ),
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality'],
      ),
      emotionNames: $CheckInsTable.$converteremotionNames.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}emotion_names'],
        ),
      ),
      activityNames: $CheckInsTable.$converteractivityNames.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}activity_names'],
        ),
      ),
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
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
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      weatherIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_icon'],
      ),
      weatherDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_description'],
      ),
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MoodType, int, int> $convertermoodType =
      const EnumIndexConverter<MoodType>(MoodType.values);
  static TypeConverter<List<String>?, String?> $converteremotionNames =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converteractivityNames =
      const StringListConverter();
}

class CheckInsCompanion extends UpdateCompanion<CheckIn> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<MoodType> moodType;
  final Value<int?> sleepQuality;
  final Value<List<String>?> emotionNames;
  final Value<List<String>?> activityNames;
  final Value<String?> memo;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> address;
  final Value<double?> temperature;
  final Value<String?> weatherIcon;
  final Value<String?> weatherDescription;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.moodType = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.emotionNames = const Value.absent(),
    this.activityNames = const Value.absent(),
    this.memo = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.temperature = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  });
  CheckInsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required MoodType moodType,
    this.sleepQuality = const Value.absent(),
    this.emotionNames = const Value.absent(),
    this.activityNames = const Value.absent(),
    this.memo = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.temperature = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  }) : createdAt = Value(createdAt),
       moodType = Value(moodType);
  static Insertable<CheckIn> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? moodType,
    Expression<int>? sleepQuality,
    Expression<String>? emotionNames,
    Expression<String>? activityNames,
    Expression<String>? memo,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<double>? temperature,
    Expression<String>? weatherIcon,
    Expression<String>? weatherDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (moodType != null) 'mood_type': moodType,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (emotionNames != null) 'emotion_names': emotionNames,
      if (activityNames != null) 'activity_names': activityNames,
      if (memo != null) 'memo': memo,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (temperature != null) 'temperature': temperature,
      if (weatherIcon != null) 'weather_icon': weatherIcon,
      if (weatherDescription != null) 'weather_description': weatherDescription,
    });
  }

  CheckInsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<MoodType>? moodType,
    Value<int?>? sleepQuality,
    Value<List<String>?>? emotionNames,
    Value<List<String>?>? activityNames,
    Value<String?>? memo,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? address,
    Value<double?>? temperature,
    Value<String?>? weatherIcon,
    Value<String?>? weatherDescription,
  }) {
    return CheckInsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      moodType: moodType ?? this.moodType,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      emotionNames: emotionNames ?? this.emotionNames,
      activityNames: activityNames ?? this.activityNames,
      memo: memo ?? this.memo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      temperature: temperature ?? this.temperature,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      weatherDescription: weatherDescription ?? this.weatherDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (moodType.present) {
      map['mood_type'] = Variable<int>(
        $CheckInsTable.$convertermoodType.toSql(moodType.value),
      );
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (emotionNames.present) {
      map['emotion_names'] = Variable<String>(
        $CheckInsTable.$converteremotionNames.toSql(emotionNames.value),
      );
    }
    if (activityNames.present) {
      map['activity_names'] = Variable<String>(
        $CheckInsTable.$converteractivityNames.toSql(activityNames.value),
      );
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
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
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (weatherIcon.present) {
      map['weather_icon'] = Variable<String>(weatherIcon.value);
    }
    if (weatherDescription.present) {
      map['weather_description'] = Variable<String>(weatherDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('moodType: $moodType, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('emotionNames: $emotionNames, ')
          ..write('activityNames: $activityNames, ')
          ..write('memo: $memo, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('temperature: $temperature, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> imageUri =
      GeneratedColumn<String>(
        'image_uri',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($JournalsTable.$converterimageUri);
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
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherIconMeta = const VerificationMeta(
    'weatherIcon',
  );
  @override
  late final GeneratedColumn<String> weatherIcon = GeneratedColumn<String>(
    'weather_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherDescriptionMeta =
      const VerificationMeta('weatherDescription');
  @override
  late final GeneratedColumn<String> weatherDescription =
      GeneratedColumn<String>(
        'weather_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    content,
    imageUri,
    latitude,
    longitude,
    address,
    temperature,
    weatherIcon,
    weatherDescription,
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
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
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('weather_icon')) {
      context.handle(
        _weatherIconMeta,
        weatherIcon.isAcceptableOrUnknown(
          data['weather_icon']!,
          _weatherIconMeta,
        ),
      );
    }
    if (data.containsKey('weather_description')) {
      context.handle(
        _weatherDescriptionMeta,
        weatherDescription.isAcceptableOrUnknown(
          data['weather_description']!,
          _weatherDescriptionMeta,
        ),
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
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      imageUri: $JournalsTable.$converterimageUri.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}image_uri'],
        ),
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
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      weatherIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_icon'],
      ),
      weatherDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_description'],
      ),
    );
  }

  @override
  $JournalsTable createAlias(String alias) {
    return $JournalsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>?, String?> $converterimageUri =
      const StringListConverter();
}

class JournalsCompanion extends UpdateCompanion<Journal> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> content;
  final Value<List<String>?> imageUri;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> address;
  final Value<double?> temperature;
  final Value<String?> weatherIcon;
  final Value<String?> weatherDescription;
  const JournalsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.content = const Value.absent(),
    this.imageUri = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.temperature = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  });
  JournalsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required String content,
    this.imageUri = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.temperature = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  }) : createdAt = Value(createdAt),
       content = Value(content);
  static Insertable<Journal> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? content,
    Expression<String>? imageUri,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<double>? temperature,
    Expression<String>? weatherIcon,
    Expression<String>? weatherDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (content != null) 'content': content,
      if (imageUri != null) 'image_uri': imageUri,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (temperature != null) 'temperature': temperature,
      if (weatherIcon != null) 'weather_icon': weatherIcon,
      if (weatherDescription != null) 'weather_description': weatherDescription,
    });
  }

  JournalsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? content,
    Value<List<String>?>? imageUri,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? address,
    Value<double?>? temperature,
    Value<String?>? weatherIcon,
    Value<String?>? weatherDescription,
  }) {
    return JournalsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      imageUri: imageUri ?? this.imageUri,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      temperature: temperature ?? this.temperature,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      weatherDescription: weatherDescription ?? this.weatherDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (imageUri.present) {
      map['image_uri'] = Variable<String>(
        $JournalsTable.$converterimageUri.toSql(imageUri.value),
      );
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
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (weatherIcon.present) {
      map['weather_icon'] = Variable<String>(weatherIcon.value);
    }
    if (weatherDescription.present) {
      map['weather_description'] = Variable<String>(weatherDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('content: $content, ')
          ..write('imageUri: $imageUri, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('temperature: $temperature, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription')
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

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
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
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
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
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Activity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ActivitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? color,
    Value<DateTime>? createdAt,
  }) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckInActivitiesTable extends CheckInActivities
    with TableInfo<$CheckInActivitiesTable, CheckInActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInActivitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _checkInIdMeta = const VerificationMeta(
    'checkInId',
  );
  @override
  late final GeneratedColumn<int> checkInId = GeneratedColumn<int>(
    'check_in_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES check_ins (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<int> activityId = GeneratedColumn<int>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES activities (id) ON DELETE CASCADE',
    ),
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
  List<GeneratedColumn> get $columns => [id, checkInId, activityId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_in_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('check_in_id')) {
      context.handle(
        _checkInIdMeta,
        checkInId.isAcceptableOrUnknown(data['check_in_id']!, _checkInIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkInIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {checkInId, activityId},
  ];
  @override
  CheckInActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInActivity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      checkInId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activity_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CheckInActivitiesTable createAlias(String alias) {
    return $CheckInActivitiesTable(attachedDatabase, alias);
  }
}

class CheckInActivitiesCompanion extends UpdateCompanion<CheckInActivity> {
  final Value<int> id;
  final Value<int> checkInId;
  final Value<int> activityId;
  final Value<DateTime> createdAt;
  const CheckInActivitiesCompanion({
    this.id = const Value.absent(),
    this.checkInId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckInActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required int checkInId,
    required int activityId,
    this.createdAt = const Value.absent(),
  }) : checkInId = Value(checkInId),
       activityId = Value(activityId);
  static Insertable<CheckInActivity> custom({
    Expression<int>? id,
    Expression<int>? checkInId,
    Expression<int>? activityId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkInId != null) 'check_in_id': checkInId,
      if (activityId != null) 'activity_id': activityId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckInActivitiesCompanion copyWith({
    Value<int>? id,
    Value<int>? checkInId,
    Value<int>? activityId,
    Value<DateTime>? createdAt,
  }) {
    return CheckInActivitiesCompanion(
      id: id ?? this.id,
      checkInId: checkInId ?? this.checkInId,
      activityId: activityId ?? this.activityId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (checkInId.present) {
      map['check_in_id'] = Variable<int>(checkInId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<int>(activityId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('checkInId: $checkInId, ')
          ..write('activityId: $activityId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EmotionsTable extends Emotions with TableInfo<$EmotionsTable, Emotion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmotionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emotions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Emotion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Emotion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Emotion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EmotionsTable createAlias(String alias) {
    return $EmotionsTable(attachedDatabase, alias);
  }
}

class EmotionsCompanion extends UpdateCompanion<Emotion> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const EmotionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EmotionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Emotion> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EmotionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return EmotionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmotionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckInEmotionsTable extends CheckInEmotions
    with TableInfo<$CheckInEmotionsTable, CheckInEmotion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInEmotionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _checkInIdMeta = const VerificationMeta(
    'checkInId',
  );
  @override
  late final GeneratedColumn<int> checkInId = GeneratedColumn<int>(
    'check_in_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES check_ins (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _emotionIdMeta = const VerificationMeta(
    'emotionId',
  );
  @override
  late final GeneratedColumn<int> emotionId = GeneratedColumn<int>(
    'emotion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES emotions (id) ON DELETE CASCADE',
    ),
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
  List<GeneratedColumn> get $columns => [id, checkInId, emotionId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_in_emotions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInEmotion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('check_in_id')) {
      context.handle(
        _checkInIdMeta,
        checkInId.isAcceptableOrUnknown(data['check_in_id']!, _checkInIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkInIdMeta);
    }
    if (data.containsKey('emotion_id')) {
      context.handle(
        _emotionIdMeta,
        emotionId.isAcceptableOrUnknown(data['emotion_id']!, _emotionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_emotionIdMeta);
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {checkInId, emotionId},
  ];
  @override
  CheckInEmotion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInEmotion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      checkInId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_id'],
      )!,
      emotionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}emotion_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CheckInEmotionsTable createAlias(String alias) {
    return $CheckInEmotionsTable(attachedDatabase, alias);
  }
}

class CheckInEmotionsCompanion extends UpdateCompanion<CheckInEmotion> {
  final Value<int> id;
  final Value<int> checkInId;
  final Value<int> emotionId;
  final Value<DateTime> createdAt;
  const CheckInEmotionsCompanion({
    this.id = const Value.absent(),
    this.checkInId = const Value.absent(),
    this.emotionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckInEmotionsCompanion.insert({
    this.id = const Value.absent(),
    required int checkInId,
    required int emotionId,
    this.createdAt = const Value.absent(),
  }) : checkInId = Value(checkInId),
       emotionId = Value(emotionId);
  static Insertable<CheckInEmotion> custom({
    Expression<int>? id,
    Expression<int>? checkInId,
    Expression<int>? emotionId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkInId != null) 'check_in_id': checkInId,
      if (emotionId != null) 'emotion_id': emotionId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckInEmotionsCompanion copyWith({
    Value<int>? id,
    Value<int>? checkInId,
    Value<int>? emotionId,
    Value<DateTime>? createdAt,
  }) {
    return CheckInEmotionsCompanion(
      id: id ?? this.id,
      checkInId: checkInId ?? this.checkInId,
      emotionId: emotionId ?? this.emotionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (checkInId.present) {
      map['check_in_id'] = Variable<int>(checkInId.value);
    }
    if (emotionId.present) {
      map['emotion_id'] = Variable<int>(emotionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInEmotionsCompanion(')
          ..write('id: $id, ')
          ..write('checkInId: $checkInId, ')
          ..write('emotionId: $emotionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MoodSummariesTable extends MoodSummaries
    with TableInfo<$MoodSummariesTable, MoodSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodSummariesTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<MoodSummaryPeriod, int> period =
      GeneratedColumn<int>(
        'period',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MoodSummaryPeriod>($MoodSummariesTable.$converterperiod);
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emotionalFlowMeta = const VerificationMeta(
    'emotionalFlow',
  );
  @override
  late final GeneratedColumn<String> emotionalFlow = GeneratedColumn<String>(
    'emotional_flow',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dominantMoodsMeta = const VerificationMeta(
    'dominantMoods',
  );
  @override
  late final GeneratedColumn<String> dominantMoods = GeneratedColumn<String>(
    'dominant_moods',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityPatternsMeta = const VerificationMeta(
    'activityPatterns',
  );
  @override
  late final GeneratedColumn<String> activityPatterns = GeneratedColumn<String>(
    'activity_patterns',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personalAdviceMeta = const VerificationMeta(
    'personalAdvice',
  );
  @override
  late final GeneratedColumn<String> personalAdvice = GeneratedColumn<String>(
    'personal_advice',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyPointsMeta = const VerificationMeta(
    'keyPoints',
  );
  @override
  late final GeneratedColumn<String> keyPoints = GeneratedColumn<String>(
    'key_points',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, dynamic>>($MoodSummariesTable.$convertermetadata);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    period,
    startDate,
    endDate,
    generatedAt,
    emotionalFlow,
    dominantMoods,
    activityPatterns,
    personalAdvice,
    keyPoints,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mood_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoodSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('emotional_flow')) {
      context.handle(
        _emotionalFlowMeta,
        emotionalFlow.isAcceptableOrUnknown(
          data['emotional_flow']!,
          _emotionalFlowMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emotionalFlowMeta);
    }
    if (data.containsKey('dominant_moods')) {
      context.handle(
        _dominantMoodsMeta,
        dominantMoods.isAcceptableOrUnknown(
          data['dominant_moods']!,
          _dominantMoodsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dominantMoodsMeta);
    }
    if (data.containsKey('activity_patterns')) {
      context.handle(
        _activityPatternsMeta,
        activityPatterns.isAcceptableOrUnknown(
          data['activity_patterns']!,
          _activityPatternsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityPatternsMeta);
    }
    if (data.containsKey('personal_advice')) {
      context.handle(
        _personalAdviceMeta,
        personalAdvice.isAcceptableOrUnknown(
          data['personal_advice']!,
          _personalAdviceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_personalAdviceMeta);
    }
    if (data.containsKey('key_points')) {
      context.handle(
        _keyPointsMeta,
        keyPoints.isAcceptableOrUnknown(data['key_points']!, _keyPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_keyPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoodSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoodSummary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      period: $MoodSummariesTable.$converterperiod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}period'],
        )!,
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      emotionalFlow: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emotional_flow'],
      )!,
      dominantMoods: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dominant_moods'],
      )!,
      activityPatterns: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_patterns'],
      )!,
      personalAdvice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_advice'],
      )!,
      keyPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_points'],
      )!,
      metadata: $MoodSummariesTable.$convertermetadata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metadata'],
        )!,
      ),
    );
  }

  @override
  $MoodSummariesTable createAlias(String alias) {
    return $MoodSummariesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MoodSummaryPeriod, int, int> $converterperiod =
      const EnumIndexConverter<MoodSummaryPeriod>(MoodSummaryPeriod.values);
  static TypeConverter<Map<String, dynamic>, String> $convertermetadata =
      const JsonMapConverter();
}

class MoodSummariesCompanion extends UpdateCompanion<MoodSummary> {
  final Value<int> id;
  final Value<MoodSummaryPeriod> period;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<DateTime> generatedAt;
  final Value<String> emotionalFlow;
  final Value<String> dominantMoods;
  final Value<String> activityPatterns;
  final Value<String> personalAdvice;
  final Value<String> keyPoints;
  final Value<Map<String, dynamic>> metadata;
  const MoodSummariesCompanion({
    this.id = const Value.absent(),
    this.period = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.emotionalFlow = const Value.absent(),
    this.dominantMoods = const Value.absent(),
    this.activityPatterns = const Value.absent(),
    this.personalAdvice = const Value.absent(),
    this.keyPoints = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  MoodSummariesCompanion.insert({
    this.id = const Value.absent(),
    required MoodSummaryPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime generatedAt,
    required String emotionalFlow,
    required String dominantMoods,
    required String activityPatterns,
    required String personalAdvice,
    required String keyPoints,
    required Map<String, dynamic> metadata,
  }) : period = Value(period),
       startDate = Value(startDate),
       endDate = Value(endDate),
       generatedAt = Value(generatedAt),
       emotionalFlow = Value(emotionalFlow),
       dominantMoods = Value(dominantMoods),
       activityPatterns = Value(activityPatterns),
       personalAdvice = Value(personalAdvice),
       keyPoints = Value(keyPoints),
       metadata = Value(metadata);
  static Insertable<MoodSummary> custom({
    Expression<int>? id,
    Expression<int>? period,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? generatedAt,
    Expression<String>? emotionalFlow,
    Expression<String>? dominantMoods,
    Expression<String>? activityPatterns,
    Expression<String>? personalAdvice,
    Expression<String>? keyPoints,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (period != null) 'period': period,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (emotionalFlow != null) 'emotional_flow': emotionalFlow,
      if (dominantMoods != null) 'dominant_moods': dominantMoods,
      if (activityPatterns != null) 'activity_patterns': activityPatterns,
      if (personalAdvice != null) 'personal_advice': personalAdvice,
      if (keyPoints != null) 'key_points': keyPoints,
      if (metadata != null) 'metadata': metadata,
    });
  }

  MoodSummariesCompanion copyWith({
    Value<int>? id,
    Value<MoodSummaryPeriod>? period,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<DateTime>? generatedAt,
    Value<String>? emotionalFlow,
    Value<String>? dominantMoods,
    Value<String>? activityPatterns,
    Value<String>? personalAdvice,
    Value<String>? keyPoints,
    Value<Map<String, dynamic>>? metadata,
  }) {
    return MoodSummariesCompanion(
      id: id ?? this.id,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      generatedAt: generatedAt ?? this.generatedAt,
      emotionalFlow: emotionalFlow ?? this.emotionalFlow,
      dominantMoods: dominantMoods ?? this.dominantMoods,
      activityPatterns: activityPatterns ?? this.activityPatterns,
      personalAdvice: personalAdvice ?? this.personalAdvice,
      keyPoints: keyPoints ?? this.keyPoints,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (period.present) {
      map['period'] = Variable<int>(
        $MoodSummariesTable.$converterperiod.toSql(period.value),
      );
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (emotionalFlow.present) {
      map['emotional_flow'] = Variable<String>(emotionalFlow.value);
    }
    if (dominantMoods.present) {
      map['dominant_moods'] = Variable<String>(dominantMoods.value);
    }
    if (activityPatterns.present) {
      map['activity_patterns'] = Variable<String>(activityPatterns.value);
    }
    if (personalAdvice.present) {
      map['personal_advice'] = Variable<String>(personalAdvice.value);
    }
    if (keyPoints.present) {
      map['key_points'] = Variable<String>(keyPoints.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(
        $MoodSummariesTable.$convertermetadata.toSql(metadata.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoodSummariesCompanion(')
          ..write('id: $id, ')
          ..write('period: $period, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('emotionalFlow: $emotionalFlow, ')
          ..write('dominantMoods: $dominantMoods, ')
          ..write('activityPatterns: $activityPatterns, ')
          ..write('personalAdvice: $personalAdvice, ')
          ..write('keyPoints: $keyPoints, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoodLogDatabase extends GeneratedDatabase {
  _$MoodLogDatabase(QueryExecutor e) : super(e);
  $MoodLogDatabaseManager get managers => $MoodLogDatabaseManager(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final $JournalsTable journals = $JournalsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $CheckInActivitiesTable checkInActivities =
      $CheckInActivitiesTable(this);
  late final $EmotionsTable emotions = $EmotionsTable(this);
  late final $CheckInEmotionsTable checkInEmotions = $CheckInEmotionsTable(
    this,
  );
  late final $MoodSummariesTable moodSummaries = $MoodSummariesTable(this);
  late final Index checkInsCreatedAt = Index(
    'check_ins_created_at',
    'CREATE INDEX check_ins_created_at ON check_ins (created_at)',
  );
  late final Index journalsCreatedAt = Index(
    'journals_created_at',
    'CREATE INDEX journals_created_at ON journals (created_at)',
  );
  late final Index activitiesName = Index(
    'activities_name',
    'CREATE INDEX activities_name ON activities (name)',
  );
  late final Index checkInActivitiesCheckInId = Index(
    'check_in_activities_check_in_id',
    'CREATE INDEX check_in_activities_check_in_id ON check_in_activities (check_in_id)',
  );
  late final Index checkInActivitiesActivityId = Index(
    'check_in_activities_activity_id',
    'CREATE INDEX check_in_activities_activity_id ON check_in_activities (activity_id)',
  );
  late final Index emotionsName = Index(
    'emotions_name',
    'CREATE INDEX emotions_name ON emotions (name)',
  );
  late final Index checkInEmotionsCheckInId = Index(
    'check_in_emotions_check_in_id',
    'CREATE INDEX check_in_emotions_check_in_id ON check_in_emotions (check_in_id)',
  );
  late final Index checkInEmotionsEmotionId = Index(
    'check_in_emotions_emotion_id',
    'CREATE INDEX check_in_emotions_emotion_id ON check_in_emotions (emotion_id)',
  );
  late final Index moodSummariesPeriod = Index(
    'mood_summaries_period',
    'CREATE INDEX mood_summaries_period ON mood_summaries (period)',
  );
  late final Index moodSummariesStartDate = Index(
    'mood_summaries_start_date',
    'CREATE INDEX mood_summaries_start_date ON mood_summaries (start_date)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    checkIns,
    journals,
    stats,
    activities,
    checkInActivities,
    emotions,
    checkInEmotions,
    moodSummaries,
    checkInsCreatedAt,
    journalsCreatedAt,
    activitiesName,
    checkInActivitiesCheckInId,
    checkInActivitiesActivityId,
    emotionsName,
    checkInEmotionsCheckInId,
    checkInEmotionsEmotionId,
    moodSummariesPeriod,
    moodSummariesStartDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'check_ins',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('check_in_activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'activities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('check_in_activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'check_ins',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('check_in_emotions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'emotions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('check_in_emotions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CheckInsTableCreateCompanionBuilder =
    CheckInsCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      required MoodType moodType,
      Value<int?> sleepQuality,
      Value<List<String>?> emotionNames,
      Value<List<String>?> activityNames,
      Value<String?> memo,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
      Value<double?> temperature,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
    });
typedef $$CheckInsTableUpdateCompanionBuilder =
    CheckInsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<MoodType> moodType,
      Value<int?> sleepQuality,
      Value<List<String>?> emotionNames,
      Value<List<String>?> activityNames,
      Value<String?> memo,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
      Value<double?> temperature,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
    });

final class $$CheckInsTableReferences
    extends BaseReferences<_$MoodLogDatabase, $CheckInsTable, CheckIn> {
  $$CheckInsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CheckInActivitiesTable, List<CheckInActivity>>
  _checkInActivitiesRefsTable(_$MoodLogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.checkInActivities,
        aliasName: $_aliasNameGenerator(
          db.checkIns.id,
          db.checkInActivities.checkInId,
        ),
      );

  $$CheckInActivitiesTableProcessedTableManager get checkInActivitiesRefs {
    final manager = $$CheckInActivitiesTableTableManager(
      $_db,
      $_db.checkInActivities,
    ).filter((f) => f.checkInId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checkInActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CheckInEmotionsTable, List<CheckInEmotion>>
  _checkInEmotionsRefsTable(_$MoodLogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.checkInEmotions,
        aliasName: $_aliasNameGenerator(
          db.checkIns.id,
          db.checkInEmotions.checkInId,
        ),
      );

  $$CheckInEmotionsTableProcessedTableManager get checkInEmotionsRefs {
    final manager = $$CheckInEmotionsTableTableManager(
      $_db,
      $_db.checkInEmotions,
    ).filter((f) => f.checkInId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checkInEmotionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CheckInsTableFilterComposer
    extends Composer<_$MoodLogDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MoodType, MoodType, int> get moodType =>
      $composableBuilder(
        column: $table.moodType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get emotionNames => $composableBuilder(
    column: $table.emotionNames,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get activityNames => $composableBuilder(
    column: $table.activityNames,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
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

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> checkInActivitiesRefs(
    Expression<bool> Function($$CheckInActivitiesTableFilterComposer f) f,
  ) {
    final $$CheckInActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInActivities,
      getReferencedColumn: (t) => t.checkInId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.checkInActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checkInEmotionsRefs(
    Expression<bool> Function($$CheckInEmotionsTableFilterComposer f) f,
  ) {
    final $$CheckInEmotionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEmotions,
      getReferencedColumn: (t) => t.checkInId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEmotionsTableFilterComposer(
            $db: $db,
            $table: $db.checkInEmotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodType => $composableBuilder(
    column: $table.moodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emotionNames => $composableBuilder(
    column: $table.emotionNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityNames => $composableBuilder(
    column: $table.activityNames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
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

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoodType, int> get moodType =>
      $composableBuilder(column: $table.moodType, builder: (column) => column);

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get emotionNames =>
      $composableBuilder(
        column: $table.emotionNames,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>?, String> get activityNames =>
      $composableBuilder(
        column: $table.activityNames,
        builder: (column) => column,
      );

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => column,
  );

  Expression<T> checkInActivitiesRefs<T extends Object>(
    Expression<T> Function($$CheckInActivitiesTableAnnotationComposer a) f,
  ) {
    final $$CheckInActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.checkInActivities,
          getReferencedColumn: (t) => t.checkInId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CheckInActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.checkInActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> checkInEmotionsRefs<T extends Object>(
    Expression<T> Function($$CheckInEmotionsTableAnnotationComposer a) f,
  ) {
    final $$CheckInEmotionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEmotions,
      getReferencedColumn: (t) => t.checkInId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEmotionsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInEmotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $CheckInsTable,
          CheckIn,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (CheckIn, $$CheckInsTableReferences),
          CheckIn,
          PrefetchHooks Function({
            bool checkInActivitiesRefs,
            bool checkInEmotionsRefs,
          })
        > {
  $$CheckInsTableTableManager(_$MoodLogDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<MoodType> moodType = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                Value<List<String>?> emotionNames = const Value.absent(),
                Value<List<String>?> activityNames = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => CheckInsCompanion(
                id: id,
                createdAt: createdAt,
                moodType: moodType,
                sleepQuality: sleepQuality,
                emotionNames: emotionNames,
                activityNames: activityNames,
                memo: memo,
                latitude: latitude,
                longitude: longitude,
                address: address,
                temperature: temperature,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                required MoodType moodType,
                Value<int?> sleepQuality = const Value.absent(),
                Value<List<String>?> emotionNames = const Value.absent(),
                Value<List<String>?> activityNames = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => CheckInsCompanion.insert(
                id: id,
                createdAt: createdAt,
                moodType: moodType,
                sleepQuality: sleepQuality,
                emotionNames: emotionNames,
                activityNames: activityNames,
                memo: memo,
                latitude: latitude,
                longitude: longitude,
                address: address,
                temperature: temperature,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CheckInsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({checkInActivitiesRefs = false, checkInEmotionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (checkInActivitiesRefs) db.checkInActivities,
                    if (checkInEmotionsRefs) db.checkInEmotions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (checkInActivitiesRefs)
                        await $_getPrefetchedData<
                          CheckIn,
                          $CheckInsTable,
                          CheckInActivity
                        >(
                          currentTable: table,
                          referencedTable: $$CheckInsTableReferences
                              ._checkInActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CheckInsTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.checkInId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (checkInEmotionsRefs)
                        await $_getPrefetchedData<
                          CheckIn,
                          $CheckInsTable,
                          CheckInEmotion
                        >(
                          currentTable: table,
                          referencedTable: $$CheckInsTableReferences
                              ._checkInEmotionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CheckInsTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInEmotionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.checkInId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $CheckInsTable,
      CheckIn,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (CheckIn, $$CheckInsTableReferences),
      CheckIn,
      PrefetchHooks Function({
        bool checkInActivitiesRefs,
        bool checkInEmotionsRefs,
      })
    >;
typedef $$JournalsTableCreateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      required String content,
      Value<List<String>?> imageUri,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
      Value<double?> temperature,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
    });
typedef $$JournalsTableUpdateCompanionBuilder =
    JournalsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String> content,
      Value<List<String>?> imageUri,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> address,
      Value<double?> temperature,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get imageUri => $composableBuilder(
    column: $table.imageUri,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUri => $composableBuilder(
    column: $table.imageUri,
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

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get imageUri =>
      $composableBuilder(column: $table.imageUri, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => column,
  );
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
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<List<String>?> imageUri = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => JournalsCompanion(
                id: id,
                createdAt: createdAt,
                content: content,
                imageUri: imageUri,
                latitude: latitude,
                longitude: longitude,
                address: address,
                temperature: temperature,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                required String content,
                Value<List<String>?> imageUri = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => JournalsCompanion.insert(
                id: id,
                createdAt: createdAt,
                content: content,
                imageUri: imageUri,
                latitude: latitude,
                longitude: longitude,
                address: address,
                temperature: temperature,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
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
typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> color,
      Value<DateTime> createdAt,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> color,
      Value<DateTime> createdAt,
    });

final class $$ActivitiesTableReferences
    extends BaseReferences<_$MoodLogDatabase, $ActivitiesTable, Activity> {
  $$ActivitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CheckInActivitiesTable, List<CheckInActivity>>
  _checkInActivitiesRefsTable(_$MoodLogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.checkInActivities,
        aliasName: $_aliasNameGenerator(
          db.activities.id,
          db.checkInActivities.activityId,
        ),
      );

  $$CheckInActivitiesTableProcessedTableManager get checkInActivitiesRefs {
    final manager = $$CheckInActivitiesTableTableManager(
      $_db,
      $_db.checkInActivities,
    ).filter((f) => f.activityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checkInActivitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ActivitiesTableFilterComposer
    extends Composer<_$MoodLogDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> checkInActivitiesRefs(
    Expression<bool> Function($$CheckInActivitiesTableFilterComposer f) f,
  ) {
    final $$CheckInActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInActivities,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.checkInActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> checkInActivitiesRefs<T extends Object>(
    Expression<T> Function($$CheckInActivitiesTableAnnotationComposer a) f,
  ) {
    final $$CheckInActivitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.checkInActivities,
          getReferencedColumn: (t) => t.activityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CheckInActivitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.checkInActivities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, $$ActivitiesTableReferences),
          Activity,
          PrefetchHooks Function({bool checkInActivitiesRefs})
        > {
  $$ActivitiesTableTableManager(_$MoodLogDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ActivitiesCompanion(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({checkInActivitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (checkInActivitiesRefs) db.checkInActivities,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInActivitiesRefs)
                    await $_getPrefetchedData<
                      Activity,
                      $ActivitiesTable,
                      CheckInActivity
                    >(
                      currentTable: table,
                      referencedTable: $$ActivitiesTableReferences
                          ._checkInActivitiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ActivitiesTableReferences(
                            db,
                            table,
                            p0,
                          ).checkInActivitiesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.activityId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, $$ActivitiesTableReferences),
      Activity,
      PrefetchHooks Function({bool checkInActivitiesRefs})
    >;
typedef $$CheckInActivitiesTableCreateCompanionBuilder =
    CheckInActivitiesCompanion Function({
      Value<int> id,
      required int checkInId,
      required int activityId,
      Value<DateTime> createdAt,
    });
typedef $$CheckInActivitiesTableUpdateCompanionBuilder =
    CheckInActivitiesCompanion Function({
      Value<int> id,
      Value<int> checkInId,
      Value<int> activityId,
      Value<DateTime> createdAt,
    });

final class $$CheckInActivitiesTableReferences
    extends
        BaseReferences<
          _$MoodLogDatabase,
          $CheckInActivitiesTable,
          CheckInActivity
        > {
  $$CheckInActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CheckInsTable _checkInIdTable(_$MoodLogDatabase db) =>
      db.checkIns.createAlias(
        $_aliasNameGenerator(db.checkInActivities.checkInId, db.checkIns.id),
      );

  $$CheckInsTableProcessedTableManager get checkInId {
    final $_column = $_itemColumn<int>('check_in_id')!;

    final manager = $$CheckInsTableTableManager(
      $_db,
      $_db.checkIns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_checkInIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ActivitiesTable _activityIdTable(_$MoodLogDatabase db) =>
      db.activities.createAlias(
        $_aliasNameGenerator(db.checkInActivities.activityId, db.activities.id),
      );

  $$ActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<int>('activity_id')!;

    final manager = $$ActivitiesTableTableManager(
      $_db,
      $_db.activities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CheckInActivitiesTableFilterComposer
    extends Composer<_$MoodLogDatabase, $CheckInActivitiesTable> {
  $$CheckInActivitiesTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CheckInsTableFilterComposer get checkInId {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableFilterComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActivitiesTableFilterComposer get activityId {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInActivitiesTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $CheckInActivitiesTable> {
  $$CheckInActivitiesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CheckInsTableOrderingComposer get checkInId {
    final $$CheckInsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableOrderingComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActivitiesTableOrderingComposer get activityId {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableOrderingComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInActivitiesTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $CheckInActivitiesTable> {
  $$CheckInActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CheckInsTableAnnotationComposer get checkInId {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ActivitiesTableAnnotationComposer get activityId {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInActivitiesTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $CheckInActivitiesTable,
          CheckInActivity,
          $$CheckInActivitiesTableFilterComposer,
          $$CheckInActivitiesTableOrderingComposer,
          $$CheckInActivitiesTableAnnotationComposer,
          $$CheckInActivitiesTableCreateCompanionBuilder,
          $$CheckInActivitiesTableUpdateCompanionBuilder,
          (CheckInActivity, $$CheckInActivitiesTableReferences),
          CheckInActivity,
          PrefetchHooks Function({bool checkInId, bool activityId})
        > {
  $$CheckInActivitiesTableTableManager(
    _$MoodLogDatabase db,
    $CheckInActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInActivitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> checkInId = const Value.absent(),
                Value<int> activityId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CheckInActivitiesCompanion(
                id: id,
                checkInId: checkInId,
                activityId: activityId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int checkInId,
                required int activityId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CheckInActivitiesCompanion.insert(
                id: id,
                checkInId: checkInId,
                activityId: activityId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CheckInActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({checkInId = false, activityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (checkInId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.checkInId,
                                referencedTable:
                                    $$CheckInActivitiesTableReferences
                                        ._checkInIdTable(db),
                                referencedColumn:
                                    $$CheckInActivitiesTableReferences
                                        ._checkInIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (activityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activityId,
                                referencedTable:
                                    $$CheckInActivitiesTableReferences
                                        ._activityIdTable(db),
                                referencedColumn:
                                    $$CheckInActivitiesTableReferences
                                        ._activityIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CheckInActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $CheckInActivitiesTable,
      CheckInActivity,
      $$CheckInActivitiesTableFilterComposer,
      $$CheckInActivitiesTableOrderingComposer,
      $$CheckInActivitiesTableAnnotationComposer,
      $$CheckInActivitiesTableCreateCompanionBuilder,
      $$CheckInActivitiesTableUpdateCompanionBuilder,
      (CheckInActivity, $$CheckInActivitiesTableReferences),
      CheckInActivity,
      PrefetchHooks Function({bool checkInId, bool activityId})
    >;
typedef $$EmotionsTableCreateCompanionBuilder =
    EmotionsCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
    });
typedef $$EmotionsTableUpdateCompanionBuilder =
    EmotionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

final class $$EmotionsTableReferences
    extends BaseReferences<_$MoodLogDatabase, $EmotionsTable, Emotion> {
  $$EmotionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CheckInEmotionsTable, List<CheckInEmotion>>
  _checkInEmotionsRefsTable(_$MoodLogDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.checkInEmotions,
        aliasName: $_aliasNameGenerator(
          db.emotions.id,
          db.checkInEmotions.emotionId,
        ),
      );

  $$CheckInEmotionsTableProcessedTableManager get checkInEmotionsRefs {
    final manager = $$CheckInEmotionsTableTableManager(
      $_db,
      $_db.checkInEmotions,
    ).filter((f) => f.emotionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checkInEmotionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmotionsTableFilterComposer
    extends Composer<_$MoodLogDatabase, $EmotionsTable> {
  $$EmotionsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> checkInEmotionsRefs(
    Expression<bool> Function($$CheckInEmotionsTableFilterComposer f) f,
  ) {
    final $$CheckInEmotionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEmotions,
      getReferencedColumn: (t) => t.emotionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEmotionsTableFilterComposer(
            $db: $db,
            $table: $db.checkInEmotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmotionsTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $EmotionsTable> {
  $$EmotionsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmotionsTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $EmotionsTable> {
  $$EmotionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> checkInEmotionsRefs<T extends Object>(
    Expression<T> Function($$CheckInEmotionsTableAnnotationComposer a) f,
  ) {
    final $$CheckInEmotionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkInEmotions,
      getReferencedColumn: (t) => t.emotionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInEmotionsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkInEmotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmotionsTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $EmotionsTable,
          Emotion,
          $$EmotionsTableFilterComposer,
          $$EmotionsTableOrderingComposer,
          $$EmotionsTableAnnotationComposer,
          $$EmotionsTableCreateCompanionBuilder,
          $$EmotionsTableUpdateCompanionBuilder,
          (Emotion, $$EmotionsTableReferences),
          Emotion,
          PrefetchHooks Function({bool checkInEmotionsRefs})
        > {
  $$EmotionsTableTableManager(_$MoodLogDatabase db, $EmotionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmotionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmotionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmotionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmotionsCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmotionsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmotionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({checkInEmotionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (checkInEmotionsRefs) db.checkInEmotions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInEmotionsRefs)
                    await $_getPrefetchedData<
                      Emotion,
                      $EmotionsTable,
                      CheckInEmotion
                    >(
                      currentTable: table,
                      referencedTable: $$EmotionsTableReferences
                          ._checkInEmotionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$EmotionsTableReferences(
                        db,
                        table,
                        p0,
                      ).checkInEmotionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.emotionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EmotionsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $EmotionsTable,
      Emotion,
      $$EmotionsTableFilterComposer,
      $$EmotionsTableOrderingComposer,
      $$EmotionsTableAnnotationComposer,
      $$EmotionsTableCreateCompanionBuilder,
      $$EmotionsTableUpdateCompanionBuilder,
      (Emotion, $$EmotionsTableReferences),
      Emotion,
      PrefetchHooks Function({bool checkInEmotionsRefs})
    >;
typedef $$CheckInEmotionsTableCreateCompanionBuilder =
    CheckInEmotionsCompanion Function({
      Value<int> id,
      required int checkInId,
      required int emotionId,
      Value<DateTime> createdAt,
    });
typedef $$CheckInEmotionsTableUpdateCompanionBuilder =
    CheckInEmotionsCompanion Function({
      Value<int> id,
      Value<int> checkInId,
      Value<int> emotionId,
      Value<DateTime> createdAt,
    });

final class $$CheckInEmotionsTableReferences
    extends
        BaseReferences<
          _$MoodLogDatabase,
          $CheckInEmotionsTable,
          CheckInEmotion
        > {
  $$CheckInEmotionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CheckInsTable _checkInIdTable(_$MoodLogDatabase db) =>
      db.checkIns.createAlias(
        $_aliasNameGenerator(db.checkInEmotions.checkInId, db.checkIns.id),
      );

  $$CheckInsTableProcessedTableManager get checkInId {
    final $_column = $_itemColumn<int>('check_in_id')!;

    final manager = $$CheckInsTableTableManager(
      $_db,
      $_db.checkIns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_checkInIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EmotionsTable _emotionIdTable(_$MoodLogDatabase db) =>
      db.emotions.createAlias(
        $_aliasNameGenerator(db.checkInEmotions.emotionId, db.emotions.id),
      );

  $$EmotionsTableProcessedTableManager get emotionId {
    final $_column = $_itemColumn<int>('emotion_id')!;

    final manager = $$EmotionsTableTableManager(
      $_db,
      $_db.emotions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_emotionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CheckInEmotionsTableFilterComposer
    extends Composer<_$MoodLogDatabase, $CheckInEmotionsTable> {
  $$CheckInEmotionsTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CheckInsTableFilterComposer get checkInId {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableFilterComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmotionsTableFilterComposer get emotionId {
    final $$EmotionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emotionId,
      referencedTable: $db.emotions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmotionsTableFilterComposer(
            $db: $db,
            $table: $db.emotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInEmotionsTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $CheckInEmotionsTable> {
  $$CheckInEmotionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CheckInsTableOrderingComposer get checkInId {
    final $$CheckInsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableOrderingComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmotionsTableOrderingComposer get emotionId {
    final $$EmotionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emotionId,
      referencedTable: $db.emotions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmotionsTableOrderingComposer(
            $db: $db,
            $table: $db.emotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInEmotionsTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $CheckInEmotionsTable> {
  $$CheckInEmotionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CheckInsTableAnnotationComposer get checkInId {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.checkInId,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmotionsTableAnnotationComposer get emotionId {
    final $$EmotionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emotionId,
      referencedTable: $db.emotions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmotionsTableAnnotationComposer(
            $db: $db,
            $table: $db.emotions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInEmotionsTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $CheckInEmotionsTable,
          CheckInEmotion,
          $$CheckInEmotionsTableFilterComposer,
          $$CheckInEmotionsTableOrderingComposer,
          $$CheckInEmotionsTableAnnotationComposer,
          $$CheckInEmotionsTableCreateCompanionBuilder,
          $$CheckInEmotionsTableUpdateCompanionBuilder,
          (CheckInEmotion, $$CheckInEmotionsTableReferences),
          CheckInEmotion,
          PrefetchHooks Function({bool checkInId, bool emotionId})
        > {
  $$CheckInEmotionsTableTableManager(
    _$MoodLogDatabase db,
    $CheckInEmotionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInEmotionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInEmotionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInEmotionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> checkInId = const Value.absent(),
                Value<int> emotionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CheckInEmotionsCompanion(
                id: id,
                checkInId: checkInId,
                emotionId: emotionId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int checkInId,
                required int emotionId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CheckInEmotionsCompanion.insert(
                id: id,
                checkInId: checkInId,
                emotionId: emotionId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CheckInEmotionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({checkInId = false, emotionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (checkInId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.checkInId,
                                referencedTable:
                                    $$CheckInEmotionsTableReferences
                                        ._checkInIdTable(db),
                                referencedColumn:
                                    $$CheckInEmotionsTableReferences
                                        ._checkInIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (emotionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.emotionId,
                                referencedTable:
                                    $$CheckInEmotionsTableReferences
                                        ._emotionIdTable(db),
                                referencedColumn:
                                    $$CheckInEmotionsTableReferences
                                        ._emotionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CheckInEmotionsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $CheckInEmotionsTable,
      CheckInEmotion,
      $$CheckInEmotionsTableFilterComposer,
      $$CheckInEmotionsTableOrderingComposer,
      $$CheckInEmotionsTableAnnotationComposer,
      $$CheckInEmotionsTableCreateCompanionBuilder,
      $$CheckInEmotionsTableUpdateCompanionBuilder,
      (CheckInEmotion, $$CheckInEmotionsTableReferences),
      CheckInEmotion,
      PrefetchHooks Function({bool checkInId, bool emotionId})
    >;
typedef $$MoodSummariesTableCreateCompanionBuilder =
    MoodSummariesCompanion Function({
      Value<int> id,
      required MoodSummaryPeriod period,
      required DateTime startDate,
      required DateTime endDate,
      required DateTime generatedAt,
      required String emotionalFlow,
      required String dominantMoods,
      required String activityPatterns,
      required String personalAdvice,
      required String keyPoints,
      required Map<String, dynamic> metadata,
    });
typedef $$MoodSummariesTableUpdateCompanionBuilder =
    MoodSummariesCompanion Function({
      Value<int> id,
      Value<MoodSummaryPeriod> period,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<DateTime> generatedAt,
      Value<String> emotionalFlow,
      Value<String> dominantMoods,
      Value<String> activityPatterns,
      Value<String> personalAdvice,
      Value<String> keyPoints,
      Value<Map<String, dynamic>> metadata,
    });

class $$MoodSummariesTableFilterComposer
    extends Composer<_$MoodLogDatabase, $MoodSummariesTable> {
  $$MoodSummariesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<MoodSummaryPeriod, MoodSummaryPeriod, int>
  get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emotionalFlow => $composableBuilder(
    column: $table.emotionalFlow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dominantMoods => $composableBuilder(
    column: $table.dominantMoods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityPatterns => $composableBuilder(
    column: $table.activityPatterns,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalAdvice => $composableBuilder(
    column: $table.personalAdvice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyPoints => $composableBuilder(
    column: $table.keyPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$MoodSummariesTableOrderingComposer
    extends Composer<_$MoodLogDatabase, $MoodSummariesTable> {
  $$MoodSummariesTableOrderingComposer({
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

  ColumnOrderings<int> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emotionalFlow => $composableBuilder(
    column: $table.emotionalFlow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dominantMoods => $composableBuilder(
    column: $table.dominantMoods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityPatterns => $composableBuilder(
    column: $table.activityPatterns,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalAdvice => $composableBuilder(
    column: $table.personalAdvice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyPoints => $composableBuilder(
    column: $table.keyPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoodSummariesTableAnnotationComposer
    extends Composer<_$MoodLogDatabase, $MoodSummariesTable> {
  $$MoodSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoodSummaryPeriod, int> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emotionalFlow => $composableBuilder(
    column: $table.emotionalFlow,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dominantMoods => $composableBuilder(
    column: $table.dominantMoods,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityPatterns => $composableBuilder(
    column: $table.activityPatterns,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalAdvice => $composableBuilder(
    column: $table.personalAdvice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keyPoints =>
      $composableBuilder(column: $table.keyPoints, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$MoodSummariesTableTableManager
    extends
        RootTableManager<
          _$MoodLogDatabase,
          $MoodSummariesTable,
          MoodSummary,
          $$MoodSummariesTableFilterComposer,
          $$MoodSummariesTableOrderingComposer,
          $$MoodSummariesTableAnnotationComposer,
          $$MoodSummariesTableCreateCompanionBuilder,
          $$MoodSummariesTableUpdateCompanionBuilder,
          (
            MoodSummary,
            BaseReferences<_$MoodLogDatabase, $MoodSummariesTable, MoodSummary>,
          ),
          MoodSummary,
          PrefetchHooks Function()
        > {
  $$MoodSummariesTableTableManager(
    _$MoodLogDatabase db,
    $MoodSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodSummariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MoodSummaryPeriod> period = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> emotionalFlow = const Value.absent(),
                Value<String> dominantMoods = const Value.absent(),
                Value<String> activityPatterns = const Value.absent(),
                Value<String> personalAdvice = const Value.absent(),
                Value<String> keyPoints = const Value.absent(),
                Value<Map<String, dynamic>> metadata = const Value.absent(),
              }) => MoodSummariesCompanion(
                id: id,
                period: period,
                startDate: startDate,
                endDate: endDate,
                generatedAt: generatedAt,
                emotionalFlow: emotionalFlow,
                dominantMoods: dominantMoods,
                activityPatterns: activityPatterns,
                personalAdvice: personalAdvice,
                keyPoints: keyPoints,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MoodSummaryPeriod period,
                required DateTime startDate,
                required DateTime endDate,
                required DateTime generatedAt,
                required String emotionalFlow,
                required String dominantMoods,
                required String activityPatterns,
                required String personalAdvice,
                required String keyPoints,
                required Map<String, dynamic> metadata,
              }) => MoodSummariesCompanion.insert(
                id: id,
                period: period,
                startDate: startDate,
                endDate: endDate,
                generatedAt: generatedAt,
                emotionalFlow: emotionalFlow,
                dominantMoods: dominantMoods,
                activityPatterns: activityPatterns,
                personalAdvice: personalAdvice,
                keyPoints: keyPoints,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoodSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogDatabase,
      $MoodSummariesTable,
      MoodSummary,
      $$MoodSummariesTableFilterComposer,
      $$MoodSummariesTableOrderingComposer,
      $$MoodSummariesTableAnnotationComposer,
      $$MoodSummariesTableCreateCompanionBuilder,
      $$MoodSummariesTableUpdateCompanionBuilder,
      (
        MoodSummary,
        BaseReferences<_$MoodLogDatabase, $MoodSummariesTable, MoodSummary>,
      ),
      MoodSummary,
      PrefetchHooks Function()
    >;

class $MoodLogDatabaseManager {
  final _$MoodLogDatabase _db;
  $MoodLogDatabaseManager(this._db);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
  $$JournalsTableTableManager get journals =>
      $$JournalsTableTableManager(_db, _db.journals);
  $$StatsTableTableManager get stats =>
      $$StatsTableTableManager(_db, _db.stats);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$CheckInActivitiesTableTableManager get checkInActivities =>
      $$CheckInActivitiesTableTableManager(_db, _db.checkInActivities);
  $$EmotionsTableTableManager get emotions =>
      $$EmotionsTableTableManager(_db, _db.emotions);
  $$CheckInEmotionsTableTableManager get checkInEmotions =>
      $$CheckInEmotionsTableTableManager(_db, _db.checkInEmotions);
  $$MoodSummariesTableTableManager get moodSummaries =>
      $$MoodSummariesTableTableManager(_db, _db.moodSummaries);
}
