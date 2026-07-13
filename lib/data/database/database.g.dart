// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('General'),
  );
  static const VerificationMeta _targetHourMeta = const VerificationMeta(
    'targetHour',
  );
  @override
  late final GeneratedColumn<int> targetHour = GeneratedColumn<int>(
    'target_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _targetMinuteMeta = const VerificationMeta(
    'targetMinute',
  );
  @override
  late final GeneratedColumn<int> targetMinute = GeneratedColumn<int>(
    'target_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FrequencyType, String> frequency =
      GeneratedColumn<String>(
        'frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('daily'),
      ).withConverter<FrequencyType>($HabitsTable.$converterfrequency);
  static const VerificationMeta _weekdaysMaskMeta = const VerificationMeta(
    'weekdaysMask',
  );
  @override
  late final GeneratedColumn<int> weekdaysMask = GeneratedColumn<int>(
    'weekdays_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(127),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF6750A4),
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    targetHour,
    targetMinute,
    frequency,
    weekdaysMask,
    intervalDays,
    colorValue,
    reminderEnabled,
    createdAt,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('target_hour')) {
      context.handle(
        _targetHourMeta,
        targetHour.isAcceptableOrUnknown(data['target_hour']!, _targetHourMeta),
      );
    }
    if (data.containsKey('target_minute')) {
      context.handle(
        _targetMinuteMeta,
        targetMinute.isAcceptableOrUnknown(
          data['target_minute']!,
          _targetMinuteMeta,
        ),
      );
    }
    if (data.containsKey('weekdays_mask')) {
      context.handle(
        _weekdaysMaskMeta,
        weekdaysMask.isAcceptableOrUnknown(
          data['weekdays_mask']!,
          _weekdaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      targetHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_hour'],
      )!,
      targetMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_minute'],
      )!,
      frequency: $HabitsTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      weekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays_mask'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FrequencyType, String, String> $converterfrequency =
      const EnumNameConverter<FrequencyType>(FrequencyType.values);
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String category;

  /// Target execution time-of-day (FR-1.1), split so it survives timezone
  /// changes without shifting the wall-clock reminder.
  final int targetHour;
  final int targetMinute;

  /// Frequency (FR-1.2). For [FrequencyType.weekly] the active days live in
  /// [weekdaysMask]; [FrequencyType.interval] uses [intervalDays].
  final FrequencyType frequency;
  final int weekdaysMask;
  final int intervalDays;

  /// ARGB colour used to colour-code the calendar (FR-3.1).
  final int colorValue;
  final bool reminderEnabled;
  final DateTime createdAt;
  final bool isArchived;
  const Habit({
    required this.id,
    required this.name,
    required this.category,
    required this.targetHour,
    required this.targetMinute,
    required this.frequency,
    required this.weekdaysMask,
    required this.intervalDays,
    required this.colorValue,
    required this.reminderEnabled,
    required this.createdAt,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['target_hour'] = Variable<int>(targetHour);
    map['target_minute'] = Variable<int>(targetMinute);
    {
      map['frequency'] = Variable<String>(
        $HabitsTable.$converterfrequency.toSql(frequency),
      );
    }
    map['weekdays_mask'] = Variable<int>(weekdaysMask);
    map['interval_days'] = Variable<int>(intervalDays);
    map['color_value'] = Variable<int>(colorValue);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      targetHour: Value(targetHour),
      targetMinute: Value(targetMinute),
      frequency: Value(frequency),
      weekdaysMask: Value(weekdaysMask),
      intervalDays: Value(intervalDays),
      colorValue: Value(colorValue),
      reminderEnabled: Value(reminderEnabled),
      createdAt: Value(createdAt),
      isArchived: Value(isArchived),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      targetHour: serializer.fromJson<int>(json['targetHour']),
      targetMinute: serializer.fromJson<int>(json['targetMinute']),
      frequency: $HabitsTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      weekdaysMask: serializer.fromJson<int>(json['weekdaysMask']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'targetHour': serializer.toJson<int>(targetHour),
      'targetMinute': serializer.toJson<int>(targetMinute),
      'frequency': serializer.toJson<String>(
        $HabitsTable.$converterfrequency.toJson(frequency),
      ),
      'weekdaysMask': serializer.toJson<int>(weekdaysMask),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'colorValue': serializer.toJson<int>(colorValue),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Habit copyWith({
    int? id,
    String? name,
    String? category,
    int? targetHour,
    int? targetMinute,
    FrequencyType? frequency,
    int? weekdaysMask,
    int? intervalDays,
    int? colorValue,
    bool? reminderEnabled,
    DateTime? createdAt,
    bool? isArchived,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    targetHour: targetHour ?? this.targetHour,
    targetMinute: targetMinute ?? this.targetMinute,
    frequency: frequency ?? this.frequency,
    weekdaysMask: weekdaysMask ?? this.weekdaysMask,
    intervalDays: intervalDays ?? this.intervalDays,
    colorValue: colorValue ?? this.colorValue,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    createdAt: createdAt ?? this.createdAt,
    isArchived: isArchived ?? this.isArchived,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      targetHour: data.targetHour.present
          ? data.targetHour.value
          : this.targetHour,
      targetMinute: data.targetMinute.present
          ? data.targetMinute.value
          : this.targetMinute,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      weekdaysMask: data.weekdaysMask.present
          ? data.weekdaysMask.value
          : this.weekdaysMask,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('targetHour: $targetHour, ')
          ..write('targetMinute: $targetMinute, ')
          ..write('frequency: $frequency, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('colorValue: $colorValue, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    targetHour,
    targetMinute,
    frequency,
    weekdaysMask,
    intervalDays,
    colorValue,
    reminderEnabled,
    createdAt,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.targetHour == this.targetHour &&
          other.targetMinute == this.targetMinute &&
          other.frequency == this.frequency &&
          other.weekdaysMask == this.weekdaysMask &&
          other.intervalDays == this.intervalDays &&
          other.colorValue == this.colorValue &&
          other.reminderEnabled == this.reminderEnabled &&
          other.createdAt == this.createdAt &&
          other.isArchived == this.isArchived);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<int> targetHour;
  final Value<int> targetMinute;
  final Value<FrequencyType> frequency;
  final Value<int> weekdaysMask;
  final Value<int> intervalDays;
  final Value<int> colorValue;
  final Value<bool> reminderEnabled;
  final Value<DateTime> createdAt;
  final Value<bool> isArchived;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.targetHour = const Value.absent(),
    this.targetMinute = const Value.absent(),
    this.frequency = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.targetHour = const Value.absent(),
    this.targetMinute = const Value.absent(),
    this.frequency = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? targetHour,
    Expression<int>? targetMinute,
    Expression<String>? frequency,
    Expression<int>? weekdaysMask,
    Expression<int>? intervalDays,
    Expression<int>? colorValue,
    Expression<bool>? reminderEnabled,
    Expression<DateTime>? createdAt,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (targetHour != null) 'target_hour': targetHour,
      if (targetMinute != null) 'target_minute': targetMinute,
      if (frequency != null) 'frequency': frequency,
      if (weekdaysMask != null) 'weekdays_mask': weekdaysMask,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (colorValue != null) 'color_value': colorValue,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<int>? targetHour,
    Value<int>? targetMinute,
    Value<FrequencyType>? frequency,
    Value<int>? weekdaysMask,
    Value<int>? intervalDays,
    Value<int>? colorValue,
    Value<bool>? reminderEnabled,
    Value<DateTime>? createdAt,
    Value<bool>? isArchived,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      targetHour: targetHour ?? this.targetHour,
      targetMinute: targetMinute ?? this.targetMinute,
      frequency: frequency ?? this.frequency,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      intervalDays: intervalDays ?? this.intervalDays,
      colorValue: colorValue ?? this.colorValue,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      createdAt: createdAt ?? this.createdAt,
      isArchived: isArchived ?? this.isArchived,
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
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (targetHour.present) {
      map['target_hour'] = Variable<int>(targetHour.value);
    }
    if (targetMinute.present) {
      map['target_minute'] = Variable<int>(targetMinute.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(
        $HabitsTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (weekdaysMask.present) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('targetHour: $targetHour, ')
          ..write('targetMinute: $targetMinute, ')
          ..write('frequency: $frequency, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('colorValue: $colorValue, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LogStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LogStatus>($HabitLogsTable.$converterstatus);
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, habitId, date, status, loggedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {habitId, date},
  ];
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      status: $HabitLogsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LogStatus, String, String> $converterstatus =
      const EnumNameConverter<LogStatus>(LogStatus.values);
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final int id;
  final int habitId;

  /// The calendar day this log belongs to (normalised to local midnight).
  final DateTime date;
  final LogStatus status;

  /// Exact moment the user recorded the status (FR-3.2 timestamp).
  final DateTime loggedAt;
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['date'] = Variable<DateTime>(date);
    {
      map['status'] = Variable<String>(
        $HabitLogsTable.$converterstatus.toSql(status),
      );
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      status: Value(status),
      loggedAt: Value(loggedAt),
    );
  }

  factory HabitLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: $HabitLogsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(
        $HabitLogsTable.$converterstatus.toJson(status),
      ),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  HabitLog copyWith({
    int? id,
    int? habitId,
    DateTime? date,
    LogStatus? status,
    DateTime? loggedAt,
  }) => HabitLog(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    date: date ?? this.date,
    status: status ?? this.status,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, date, status, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.status == this.status &&
          other.loggedAt == this.loggedAt);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<DateTime> date;
  final Value<LogStatus> status;
  final Value<DateTime> loggedAt;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required DateTime date,
    required LogStatus status,
    this.loggedAt = const Value.absent(),
  }) : habitId = Value(habitId),
       date = Value(date),
       status = Value(status);
  static Insertable<HabitLog> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  HabitLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<DateTime>? date,
    Value<LogStatus>? status,
    Value<DateTime>? loggedAt,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $HabitLogsTable.$converterstatus.toSql(status.value),
      );
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startValueMeta = const VerificationMeta(
    'startValue',
  );
  @override
  late final GeneratedColumn<double> startValue = GeneratedColumn<double>(
    'start_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
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
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    startValue,
    targetValue,
    unit,
    startDate,
    endDate,
    createdAt,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_value')) {
      context.handle(
        _startValueMeta,
        startValue.isAcceptableOrUnknown(data['start_value']!, _startValueMeta),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_value'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final String name;
  final String? description;

  /// Starting point and ending point/target, measured in [unit].
  final double startValue;
  final double targetValue;
  final String unit;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final bool isArchived;
  const Goal({
    required this.id,
    required this.name,
    this.description,
    required this.startValue,
    required this.targetValue,
    required this.unit,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_value'] = Variable<double>(startValue);
    map['target_value'] = Variable<double>(targetValue);
    map['unit'] = Variable<String>(unit);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startValue: Value(startValue),
      targetValue: Value(targetValue),
      unit: Value(unit),
      startDate: Value(startDate),
      endDate: Value(endDate),
      createdAt: Value(createdAt),
      isArchived: Value(isArchived),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startValue: serializer.fromJson<double>(json['startValue']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      unit: serializer.fromJson<String>(json['unit']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'startValue': serializer.toJson<double>(startValue),
      'targetValue': serializer.toJson<double>(targetValue),
      'unit': serializer.toJson<String>(unit),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Goal copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    double? startValue,
    double? targetValue,
    String? unit,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isArchived,
  }) => Goal(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    startValue: startValue ?? this.startValue,
    targetValue: targetValue ?? this.targetValue,
    unit: unit ?? this.unit,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    createdAt: createdAt ?? this.createdAt,
    isArchived: isArchived ?? this.isArchived,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      startValue: data.startValue.present
          ? data.startValue.value
          : this.startValue,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startValue: $startValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('unit: $unit, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    startValue,
    targetValue,
    unit,
    startDate,
    endDate,
    createdAt,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startValue == this.startValue &&
          other.targetValue == this.targetValue &&
          other.unit == this.unit &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.isArchived == this.isArchived);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> startValue;
  final Value<double> targetValue;
  final Value<String> unit;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<DateTime> createdAt;
  final Value<bool> isArchived;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startValue = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.startValue = const Value.absent(),
    required double targetValue,
    this.unit = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
  }) : name = Value(name),
       targetValue = Value(targetValue),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? startValue,
    Expression<double>? targetValue,
    Expression<String>? unit,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startValue != null) 'start_value': startValue,
      if (targetValue != null) 'target_value': targetValue,
      if (unit != null) 'unit': unit,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  GoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? startValue,
    Value<double>? targetValue,
    Value<String>? unit,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<DateTime>? createdAt,
    Value<bool>? isArchived,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startValue: startValue ?? this.startValue,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      isArchived: isArchived ?? this.isArchived,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startValue.present) {
      map['start_value'] = Variable<double>(startValue.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startValue: $startValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('unit: $unit, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $DeliverablesTable extends Deliverables
    with TableInfo<$DeliverablesTable, Deliverable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliverablesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FrequencyType, String> frequency =
      GeneratedColumn<String>(
        'frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('daily'),
      ).withConverter<FrequencyType>($DeliverablesTable.$converterfrequency);
  static const VerificationMeta _weekdaysMaskMeta = const VerificationMeta(
    'weekdaysMask',
  );
  @override
  late final GeneratedColumn<int> weekdaysMask = GeneratedColumn<int>(
    'weekdays_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(127),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _inputLabelMeta = const VerificationMeta(
    'inputLabel',
  );
  @override
  late final GeneratedColumn<String> inputLabel = GeneratedColumn<String>(
    'input_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Value'),
  );
  static const VerificationMeta _inputUnitMeta = const VerificationMeta(
    'inputUnit',
  );
  @override
  late final GeneratedColumn<String> inputUnit = GeneratedColumn<String>(
    'input_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _targetInputMeta = const VerificationMeta(
    'targetInput',
  );
  @override
  late final GeneratedColumn<double> targetInput = GeneratedColumn<double>(
    'target_input',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    goalId,
    name,
    frequency,
    weekdaysMask,
    intervalDays,
    inputLabel,
    inputUnit,
    targetInput,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deliverables';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deliverable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weekdays_mask')) {
      context.handle(
        _weekdaysMaskMeta,
        weekdaysMask.isAcceptableOrUnknown(
          data['weekdays_mask']!,
          _weekdaysMaskMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('input_label')) {
      context.handle(
        _inputLabelMeta,
        inputLabel.isAcceptableOrUnknown(data['input_label']!, _inputLabelMeta),
      );
    }
    if (data.containsKey('input_unit')) {
      context.handle(
        _inputUnitMeta,
        inputUnit.isAcceptableOrUnknown(data['input_unit']!, _inputUnitMeta),
      );
    }
    if (data.containsKey('target_input')) {
      context.handle(
        _targetInputMeta,
        targetInput.isAcceptableOrUnknown(
          data['target_input']!,
          _targetInputMeta,
        ),
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
  Deliverable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deliverable(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      frequency: $DeliverablesTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      weekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays_mask'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      inputLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_label'],
      )!,
      inputUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_unit'],
      )!,
      targetInput: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_input'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DeliverablesTable createAlias(String alias) {
    return $DeliverablesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FrequencyType, String, String> $converterfrequency =
      const EnumNameConverter<FrequencyType>(FrequencyType.values);
}

class Deliverable extends DataClass implements Insertable<Deliverable> {
  final int id;
  final int goalId;
  final String name;
  final FrequencyType frequency;
  final int weekdaysMask;
  final int intervalDays;

  /// Prompt + unit for the expected input (FR-5.1), e.g. "Duration"/"minutes".
  final String inputLabel;
  final String inputUnit;

  /// Optional per-instance target for the metric (e.g. 3 km).
  final double? targetInput;
  final DateTime createdAt;
  const Deliverable({
    required this.id,
    required this.goalId,
    required this.name,
    required this.frequency,
    required this.weekdaysMask,
    required this.intervalDays,
    required this.inputLabel,
    required this.inputUnit,
    this.targetInput,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['goal_id'] = Variable<int>(goalId);
    map['name'] = Variable<String>(name);
    {
      map['frequency'] = Variable<String>(
        $DeliverablesTable.$converterfrequency.toSql(frequency),
      );
    }
    map['weekdays_mask'] = Variable<int>(weekdaysMask);
    map['interval_days'] = Variable<int>(intervalDays);
    map['input_label'] = Variable<String>(inputLabel);
    map['input_unit'] = Variable<String>(inputUnit);
    if (!nullToAbsent || targetInput != null) {
      map['target_input'] = Variable<double>(targetInput);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DeliverablesCompanion toCompanion(bool nullToAbsent) {
    return DeliverablesCompanion(
      id: Value(id),
      goalId: Value(goalId),
      name: Value(name),
      frequency: Value(frequency),
      weekdaysMask: Value(weekdaysMask),
      intervalDays: Value(intervalDays),
      inputLabel: Value(inputLabel),
      inputUnit: Value(inputUnit),
      targetInput: targetInput == null && nullToAbsent
          ? const Value.absent()
          : Value(targetInput),
      createdAt: Value(createdAt),
    );
  }

  factory Deliverable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deliverable(
      id: serializer.fromJson<int>(json['id']),
      goalId: serializer.fromJson<int>(json['goalId']),
      name: serializer.fromJson<String>(json['name']),
      frequency: $DeliverablesTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      weekdaysMask: serializer.fromJson<int>(json['weekdaysMask']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      inputLabel: serializer.fromJson<String>(json['inputLabel']),
      inputUnit: serializer.fromJson<String>(json['inputUnit']),
      targetInput: serializer.fromJson<double?>(json['targetInput']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalId': serializer.toJson<int>(goalId),
      'name': serializer.toJson<String>(name),
      'frequency': serializer.toJson<String>(
        $DeliverablesTable.$converterfrequency.toJson(frequency),
      ),
      'weekdaysMask': serializer.toJson<int>(weekdaysMask),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'inputLabel': serializer.toJson<String>(inputLabel),
      'inputUnit': serializer.toJson<String>(inputUnit),
      'targetInput': serializer.toJson<double?>(targetInput),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Deliverable copyWith({
    int? id,
    int? goalId,
    String? name,
    FrequencyType? frequency,
    int? weekdaysMask,
    int? intervalDays,
    String? inputLabel,
    String? inputUnit,
    Value<double?> targetInput = const Value.absent(),
    DateTime? createdAt,
  }) => Deliverable(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    name: name ?? this.name,
    frequency: frequency ?? this.frequency,
    weekdaysMask: weekdaysMask ?? this.weekdaysMask,
    intervalDays: intervalDays ?? this.intervalDays,
    inputLabel: inputLabel ?? this.inputLabel,
    inputUnit: inputUnit ?? this.inputUnit,
    targetInput: targetInput.present ? targetInput.value : this.targetInput,
    createdAt: createdAt ?? this.createdAt,
  );
  Deliverable copyWithCompanion(DeliverablesCompanion data) {
    return Deliverable(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      name: data.name.present ? data.name.value : this.name,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      weekdaysMask: data.weekdaysMask.present
          ? data.weekdaysMask.value
          : this.weekdaysMask,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      inputLabel: data.inputLabel.present
          ? data.inputLabel.value
          : this.inputLabel,
      inputUnit: data.inputUnit.present ? data.inputUnit.value : this.inputUnit,
      targetInput: data.targetInput.present
          ? data.targetInput.value
          : this.targetInput,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deliverable(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('inputLabel: $inputLabel, ')
          ..write('inputUnit: $inputUnit, ')
          ..write('targetInput: $targetInput, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    goalId,
    name,
    frequency,
    weekdaysMask,
    intervalDays,
    inputLabel,
    inputUnit,
    targetInput,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deliverable &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.name == this.name &&
          other.frequency == this.frequency &&
          other.weekdaysMask == this.weekdaysMask &&
          other.intervalDays == this.intervalDays &&
          other.inputLabel == this.inputLabel &&
          other.inputUnit == this.inputUnit &&
          other.targetInput == this.targetInput &&
          other.createdAt == this.createdAt);
}

class DeliverablesCompanion extends UpdateCompanion<Deliverable> {
  final Value<int> id;
  final Value<int> goalId;
  final Value<String> name;
  final Value<FrequencyType> frequency;
  final Value<int> weekdaysMask;
  final Value<int> intervalDays;
  final Value<String> inputLabel;
  final Value<String> inputUnit;
  final Value<double?> targetInput;
  final Value<DateTime> createdAt;
  const DeliverablesCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.name = const Value.absent(),
    this.frequency = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.inputLabel = const Value.absent(),
    this.inputUnit = const Value.absent(),
    this.targetInput = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DeliverablesCompanion.insert({
    this.id = const Value.absent(),
    required int goalId,
    required String name,
    this.frequency = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.inputLabel = const Value.absent(),
    this.inputUnit = const Value.absent(),
    this.targetInput = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : goalId = Value(goalId),
       name = Value(name);
  static Insertable<Deliverable> custom({
    Expression<int>? id,
    Expression<int>? goalId,
    Expression<String>? name,
    Expression<String>? frequency,
    Expression<int>? weekdaysMask,
    Expression<int>? intervalDays,
    Expression<String>? inputLabel,
    Expression<String>? inputUnit,
    Expression<double>? targetInput,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (name != null) 'name': name,
      if (frequency != null) 'frequency': frequency,
      if (weekdaysMask != null) 'weekdays_mask': weekdaysMask,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (inputLabel != null) 'input_label': inputLabel,
      if (inputUnit != null) 'input_unit': inputUnit,
      if (targetInput != null) 'target_input': targetInput,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DeliverablesCompanion copyWith({
    Value<int>? id,
    Value<int>? goalId,
    Value<String>? name,
    Value<FrequencyType>? frequency,
    Value<int>? weekdaysMask,
    Value<int>? intervalDays,
    Value<String>? inputLabel,
    Value<String>? inputUnit,
    Value<double?>? targetInput,
    Value<DateTime>? createdAt,
  }) {
    return DeliverablesCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      intervalDays: intervalDays ?? this.intervalDays,
      inputLabel: inputLabel ?? this.inputLabel,
      inputUnit: inputUnit ?? this.inputUnit,
      targetInput: targetInput ?? this.targetInput,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(
        $DeliverablesTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (weekdaysMask.present) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (inputLabel.present) {
      map['input_label'] = Variable<String>(inputLabel.value);
    }
    if (inputUnit.present) {
      map['input_unit'] = Variable<String>(inputUnit.value);
    }
    if (targetInput.present) {
      map['target_input'] = Variable<double>(targetInput.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliverablesCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('name: $name, ')
          ..write('frequency: $frequency, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('inputLabel: $inputLabel, ')
          ..write('inputUnit: $inputUnit, ')
          ..write('targetInput: $targetInput, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DeliverableLogsTable extends DeliverableLogs
    with TableInfo<$DeliverableLogsTable, DeliverableLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliverableLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deliverableIdMeta = const VerificationMeta(
    'deliverableId',
  );
  @override
  late final GeneratedColumn<int> deliverableId = GeneratedColumn<int>(
    'deliverable_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES deliverables (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LogStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LogStatus>($DeliverableLogsTable.$converterstatus);
  static const VerificationMeta _inputValueMeta = const VerificationMeta(
    'inputValue',
  );
  @override
  late final GeneratedColumn<double> inputValue = GeneratedColumn<double>(
    'input_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deliverableId,
    date,
    status,
    inputValue,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deliverable_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeliverableLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deliverable_id')) {
      context.handle(
        _deliverableIdMeta,
        deliverableId.isAcceptableOrUnknown(
          data['deliverable_id']!,
          _deliverableIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliverableIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('input_value')) {
      context.handle(
        _inputValueMeta,
        inputValue.isAcceptableOrUnknown(data['input_value']!, _inputValueMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {deliverableId, date},
  ];
  @override
  DeliverableLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliverableLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deliverableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deliverable_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      status: $DeliverableLogsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      inputValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}input_value'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $DeliverableLogsTable createAlias(String alias) {
    return $DeliverableLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LogStatus, String, String> $converterstatus =
      const EnumNameConverter<LogStatus>(LogStatus.values);
}

class DeliverableLog extends DataClass implements Insertable<DeliverableLog> {
  final int id;
  final int deliverableId;
  final DateTime date;
  final LogStatus status;

  /// The metric the user entered on completion (null when skipped).
  final double? inputValue;
  final DateTime loggedAt;
  const DeliverableLog({
    required this.id,
    required this.deliverableId,
    required this.date,
    required this.status,
    this.inputValue,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deliverable_id'] = Variable<int>(deliverableId);
    map['date'] = Variable<DateTime>(date);
    {
      map['status'] = Variable<String>(
        $DeliverableLogsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || inputValue != null) {
      map['input_value'] = Variable<double>(inputValue);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  DeliverableLogsCompanion toCompanion(bool nullToAbsent) {
    return DeliverableLogsCompanion(
      id: Value(id),
      deliverableId: Value(deliverableId),
      date: Value(date),
      status: Value(status),
      inputValue: inputValue == null && nullToAbsent
          ? const Value.absent()
          : Value(inputValue),
      loggedAt: Value(loggedAt),
    );
  }

  factory DeliverableLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliverableLog(
      id: serializer.fromJson<int>(json['id']),
      deliverableId: serializer.fromJson<int>(json['deliverableId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: $DeliverableLogsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      inputValue: serializer.fromJson<double?>(json['inputValue']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deliverableId': serializer.toJson<int>(deliverableId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(
        $DeliverableLogsTable.$converterstatus.toJson(status),
      ),
      'inputValue': serializer.toJson<double?>(inputValue),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  DeliverableLog copyWith({
    int? id,
    int? deliverableId,
    DateTime? date,
    LogStatus? status,
    Value<double?> inputValue = const Value.absent(),
    DateTime? loggedAt,
  }) => DeliverableLog(
    id: id ?? this.id,
    deliverableId: deliverableId ?? this.deliverableId,
    date: date ?? this.date,
    status: status ?? this.status,
    inputValue: inputValue.present ? inputValue.value : this.inputValue,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  DeliverableLog copyWithCompanion(DeliverableLogsCompanion data) {
    return DeliverableLog(
      id: data.id.present ? data.id.value : this.id,
      deliverableId: data.deliverableId.present
          ? data.deliverableId.value
          : this.deliverableId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      inputValue: data.inputValue.present
          ? data.inputValue.value
          : this.inputValue,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliverableLog(')
          ..write('id: $id, ')
          ..write('deliverableId: $deliverableId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('inputValue: $inputValue, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deliverableId, date, status, inputValue, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliverableLog &&
          other.id == this.id &&
          other.deliverableId == this.deliverableId &&
          other.date == this.date &&
          other.status == this.status &&
          other.inputValue == this.inputValue &&
          other.loggedAt == this.loggedAt);
}

class DeliverableLogsCompanion extends UpdateCompanion<DeliverableLog> {
  final Value<int> id;
  final Value<int> deliverableId;
  final Value<DateTime> date;
  final Value<LogStatus> status;
  final Value<double?> inputValue;
  final Value<DateTime> loggedAt;
  const DeliverableLogsCompanion({
    this.id = const Value.absent(),
    this.deliverableId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.inputValue = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  DeliverableLogsCompanion.insert({
    this.id = const Value.absent(),
    required int deliverableId,
    required DateTime date,
    required LogStatus status,
    this.inputValue = const Value.absent(),
    this.loggedAt = const Value.absent(),
  }) : deliverableId = Value(deliverableId),
       date = Value(date),
       status = Value(status);
  static Insertable<DeliverableLog> custom({
    Expression<int>? id,
    Expression<int>? deliverableId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<double>? inputValue,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deliverableId != null) 'deliverable_id': deliverableId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (inputValue != null) 'input_value': inputValue,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  DeliverableLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? deliverableId,
    Value<DateTime>? date,
    Value<LogStatus>? status,
    Value<double?>? inputValue,
    Value<DateTime>? loggedAt,
  }) {
    return DeliverableLogsCompanion(
      id: id ?? this.id,
      deliverableId: deliverableId ?? this.deliverableId,
      date: date ?? this.date,
      status: status ?? this.status,
      inputValue: inputValue ?? this.inputValue,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deliverableId.present) {
      map['deliverable_id'] = Variable<int>(deliverableId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $DeliverableLogsTable.$converterstatus.toSql(status.value),
      );
    }
    if (inputValue.present) {
      map['input_value'] = Variable<double>(inputValue.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliverableLogsCompanion(')
          ..write('id: $id, ')
          ..write('deliverableId: $deliverableId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('inputValue: $inputValue, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $DeliverablesTable deliverables = $DeliverablesTable(this);
  late final $DeliverableLogsTable deliverableLogs = $DeliverableLogsTable(
    this,
  );
  late final HabitDao habitDao = HabitDao(this as AppDatabase);
  late final GoalDao goalDao = GoalDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    habitLogs,
    goals,
    deliverables,
    deliverableLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('deliverables', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'deliverables',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('deliverable_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> category,
      Value<int> targetHour,
      Value<int> targetMinute,
      Value<FrequencyType> frequency,
      Value<int> weekdaysMask,
      Value<int> intervalDays,
      Value<int> colorValue,
      Value<bool> reminderEnabled,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<int> targetHour,
      Value<int> targetMinute,
      Value<FrequencyType> frequency,
      Value<int> weekdaysMask,
      Value<int> intervalDays,
      Value<int> colorValue,
      Value<bool> reminderEnabled,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: 'habits__id__habit_logs__habit_id',
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FrequencyType, FrequencyType, String>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get targetHour => $composableBuilder(
    column: $table.targetHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetMinute => $composableBuilder(
    column: $table.targetMinute,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FrequencyType, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({bool habitLogsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> targetHour = const Value.absent(),
                Value<int> targetMinute = const Value.absent(),
                Value<FrequencyType> frequency = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                category: category,
                targetHour: targetHour,
                targetMinute: targetMinute,
                frequency: frequency,
                weekdaysMask: weekdaysMask,
                intervalDays: intervalDays,
                colorValue: colorValue,
                reminderEnabled: reminderEnabled,
                createdAt: createdAt,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> category = const Value.absent(),
                Value<int> targetHour = const Value.absent(),
                Value<int> targetMinute = const Value.absent(),
                Value<FrequencyType> frequency = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                category: category,
                targetHour: targetHour,
                targetMinute: targetMinute,
                frequency: frequency,
                weekdaysMask: weekdaysMask,
                intervalDays: intervalDays,
                colorValue: colorValue,
                reminderEnabled: reminderEnabled,
                createdAt: createdAt,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({habitLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitLogsRefs) db.habitLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, HabitLog>(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).habitLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({bool habitLogsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      required int habitId,
      required DateTime date,
      required LogStatus status,
      Value<DateTime> loggedAt,
    });
typedef $$HabitLogsTableUpdateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<DateTime> date,
      Value<LogStatus> status,
      Value<DateTime> loggedAt,
    });

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_logs__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LogStatus, LogStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LogStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLog,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLog, $$HabitLogsTableReferences),
          HabitLog,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<LogStatus> status = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required DateTime date,
                required LogStatus status,
                Value<DateTime> loggedAt = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitLogsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitLogsTableReferences
                                    ._habitIdTable(db)
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

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLog,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLog, $$HabitLogsTableReferences),
      HabitLog,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<double> startValue,
      required double targetValue,
      Value<String> unit,
      required DateTime startDate,
      required DateTime endDate,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<double> startValue,
      Value<double> targetValue,
      Value<String> unit,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
    });

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DeliverablesTable, List<Deliverable>>
  _deliverablesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deliverables,
    aliasName: 'goals__id__deliverables__goal_id',
  );

  $$DeliverablesTableProcessedTableManager get deliverablesRefs {
    final manager = $$DeliverablesTableTableManager(
      $_db,
      $_db.deliverables,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_deliverablesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> deliverablesRefs(
    Expression<bool> Function($$DeliverablesTableFilterComposer f) f,
  ) {
    final $$DeliverablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliverables,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverablesTableFilterComposer(
            $db: $db,
            $table: $db.deliverables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  Expression<T> deliverablesRefs<T extends Object>(
    Expression<T> Function($$DeliverablesTableAnnotationComposer a) f,
  ) {
    final $$DeliverablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliverables,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverablesTableAnnotationComposer(
            $db: $db,
            $table: $db.deliverables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, $$GoalsTableReferences),
          Goal,
          PrefetchHooks Function({bool deliverablesRefs})
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> startValue = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                name: name,
                description: description,
                startValue: startValue,
                targetValue: targetValue,
                unit: unit,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<double> startValue = const Value.absent(),
                required double targetValue,
                Value<String> unit = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                name: name,
                description: description,
                startValue: startValue,
                targetValue: targetValue,
                unit: unit,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GoalsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({deliverablesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (deliverablesRefs) db.deliverables],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (deliverablesRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable, Deliverable>(
                      currentTable: table,
                      referencedTable: $$GoalsTableReferences
                          ._deliverablesRefsTable(db),
                      managerFromTypedResult: (p0) => $$GoalsTableReferences(
                        db,
                        table,
                        p0,
                      ).deliverablesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.goalId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, $$GoalsTableReferences),
      Goal,
      PrefetchHooks Function({bool deliverablesRefs})
    >;
typedef $$DeliverablesTableCreateCompanionBuilder =
    DeliverablesCompanion Function({
      Value<int> id,
      required int goalId,
      required String name,
      Value<FrequencyType> frequency,
      Value<int> weekdaysMask,
      Value<int> intervalDays,
      Value<String> inputLabel,
      Value<String> inputUnit,
      Value<double?> targetInput,
      Value<DateTime> createdAt,
    });
typedef $$DeliverablesTableUpdateCompanionBuilder =
    DeliverablesCompanion Function({
      Value<int> id,
      Value<int> goalId,
      Value<String> name,
      Value<FrequencyType> frequency,
      Value<int> weekdaysMask,
      Value<int> intervalDays,
      Value<String> inputLabel,
      Value<String> inputUnit,
      Value<double?> targetInput,
      Value<DateTime> createdAt,
    });

final class $$DeliverablesTableReferences
    extends BaseReferences<_$AppDatabase, $DeliverablesTable, Deliverable> {
  $$DeliverablesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('deliverables__goal_id__goals__id');

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<int>('goal_id')!;

    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DeliverableLogsTable, List<DeliverableLog>>
  _deliverableLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deliverableLogs,
    aliasName: 'deliverables__id__deliverable_logs__deliverable_id',
  );

  $$DeliverableLogsTableProcessedTableManager get deliverableLogsRefs {
    final manager = $$DeliverableLogsTableTableManager(
      $_db,
      $_db.deliverableLogs,
    ).filter((f) => f.deliverableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deliverableLogsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DeliverablesTableFilterComposer
    extends Composer<_$AppDatabase, $DeliverablesTable> {
  $$DeliverablesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<FrequencyType, FrequencyType, String>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputLabel => $composableBuilder(
    column: $table.inputLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputUnit => $composableBuilder(
    column: $table.inputUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetInput => $composableBuilder(
    column: $table.targetInput,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> deliverableLogsRefs(
    Expression<bool> Function($$DeliverableLogsTableFilterComposer f) f,
  ) {
    final $$DeliverableLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliverableLogs,
      getReferencedColumn: (t) => t.deliverableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverableLogsTableFilterComposer(
            $db: $db,
            $table: $db.deliverableLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeliverablesTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliverablesTable> {
  $$DeliverablesTableOrderingComposer({
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

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputLabel => $composableBuilder(
    column: $table.inputLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputUnit => $composableBuilder(
    column: $table.inputUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetInput => $composableBuilder(
    column: $table.targetInput,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliverablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliverablesTable> {
  $$DeliverablesTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<FrequencyType, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputLabel => $composableBuilder(
    column: $table.inputLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputUnit =>
      $composableBuilder(column: $table.inputUnit, builder: (column) => column);

  GeneratedColumn<double> get targetInput => $composableBuilder(
    column: $table.targetInput,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> deliverableLogsRefs<T extends Object>(
    Expression<T> Function($$DeliverableLogsTableAnnotationComposer a) f,
  ) {
    final $$DeliverableLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deliverableLogs,
      getReferencedColumn: (t) => t.deliverableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverableLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.deliverableLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeliverablesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeliverablesTable,
          Deliverable,
          $$DeliverablesTableFilterComposer,
          $$DeliverablesTableOrderingComposer,
          $$DeliverablesTableAnnotationComposer,
          $$DeliverablesTableCreateCompanionBuilder,
          $$DeliverablesTableUpdateCompanionBuilder,
          (Deliverable, $$DeliverablesTableReferences),
          Deliverable,
          PrefetchHooks Function({bool goalId, bool deliverableLogsRefs})
        > {
  $$DeliverablesTableTableManager(_$AppDatabase db, $DeliverablesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliverablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliverablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliverablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> goalId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<FrequencyType> frequency = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<String> inputLabel = const Value.absent(),
                Value<String> inputUnit = const Value.absent(),
                Value<double?> targetInput = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DeliverablesCompanion(
                id: id,
                goalId: goalId,
                name: name,
                frequency: frequency,
                weekdaysMask: weekdaysMask,
                intervalDays: intervalDays,
                inputLabel: inputLabel,
                inputUnit: inputUnit,
                targetInput: targetInput,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int goalId,
                required String name,
                Value<FrequencyType> frequency = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<String> inputLabel = const Value.absent(),
                Value<String> inputUnit = const Value.absent(),
                Value<double?> targetInput = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DeliverablesCompanion.insert(
                id: id,
                goalId: goalId,
                name: name,
                frequency: frequency,
                weekdaysMask: weekdaysMask,
                intervalDays: intervalDays,
                inputLabel: inputLabel,
                inputUnit: inputUnit,
                targetInput: targetInput,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeliverablesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({goalId = false, deliverableLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deliverableLogsRefs) db.deliverableLogs,
                  ],
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
                        if (goalId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.goalId,
                                    referencedTable:
                                        $$DeliverablesTableReferences
                                            ._goalIdTable(db),
                                    referencedColumn:
                                        $$DeliverablesTableReferences
                                            ._goalIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deliverableLogsRefs)
                        await $_getPrefetchedData<
                          Deliverable,
                          $DeliverablesTable,
                          DeliverableLog
                        >(
                          currentTable: table,
                          referencedTable: $$DeliverablesTableReferences
                              ._deliverableLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeliverablesTableReferences(
                                db,
                                table,
                                p0,
                              ).deliverableLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deliverableId == item.id,
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

typedef $$DeliverablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeliverablesTable,
      Deliverable,
      $$DeliverablesTableFilterComposer,
      $$DeliverablesTableOrderingComposer,
      $$DeliverablesTableAnnotationComposer,
      $$DeliverablesTableCreateCompanionBuilder,
      $$DeliverablesTableUpdateCompanionBuilder,
      (Deliverable, $$DeliverablesTableReferences),
      Deliverable,
      PrefetchHooks Function({bool goalId, bool deliverableLogsRefs})
    >;
typedef $$DeliverableLogsTableCreateCompanionBuilder =
    DeliverableLogsCompanion Function({
      Value<int> id,
      required int deliverableId,
      required DateTime date,
      required LogStatus status,
      Value<double?> inputValue,
      Value<DateTime> loggedAt,
    });
typedef $$DeliverableLogsTableUpdateCompanionBuilder =
    DeliverableLogsCompanion Function({
      Value<int> id,
      Value<int> deliverableId,
      Value<DateTime> date,
      Value<LogStatus> status,
      Value<double?> inputValue,
      Value<DateTime> loggedAt,
    });

final class $$DeliverableLogsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DeliverableLogsTable, DeliverableLog> {
  $$DeliverableLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DeliverablesTable _deliverableIdTable(_$AppDatabase db) => db
      .deliverables
      .createAlias('deliverable_logs__deliverable_id__deliverables__id');

  $$DeliverablesTableProcessedTableManager get deliverableId {
    final $_column = $_itemColumn<int>('deliverable_id')!;

    final manager = $$DeliverablesTableTableManager(
      $_db,
      $_db.deliverables,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deliverableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeliverableLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DeliverableLogsTable> {
  $$DeliverableLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LogStatus, LogStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get inputValue => $composableBuilder(
    column: $table.inputValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DeliverablesTableFilterComposer get deliverableId {
    final $$DeliverablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deliverableId,
      referencedTable: $db.deliverables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverablesTableFilterComposer(
            $db: $db,
            $table: $db.deliverables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliverableLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliverableLogsTable> {
  $$DeliverableLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inputValue => $composableBuilder(
    column: $table.inputValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DeliverablesTableOrderingComposer get deliverableId {
    final $$DeliverablesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deliverableId,
      referencedTable: $db.deliverables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverablesTableOrderingComposer(
            $db: $db,
            $table: $db.deliverables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliverableLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliverableLogsTable> {
  $$DeliverableLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LogStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get inputValue => $composableBuilder(
    column: $table.inputValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  $$DeliverablesTableAnnotationComposer get deliverableId {
    final $$DeliverablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deliverableId,
      referencedTable: $db.deliverables,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeliverablesTableAnnotationComposer(
            $db: $db,
            $table: $db.deliverables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeliverableLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeliverableLogsTable,
          DeliverableLog,
          $$DeliverableLogsTableFilterComposer,
          $$DeliverableLogsTableOrderingComposer,
          $$DeliverableLogsTableAnnotationComposer,
          $$DeliverableLogsTableCreateCompanionBuilder,
          $$DeliverableLogsTableUpdateCompanionBuilder,
          (DeliverableLog, $$DeliverableLogsTableReferences),
          DeliverableLog,
          PrefetchHooks Function({bool deliverableId})
        > {
  $$DeliverableLogsTableTableManager(
    _$AppDatabase db,
    $DeliverableLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliverableLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliverableLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliverableLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> deliverableId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<LogStatus> status = const Value.absent(),
                Value<double?> inputValue = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => DeliverableLogsCompanion(
                id: id,
                deliverableId: deliverableId,
                date: date,
                status: status,
                inputValue: inputValue,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int deliverableId,
                required DateTime date,
                required LogStatus status,
                Value<double?> inputValue = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => DeliverableLogsCompanion.insert(
                id: id,
                deliverableId: deliverableId,
                date: date,
                status: status,
                inputValue: inputValue,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeliverableLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deliverableId = false}) {
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
                    if (deliverableId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deliverableId,
                                referencedTable:
                                    $$DeliverableLogsTableReferences
                                        ._deliverableIdTable(db),
                                referencedColumn:
                                    $$DeliverableLogsTableReferences
                                        ._deliverableIdTable(db)
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

typedef $$DeliverableLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeliverableLogsTable,
      DeliverableLog,
      $$DeliverableLogsTableFilterComposer,
      $$DeliverableLogsTableOrderingComposer,
      $$DeliverableLogsTableAnnotationComposer,
      $$DeliverableLogsTableCreateCompanionBuilder,
      $$DeliverableLogsTableUpdateCompanionBuilder,
      (DeliverableLog, $$DeliverableLogsTableReferences),
      DeliverableLog,
      PrefetchHooks Function({bool deliverableId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$DeliverablesTableTableManager get deliverables =>
      $$DeliverablesTableTableManager(_db, _db.deliverables);
  $$DeliverableLogsTableTableManager get deliverableLogs =>
      $$DeliverableLogsTableTableManager(_db, _db.deliverableLogs);
}
