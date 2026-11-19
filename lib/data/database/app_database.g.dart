// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatRuleMeta = const VerificationMeta(
    'repeatRule',
  );
  @override
  late final GeneratedColumn<String> repeatRule = GeneratedColumn<String>(
    'repeat_rule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _reminderLeadMinutesMeta =
      const VerificationMeta('reminderLeadMinutes');
  @override
  late final GeneratedColumn<int> reminderLeadMinutes = GeneratedColumn<int>(
    'reminder_lead_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _alarmEnabledMeta = const VerificationMeta(
    'alarmEnabled',
  );
  @override
  late final GeneratedColumn<bool> alarmEnabled = GeneratedColumn<bool>(
    'alarm_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("alarm_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    category,
    priority,
    startAt,
    dueAt,
    isDone,
    completedAt,
    repeatRule,
    reminderLeadMinutes,
    alarmEnabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('repeat_rule')) {
      context.handle(
        _repeatRuleMeta,
        repeatRule.isAcceptableOrUnknown(data['repeat_rule']!, _repeatRuleMeta),
      );
    }
    if (data.containsKey('reminder_lead_minutes')) {
      context.handle(
        _reminderLeadMinutesMeta,
        reminderLeadMinutes.isAcceptableOrUnknown(
          data['reminder_lead_minutes']!,
          _reminderLeadMinutesMeta,
        ),
      );
    }
    if (data.containsKey('alarm_enabled')) {
      context.handle(
        _alarmEnabledMeta,
        alarmEnabled.isAcceptableOrUnknown(
          data['alarm_enabled']!,
          _alarmEnabledMeta,
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
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      repeatRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_rule'],
      )!,
      reminderLeadMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_lead_minutes'],
      )!,
      alarmEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}alarm_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final DateTime? startAt;
  final DateTime dueAt;
  final bool isDone;
  final DateTime? completedAt;
  final String repeatRule;
  final int reminderLeadMinutes;
  final bool alarmEnabled;
  final DateTime createdAt;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    this.startAt,
    required this.dueAt,
    required this.isDone,
    this.completedAt,
    required this.repeatRule,
    required this.reminderLeadMinutes,
    required this.alarmEnabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<DateTime>(startAt);
    }
    map['due_at'] = Variable<DateTime>(dueAt);
    map['is_done'] = Variable<bool>(isDone);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['repeat_rule'] = Variable<String>(repeatRule);
    map['reminder_lead_minutes'] = Variable<int>(reminderLeadMinutes);
    map['alarm_enabled'] = Variable<bool>(alarmEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      priority: Value(priority),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      dueAt: Value(dueAt),
      isDone: Value(isDone),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      repeatRule: Value(repeatRule),
      reminderLeadMinutes: Value(reminderLeadMinutes),
      alarmEnabled: Value(alarmEnabled),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      priority: serializer.fromJson<String>(json['priority']),
      startAt: serializer.fromJson<DateTime?>(json['startAt']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      repeatRule: serializer.fromJson<String>(json['repeatRule']),
      reminderLeadMinutes: serializer.fromJson<int>(
        json['reminderLeadMinutes'],
      ),
      alarmEnabled: serializer.fromJson<bool>(json['alarmEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'priority': serializer.toJson<String>(priority),
      'startAt': serializer.toJson<DateTime?>(startAt),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'isDone': serializer.toJson<bool>(isDone),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'repeatRule': serializer.toJson<String>(repeatRule),
      'reminderLeadMinutes': serializer.toJson<int>(reminderLeadMinutes),
      'alarmEnabled': serializer.toJson<bool>(alarmEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? priority,
    Value<DateTime?> startAt = const Value.absent(),
    DateTime? dueAt,
    bool? isDone,
    Value<DateTime?> completedAt = const Value.absent(),
    String? repeatRule,
    int? reminderLeadMinutes,
    bool? alarmEnabled,
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    priority: priority ?? this.priority,
    startAt: startAt.present ? startAt.value : this.startAt,
    dueAt: dueAt ?? this.dueAt,
    isDone: isDone ?? this.isDone,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    repeatRule: repeatRule ?? this.repeatRule,
    reminderLeadMinutes: reminderLeadMinutes ?? this.reminderLeadMinutes,
    alarmEnabled: alarmEnabled ?? this.alarmEnabled,
    createdAt: createdAt ?? this.createdAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      priority: data.priority.present ? data.priority.value : this.priority,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      repeatRule: data.repeatRule.present
          ? data.repeatRule.value
          : this.repeatRule,
      reminderLeadMinutes: data.reminderLeadMinutes.present
          ? data.reminderLeadMinutes.value
          : this.reminderLeadMinutes,
      alarmEnabled: data.alarmEnabled.present
          ? data.alarmEnabled.value
          : this.alarmEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('isDone: $isDone, ')
          ..write('completedAt: $completedAt, ')
          ..write('repeatRule: $repeatRule, ')
          ..write('reminderLeadMinutes: $reminderLeadMinutes, ')
          ..write('alarmEnabled: $alarmEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    category,
    priority,
    startAt,
    dueAt,
    isDone,
    completedAt,
    repeatRule,
    reminderLeadMinutes,
    alarmEnabled,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.priority == this.priority &&
          other.startAt == this.startAt &&
          other.dueAt == this.dueAt &&
          other.isDone == this.isDone &&
          other.completedAt == this.completedAt &&
          other.repeatRule == this.repeatRule &&
          other.reminderLeadMinutes == this.reminderLeadMinutes &&
          other.alarmEnabled == this.alarmEnabled &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<String> priority;
  final Value<DateTime?> startAt;
  final Value<DateTime> dueAt;
  final Value<bool> isDone;
  final Value<DateTime?> completedAt;
  final Value<String> repeatRule;
  final Value<int> reminderLeadMinutes;
  final Value<bool> alarmEnabled;
  final Value<DateTime> createdAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.repeatRule = const Value.absent(),
    this.reminderLeadMinutes = const Value.absent(),
    this.alarmEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    required DateTime dueAt,
    this.isDone = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.repeatRule = const Value.absent(),
    this.reminderLeadMinutes = const Value.absent(),
    this.alarmEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       dueAt = Value(dueAt);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? priority,
    Expression<DateTime>? startAt,
    Expression<DateTime>? dueAt,
    Expression<bool>? isDone,
    Expression<DateTime>? completedAt,
    Expression<String>? repeatRule,
    Expression<int>? reminderLeadMinutes,
    Expression<bool>? alarmEnabled,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (priority != null) 'priority': priority,
      if (startAt != null) 'start_at': startAt,
      if (dueAt != null) 'due_at': dueAt,
      if (isDone != null) 'is_done': isDone,
      if (completedAt != null) 'completed_at': completedAt,
      if (repeatRule != null) 'repeat_rule': repeatRule,
      if (reminderLeadMinutes != null)
        'reminder_lead_minutes': reminderLeadMinutes,
      if (alarmEnabled != null) 'alarm_enabled': alarmEnabled,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<String>? priority,
    Value<DateTime?>? startAt,
    Value<DateTime>? dueAt,
    Value<bool>? isDone,
    Value<DateTime?>? completedAt,
    Value<String>? repeatRule,
    Value<int>? reminderLeadMinutes,
    Value<bool>? alarmEnabled,
    Value<DateTime>? createdAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      startAt: startAt ?? this.startAt,
      dueAt: dueAt ?? this.dueAt,
      isDone: isDone ?? this.isDone,
      completedAt: completedAt ?? this.completedAt,
      repeatRule: repeatRule ?? this.repeatRule,
      reminderLeadMinutes: reminderLeadMinutes ?? this.reminderLeadMinutes,
      alarmEnabled: alarmEnabled ?? this.alarmEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (repeatRule.present) {
      map['repeat_rule'] = Variable<String>(repeatRule.value);
    }
    if (reminderLeadMinutes.present) {
      map['reminder_lead_minutes'] = Variable<int>(reminderLeadMinutes.value);
    }
    if (alarmEnabled.present) {
      map['alarm_enabled'] = Variable<bool>(alarmEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('isDone: $isDone, ')
          ..write('completedAt: $completedAt, ')
          ..write('repeatRule: $repeatRule, ')
          ..write('reminderLeadMinutes: $reminderLeadMinutes, ')
          ..write('alarmEnabled: $alarmEnabled, ')
          ..write('createdAt: $createdAt')
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _targetCountMeta = const VerificationMeta(
    'targetCount',
  );
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, targetCount, updatedAt];
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('target_count')) {
      context.handle(
        _targetCountMeta,
        targetCount.isAcceptableOrUnknown(
          data['target_count']!,
          _targetCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCountMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
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
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
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
  final String type;
  final int targetCount;
  final DateTime updatedAt;
  const Goal({
    required this.id,
    required this.type,
    required this.targetCount,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['target_count'] = Variable<int>(targetCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      type: Value(type),
      targetCount: Value(targetCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'targetCount': serializer.toJson<int>(targetCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Goal copyWith({
    int? id,
    String? type,
    int? targetCount,
    DateTime? updatedAt,
  }) => Goal(
    id: id ?? this.id,
    type: type ?? this.type,
    targetCount: targetCount ?? this.targetCount,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetCount: $targetCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, targetCount, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.type == this.type &&
          other.targetCount == this.targetCount &&
          other.updatedAt == this.updatedAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> targetCount;
  final Value<DateTime> updatedAt;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int targetCount,
    this.updatedAt = const Value.absent(),
  }) : type = Value(type),
       targetCount = Value(targetCount);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? targetCount,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (targetCount != null) 'target_count': targetCount,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<int>? targetCount,
    Value<DateTime>? updatedAt,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      targetCount: targetCount ?? this.targetCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetCount: $targetCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StreaksTable extends Streaks with TableInfo<$StreaksTable, Streak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreaksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tasksCompletedMeta = const VerificationMeta(
    'tasksCompleted',
  );
  @override
  late final GeneratedColumn<int> tasksCompleted = GeneratedColumn<int>(
    'tasks_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goalMetMeta = const VerificationMeta(
    'goalMet',
  );
  @override
  late final GeneratedColumn<bool> goalMet = GeneratedColumn<bool>(
    'goal_met',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("goal_met" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [date, tasksCompleted, goalMet];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Streak> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('tasks_completed')) {
      context.handle(
        _tasksCompletedMeta,
        tasksCompleted.isAcceptableOrUnknown(
          data['tasks_completed']!,
          _tasksCompletedMeta,
        ),
      );
    }
    if (data.containsKey('goal_met')) {
      context.handle(
        _goalMetMeta,
        goalMet.isAcceptableOrUnknown(data['goal_met']!, _goalMetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  Streak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Streak(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      tasksCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_completed'],
      )!,
      goalMet: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}goal_met'],
      )!,
    );
  }

  @override
  $StreaksTable createAlias(String alias) {
    return $StreaksTable(attachedDatabase, alias);
  }
}

class Streak extends DataClass implements Insertable<Streak> {
  final String date;
  final int tasksCompleted;
  final bool goalMet;
  const Streak({
    required this.date,
    required this.tasksCompleted,
    required this.goalMet,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['tasks_completed'] = Variable<int>(tasksCompleted);
    map['goal_met'] = Variable<bool>(goalMet);
    return map;
  }

  StreaksCompanion toCompanion(bool nullToAbsent) {
    return StreaksCompanion(
      date: Value(date),
      tasksCompleted: Value(tasksCompleted),
      goalMet: Value(goalMet),
    );
  }

  factory Streak.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Streak(
      date: serializer.fromJson<String>(json['date']),
      tasksCompleted: serializer.fromJson<int>(json['tasksCompleted']),
      goalMet: serializer.fromJson<bool>(json['goalMet']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'tasksCompleted': serializer.toJson<int>(tasksCompleted),
      'goalMet': serializer.toJson<bool>(goalMet),
    };
  }

  Streak copyWith({String? date, int? tasksCompleted, bool? goalMet}) => Streak(
    date: date ?? this.date,
    tasksCompleted: tasksCompleted ?? this.tasksCompleted,
    goalMet: goalMet ?? this.goalMet,
  );
  Streak copyWithCompanion(StreaksCompanion data) {
    return Streak(
      date: data.date.present ? data.date.value : this.date,
      tasksCompleted: data.tasksCompleted.present
          ? data.tasksCompleted.value
          : this.tasksCompleted,
      goalMet: data.goalMet.present ? data.goalMet.value : this.goalMet,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Streak(')
          ..write('date: $date, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('goalMet: $goalMet')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, tasksCompleted, goalMet);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Streak &&
          other.date == this.date &&
          other.tasksCompleted == this.tasksCompleted &&
          other.goalMet == this.goalMet);
}

class StreaksCompanion extends UpdateCompanion<Streak> {
  final Value<String> date;
  final Value<int> tasksCompleted;
  final Value<bool> goalMet;
  final Value<int> rowid;
  const StreaksCompanion({
    this.date = const Value.absent(),
    this.tasksCompleted = const Value.absent(),
    this.goalMet = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StreaksCompanion.insert({
    required String date,
    this.tasksCompleted = const Value.absent(),
    this.goalMet = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<Streak> custom({
    Expression<String>? date,
    Expression<int>? tasksCompleted,
    Expression<bool>? goalMet,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (tasksCompleted != null) 'tasks_completed': tasksCompleted,
      if (goalMet != null) 'goal_met': goalMet,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StreaksCompanion copyWith({
    Value<String>? date,
    Value<int>? tasksCompleted,
    Value<bool>? goalMet,
    Value<int>? rowid,
  }) {
    return StreaksCompanion(
      date: date ?? this.date,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      goalMet: goalMet ?? this.goalMet,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (tasksCompleted.present) {
      map['tasks_completed'] = Variable<int>(tasksCompleted.value);
    }
    if (goalMet.present) {
      map['goal_met'] = Variable<bool>(goalMet.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreaksCompanion(')
          ..write('date: $date, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('goalMet: $goalMet, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteTextMeta = const VerificationMeta(
    'quoteText',
  );
  @override
  late final GeneratedColumn<String> quoteText = GeneratedColumn<String>(
    'quote_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorImageAssetMeta = const VerificationMeta(
    'authorImageAsset',
  );
  @override
  late final GeneratedColumn<String> authorImageAsset = GeneratedColumn<String>(
    'author_image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
    defaultValue: const Constant('general'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteText,
    author,
    authorImageAsset,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('quote_text')) {
      context.handle(
        _quoteTextMeta,
        quoteText.isAcceptableOrUnknown(data['quote_text']!, _quoteTextMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteTextMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('author_image_asset')) {
      context.handle(
        _authorImageAssetMeta,
        authorImageAsset.isAcceptableOrUnknown(
          data['author_image_asset']!,
          _authorImageAssetMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      quoteText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_text'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      authorImageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_image_asset'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final String id;
  final String quoteText;
  final String author;
  final String authorImageAsset;
  final String category;
  const Quote({
    required this.id,
    required this.quoteText,
    required this.author,
    required this.authorImageAsset,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['quote_text'] = Variable<String>(quoteText);
    map['author'] = Variable<String>(author);
    map['author_image_asset'] = Variable<String>(authorImageAsset);
    map['category'] = Variable<String>(category);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      quoteText: Value(quoteText),
      author: Value(author),
      authorImageAsset: Value(authorImageAsset),
      category: Value(category),
    );
  }

  factory Quote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<String>(json['id']),
      quoteText: serializer.fromJson<String>(json['quoteText']),
      author: serializer.fromJson<String>(json['author']),
      authorImageAsset: serializer.fromJson<String>(json['authorImageAsset']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'quoteText': serializer.toJson<String>(quoteText),
      'author': serializer.toJson<String>(author),
      'authorImageAsset': serializer.toJson<String>(authorImageAsset),
      'category': serializer.toJson<String>(category),
    };
  }

  Quote copyWith({
    String? id,
    String? quoteText,
    String? author,
    String? authorImageAsset,
    String? category,
  }) => Quote(
    id: id ?? this.id,
    quoteText: quoteText ?? this.quoteText,
    author: author ?? this.author,
    authorImageAsset: authorImageAsset ?? this.authorImageAsset,
    category: category ?? this.category,
  );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      quoteText: data.quoteText.present ? data.quoteText.value : this.quoteText,
      author: data.author.present ? data.author.value : this.author,
      authorImageAsset: data.authorImageAsset.present
          ? data.authorImageAsset.value
          : this.authorImageAsset,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('author: $author, ')
          ..write('authorImageAsset: $authorImageAsset, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, quoteText, author, authorImageAsset, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.quoteText == this.quoteText &&
          other.author == this.author &&
          other.authorImageAsset == this.authorImageAsset &&
          other.category == this.category);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<String> id;
  final Value<String> quoteText;
  final Value<String> author;
  final Value<String> authorImageAsset;
  final Value<String> category;
  final Value<int> rowid;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.quoteText = const Value.absent(),
    this.author = const Value.absent(),
    this.authorImageAsset = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuotesCompanion.insert({
    required String id,
    required String quoteText,
    required String author,
    this.authorImageAsset = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       quoteText = Value(quoteText),
       author = Value(author);
  static Insertable<Quote> custom({
    Expression<String>? id,
    Expression<String>? quoteText,
    Expression<String>? author,
    Expression<String>? authorImageAsset,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteText != null) 'quote_text': quoteText,
      if (author != null) 'author': author,
      if (authorImageAsset != null) 'author_image_asset': authorImageAsset,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuotesCompanion copyWith({
    Value<String>? id,
    Value<String>? quoteText,
    Value<String>? author,
    Value<String>? authorImageAsset,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      author: author ?? this.author,
      authorImageAsset: authorImageAsset ?? this.authorImageAsset,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (quoteText.present) {
      map['quote_text'] = Variable<String>(quoteText.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (authorImageAsset.present) {
      map['author_image_asset'] = Variable<String>(authorImageAsset.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('author: $author, ')
          ..write('authorImageAsset: $authorImageAsset, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavouriteQuotesTable extends FavouriteQuotes
    with TableInfo<$FavouriteQuotesTable, FavouriteQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavouriteQuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<String> quoteId = GeneratedColumn<String>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quotes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _likedAtMeta = const VerificationMeta(
    'likedAt',
  );
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
    'liked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [quoteId, likedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favourite_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavouriteQuote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    if (data.containsKey('liked_at')) {
      context.handle(
        _likedAtMeta,
        likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {quoteId};
  @override
  FavouriteQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavouriteQuote(
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      )!,
      likedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}liked_at'],
      )!,
    );
  }

  @override
  $FavouriteQuotesTable createAlias(String alias) {
    return $FavouriteQuotesTable(attachedDatabase, alias);
  }
}

class FavouriteQuote extends DataClass implements Insertable<FavouriteQuote> {
  final String quoteId;
  final DateTime likedAt;
  const FavouriteQuote({required this.quoteId, required this.likedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['quote_id'] = Variable<String>(quoteId);
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  FavouriteQuotesCompanion toCompanion(bool nullToAbsent) {
    return FavouriteQuotesCompanion(
      quoteId: Value(quoteId),
      likedAt: Value(likedAt),
    );
  }

  factory FavouriteQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavouriteQuote(
      quoteId: serializer.fromJson<String>(json['quoteId']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'quoteId': serializer.toJson<String>(quoteId),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  FavouriteQuote copyWith({String? quoteId, DateTime? likedAt}) =>
      FavouriteQuote(
        quoteId: quoteId ?? this.quoteId,
        likedAt: likedAt ?? this.likedAt,
      );
  FavouriteQuote copyWithCompanion(FavouriteQuotesCompanion data) {
    return FavouriteQuote(
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavouriteQuote(')
          ..write('quoteId: $quoteId, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(quoteId, likedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavouriteQuote &&
          other.quoteId == this.quoteId &&
          other.likedAt == this.likedAt);
}

class FavouriteQuotesCompanion extends UpdateCompanion<FavouriteQuote> {
  final Value<String> quoteId;
  final Value<DateTime> likedAt;
  final Value<int> rowid;
  const FavouriteQuotesCompanion({
    this.quoteId = const Value.absent(),
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavouriteQuotesCompanion.insert({
    required String quoteId,
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : quoteId = Value(quoteId);
  static Insertable<FavouriteQuote> custom({
    Expression<String>? quoteId,
    Expression<DateTime>? likedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (quoteId != null) 'quote_id': quoteId,
      if (likedAt != null) 'liked_at': likedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavouriteQuotesCompanion copyWith({
    Value<String>? quoteId,
    Value<DateTime>? likedAt,
    Value<int>? rowid,
  }) {
    return FavouriteQuotesCompanion(
      quoteId: quoteId ?? this.quoteId,
      likedAt: likedAt ?? this.likedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouriteQuotesCompanion(')
          ..write('quoteId: $quoteId, ')
          ..write('likedAt: $likedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeaderboardUsersTable extends LeaderboardUsers
    with TableInfo<$LeaderboardUsersTable, LeaderboardUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaderboardUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarAssetMeta = const VerificationMeta(
    'avatarAsset',
  );
  @override
  late final GeneratedColumn<String> avatarAsset = GeneratedColumn<String>(
    'avatar_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCompletedMeta = const VerificationMeta(
    'totalCompleted',
  );
  @override
  late final GeneratedColumn<int> totalCompleted = GeneratedColumn<int>(
    'total_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isCurrentUserMeta = const VerificationMeta(
    'isCurrentUser',
  );
  @override
  late final GeneratedColumn<bool> isCurrentUser = GeneratedColumn<bool>(
    'is_current_user',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current_user" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _weeklyCompletedMeta = const VerificationMeta(
    'weeklyCompleted',
  );
  @override
  late final GeneratedColumn<int> weeklyCompleted = GeneratedColumn<int>(
    'weekly_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    avatarAsset,
    currentStreak,
    longestStreak,
    totalCompleted,
    isCurrentUser,
    weeklyCompleted,
    totalPoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leaderboard_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaderboardUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar_asset')) {
      context.handle(
        _avatarAssetMeta,
        avatarAsset.isAcceptableOrUnknown(
          data['avatar_asset']!,
          _avatarAssetMeta,
        ),
      );
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
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('total_completed')) {
      context.handle(
        _totalCompletedMeta,
        totalCompleted.isAcceptableOrUnknown(
          data['total_completed']!,
          _totalCompletedMeta,
        ),
      );
    }
    if (data.containsKey('is_current_user')) {
      context.handle(
        _isCurrentUserMeta,
        isCurrentUser.isAcceptableOrUnknown(
          data['is_current_user']!,
          _isCurrentUserMeta,
        ),
      );
    }
    if (data.containsKey('weekly_completed')) {
      context.handle(
        _weeklyCompletedMeta,
        weeklyCompleted.isAcceptableOrUnknown(
          data['weekly_completed']!,
          _weeklyCompletedMeta,
        ),
      );
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeaderboardUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaderboardUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      avatarAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_asset'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      totalCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_completed'],
      )!,
      isCurrentUser: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current_user'],
      )!,
      weeklyCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_completed'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
    );
  }

  @override
  $LeaderboardUsersTable createAlias(String alias) {
    return $LeaderboardUsersTable(attachedDatabase, alias);
  }
}

class LeaderboardUser extends DataClass implements Insertable<LeaderboardUser> {
  final String id;
  final String name;
  final String avatarAsset;
  final int currentStreak;
  final int longestStreak;
  final int totalCompleted;
  final bool isCurrentUser;
  final int weeklyCompleted;
  final int totalPoints;
  const LeaderboardUser({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalCompleted,
    required this.isCurrentUser,
    required this.weeklyCompleted,
    required this.totalPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['avatar_asset'] = Variable<String>(avatarAsset);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['total_completed'] = Variable<int>(totalCompleted);
    map['is_current_user'] = Variable<bool>(isCurrentUser);
    map['weekly_completed'] = Variable<int>(weeklyCompleted);
    map['total_points'] = Variable<int>(totalPoints);
    return map;
  }

  LeaderboardUsersCompanion toCompanion(bool nullToAbsent) {
    return LeaderboardUsersCompanion(
      id: Value(id),
      name: Value(name),
      avatarAsset: Value(avatarAsset),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      totalCompleted: Value(totalCompleted),
      isCurrentUser: Value(isCurrentUser),
      weeklyCompleted: Value(weeklyCompleted),
      totalPoints: Value(totalPoints),
    );
  }

  factory LeaderboardUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaderboardUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatarAsset: serializer.fromJson<String>(json['avatarAsset']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      totalCompleted: serializer.fromJson<int>(json['totalCompleted']),
      isCurrentUser: serializer.fromJson<bool>(json['isCurrentUser']),
      weeklyCompleted: serializer.fromJson<int>(json['weeklyCompleted']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatarAsset': serializer.toJson<String>(avatarAsset),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'totalCompleted': serializer.toJson<int>(totalCompleted),
      'isCurrentUser': serializer.toJson<bool>(isCurrentUser),
      'weeklyCompleted': serializer.toJson<int>(weeklyCompleted),
      'totalPoints': serializer.toJson<int>(totalPoints),
    };
  }

  LeaderboardUser copyWith({
    String? id,
    String? name,
    String? avatarAsset,
    int? currentStreak,
    int? longestStreak,
    int? totalCompleted,
    bool? isCurrentUser,
    int? weeklyCompleted,
    int? totalPoints,
  }) => LeaderboardUser(
    id: id ?? this.id,
    name: name ?? this.name,
    avatarAsset: avatarAsset ?? this.avatarAsset,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    totalCompleted: totalCompleted ?? this.totalCompleted,
    isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    weeklyCompleted: weeklyCompleted ?? this.weeklyCompleted,
    totalPoints: totalPoints ?? this.totalPoints,
  );
  LeaderboardUser copyWithCompanion(LeaderboardUsersCompanion data) {
    return LeaderboardUser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatarAsset: data.avatarAsset.present
          ? data.avatarAsset.value
          : this.avatarAsset,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      totalCompleted: data.totalCompleted.present
          ? data.totalCompleted.value
          : this.totalCompleted,
      isCurrentUser: data.isCurrentUser.present
          ? data.isCurrentUser.value
          : this.isCurrentUser,
      weeklyCompleted: data.weeklyCompleted.present
          ? data.weeklyCompleted.value
          : this.weeklyCompleted,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalCompleted: $totalCompleted, ')
          ..write('isCurrentUser: $isCurrentUser, ')
          ..write('weeklyCompleted: $weeklyCompleted, ')
          ..write('totalPoints: $totalPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    avatarAsset,
    currentStreak,
    longestStreak,
    totalCompleted,
    isCurrentUser,
    weeklyCompleted,
    totalPoints,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaderboardUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatarAsset == this.avatarAsset &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.totalCompleted == this.totalCompleted &&
          other.isCurrentUser == this.isCurrentUser &&
          other.weeklyCompleted == this.weeklyCompleted &&
          other.totalPoints == this.totalPoints);
}

class LeaderboardUsersCompanion extends UpdateCompanion<LeaderboardUser> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> avatarAsset;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> totalCompleted;
  final Value<bool> isCurrentUser;
  final Value<int> weeklyCompleted;
  final Value<int> totalPoints;
  final Value<int> rowid;
  const LeaderboardUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarAsset = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalCompleted = const Value.absent(),
    this.isCurrentUser = const Value.absent(),
    this.weeklyCompleted = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaderboardUsersCompanion.insert({
    required String id,
    required String name,
    this.avatarAsset = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalCompleted = const Value.absent(),
    this.isCurrentUser = const Value.absent(),
    this.weeklyCompleted = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<LeaderboardUser> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? avatarAsset,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? totalCompleted,
    Expression<bool>? isCurrentUser,
    Expression<int>? weeklyCompleted,
    Expression<int>? totalPoints,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatarAsset != null) 'avatar_asset': avatarAsset,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (totalCompleted != null) 'total_completed': totalCompleted,
      if (isCurrentUser != null) 'is_current_user': isCurrentUser,
      if (weeklyCompleted != null) 'weekly_completed': weeklyCompleted,
      if (totalPoints != null) 'total_points': totalPoints,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaderboardUsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? avatarAsset,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<int>? totalCompleted,
    Value<bool>? isCurrentUser,
    Value<int>? weeklyCompleted,
    Value<int>? totalPoints,
    Value<int>? rowid,
  }) {
    return LeaderboardUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalCompleted: totalCompleted ?? this.totalCompleted,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      weeklyCompleted: weeklyCompleted ?? this.weeklyCompleted,
      totalPoints: totalPoints ?? this.totalPoints,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarAsset.present) {
      map['avatar_asset'] = Variable<String>(avatarAsset.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (totalCompleted.present) {
      map['total_completed'] = Variable<int>(totalCompleted.value);
    }
    if (isCurrentUser.present) {
      map['is_current_user'] = Variable<bool>(isCurrentUser.value);
    }
    if (weeklyCompleted.present) {
      map['weekly_completed'] = Variable<int>(weeklyCompleted.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaderboardUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalCompleted: $totalCompleted, ')
          ..write('isCurrentUser: $isCurrentUser, ')
          ..write('weeklyCompleted: $weeklyCompleted, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $StreaksTable streaks = $StreaksTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $FavouriteQuotesTable favouriteQuotes = $FavouriteQuotesTable(
    this,
  );
  late final $LeaderboardUsersTable leaderboardUsers = $LeaderboardUsersTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tasks,
    goals,
    streaks,
    quotes,
    favouriteQuotes,
    leaderboardUsers,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'quotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favourite_quotes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String title,
      Value<String> description,
      Value<String> category,
      Value<String> priority,
      Value<DateTime?> startAt,
      required DateTime dueAt,
      Value<bool> isDone,
      Value<DateTime?> completedAt,
      Value<String> repeatRule,
      Value<int> reminderLeadMinutes,
      Value<bool> alarmEnabled,
      Value<DateTime> createdAt,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> category,
      Value<String> priority,
      Value<DateTime?> startAt,
      Value<DateTime> dueAt,
      Value<bool> isDone,
      Value<DateTime?> completedAt,
      Value<String> repeatRule,
      Value<int> reminderLeadMinutes,
      Value<bool> alarmEnabled,
      Value<DateTime> createdAt,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatRule => $composableBuilder(
    column: $table.repeatRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderLeadMinutes => $composableBuilder(
    column: $table.reminderLeadMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get alarmEnabled => $composableBuilder(
    column: $table.alarmEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatRule => $composableBuilder(
    column: $table.repeatRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderLeadMinutes => $composableBuilder(
    column: $table.reminderLeadMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get alarmEnabled => $composableBuilder(
    column: $table.alarmEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repeatRule => $composableBuilder(
    column: $table.repeatRule,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderLeadMinutes => $composableBuilder(
    column: $table.reminderLeadMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get alarmEnabled => $composableBuilder(
    column: $table.alarmEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> repeatRule = const Value.absent(),
                Value<int> reminderLeadMinutes = const Value.absent(),
                Value<bool> alarmEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                category: category,
                priority: priority,
                startAt: startAt,
                dueAt: dueAt,
                isDone: isDone,
                completedAt: completedAt,
                repeatRule: repeatRule,
                reminderLeadMinutes: reminderLeadMinutes,
                alarmEnabled: alarmEnabled,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                required DateTime dueAt,
                Value<bool> isDone = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> repeatRule = const Value.absent(),
                Value<int> reminderLeadMinutes = const Value.absent(),
                Value<bool> alarmEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                category: category,
                priority: priority,
                startAt: startAt,
                dueAt: dueAt,
                isDone: isDone,
                completedAt: completedAt,
                repeatRule: repeatRule,
                reminderLeadMinutes: reminderLeadMinutes,
                alarmEnabled: alarmEnabled,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTable, Task>(table),
                  BaseReferences<_$AppDatabase, $TasksTable, Task>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      required String type,
      required int targetCount,
      Value<DateTime> updatedAt,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<int> targetCount,
      Value<DateTime> updatedAt,
    });

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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
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
                Value<String> type = const Value.absent(),
                Value<int> targetCount = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                type: type,
                targetCount: targetCount,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required int targetCount,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                type: type,
                targetCount: targetCount,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, Goal>(table),
                  BaseReferences<_$AppDatabase, $GoalsTable, Goal>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
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
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$StreaksTableCreateCompanionBuilder =
    StreaksCompanion Function({
      required String date,
      Value<int> tasksCompleted,
      Value<bool> goalMet,
      Value<int> rowid,
    });
typedef $$StreaksTableUpdateCompanionBuilder =
    StreaksCompanion Function({
      Value<String> date,
      Value<int> tasksCompleted,
      Value<bool> goalMet,
      Value<int> rowid,
    });

class $$StreaksTableFilterComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get goalMet => $composableBuilder(
    column: $table.goalMet,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StreaksTableOrderingComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get goalMet => $composableBuilder(
    column: $table.goalMet,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StreaksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreaksTable> {
  $$StreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get goalMet =>
      $composableBuilder(column: $table.goalMet, builder: (column) => column);
}

class $$StreaksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StreaksTable,
          Streak,
          $$StreaksTableFilterComposer,
          $$StreaksTableOrderingComposer,
          $$StreaksTableAnnotationComposer,
          $$StreaksTableCreateCompanionBuilder,
          $$StreaksTableUpdateCompanionBuilder,
          (Streak, BaseReferences<_$AppDatabase, $StreaksTable, Streak>),
          Streak,
          PrefetchHooks Function()
        > {
  $$StreaksTableTableManager(_$AppDatabase db, $StreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<int> tasksCompleted = const Value.absent(),
                Value<bool> goalMet = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StreaksCompanion(
                date: date,
                tasksCompleted: tasksCompleted,
                goalMet: goalMet,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                Value<int> tasksCompleted = const Value.absent(),
                Value<bool> goalMet = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StreaksCompanion.insert(
                date: date,
                tasksCompleted: tasksCompleted,
                goalMet: goalMet,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StreaksTable, Streak>(table),
                  BaseReferences<_$AppDatabase, $StreaksTable, Streak>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StreaksTable,
      Streak,
      $$StreaksTableFilterComposer,
      $$StreaksTableOrderingComposer,
      $$StreaksTableAnnotationComposer,
      $$StreaksTableCreateCompanionBuilder,
      $$StreaksTableUpdateCompanionBuilder,
      (Streak, BaseReferences<_$AppDatabase, $StreaksTable, Streak>),
      Streak,
      PrefetchHooks Function()
    >;
typedef $$QuotesTableCreateCompanionBuilder =
    QuotesCompanion Function({
      required String id,
      required String quoteText,
      required String author,
      Value<String> authorImageAsset,
      Value<String> category,
      Value<int> rowid,
    });
typedef $$QuotesTableUpdateCompanionBuilder =
    QuotesCompanion Function({
      Value<String> id,
      Value<String> quoteText,
      Value<String> author,
      Value<String> authorImageAsset,
      Value<String> category,
      Value<int> rowid,
    });

final class $$QuotesTableReferences
    extends BaseReferences<_$AppDatabase, $QuotesTable, Quote> {
  $$QuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FavouriteQuotesTable, List<FavouriteQuote>>
  _favouriteQuotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favouriteQuotes,
    aliasName: 'quotes__id__favourite_quotes__quote_id',
  );

  $$FavouriteQuotesTableProcessedTableManager get favouriteQuotesRefs {
    final manager = $$FavouriteQuotesTableTableManager(
      $_db,
      $_db.favouriteQuotes,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _favouriteQuotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorImageAsset => $composableBuilder(
    column: $table.authorImageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> favouriteQuotesRefs(
    Expression<bool> Function($$FavouriteQuotesTableFilterComposer f) f,
  ) {
    final $$FavouriteQuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favouriteQuotes,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavouriteQuotesTableFilterComposer(
            $db: $db,
            $table: $db.favouriteQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorImageAsset => $composableBuilder(
    column: $table.authorImageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quoteText =>
      $composableBuilder(column: $table.quoteText, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get authorImageAsset => $composableBuilder(
    column: $table.authorImageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  Expression<T> favouriteQuotesRefs<T extends Object>(
    Expression<T> Function($$FavouriteQuotesTableAnnotationComposer a) f,
  ) {
    final $$FavouriteQuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favouriteQuotes,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavouriteQuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.favouriteQuotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          Quote,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (Quote, $$QuotesTableReferences),
          Quote,
          PrefetchHooks Function({bool favouriteQuotesRefs})
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> quoteText = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> authorImageAsset = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                quoteText: quoteText,
                author: author,
                authorImageAsset: authorImageAsset,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String quoteText,
                required String author,
                Value<String> authorImageAsset = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion.insert(
                id: id,
                quoteText: quoteText,
                author: author,
                authorImageAsset: authorImageAsset,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuotesTable, Quote>(table),
                  $$QuotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({favouriteQuotesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (favouriteQuotesRefs) db.favouriteQuotes,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (favouriteQuotesRefs)
                    await $_getPrefetchedDataByColumns<
                      Quote,
                      $QuotesTable,
                      FavouriteQuote,
                      $FavouriteQuotesTable
                    >(
                      currentTable: table,
                      referencedTable: $$QuotesTableReferences
                          ._favouriteQuotesRefsTable(db),
                      managerFromTypedResult: (p0) => $$QuotesTableReferences(
                        db,
                        table,
                        p0,
                      ).favouriteQuotesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'quote_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      Quote,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (Quote, $$QuotesTableReferences),
      Quote,
      PrefetchHooks Function({bool favouriteQuotesRefs})
    >;
typedef $$FavouriteQuotesTableCreateCompanionBuilder =
    FavouriteQuotesCompanion Function({
      required String quoteId,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });
typedef $$FavouriteQuotesTableUpdateCompanionBuilder =
    FavouriteQuotesCompanion Function({
      Value<String> quoteId,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });

final class $$FavouriteQuotesTableReferences
    extends
        BaseReferences<_$AppDatabase, $FavouriteQuotesTable, FavouriteQuote> {
  $$FavouriteQuotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuotesTable _quoteIdTable(_$AppDatabase db) =>
      db.quotes.createAlias('favourite_quotes__quote_id__quotes__id');

  $$QuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<String>('quote_id')!;

    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavouriteQuotesTableFilterComposer
    extends Composer<_$AppDatabase, $FavouriteQuotesTable> {
  $$FavouriteQuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavouriteQuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavouriteQuotesTable> {
  $$FavouriteQuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavouriteQuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavouriteQuotesTable> {
  $$FavouriteQuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavouriteQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavouriteQuotesTable,
          FavouriteQuote,
          $$FavouriteQuotesTableFilterComposer,
          $$FavouriteQuotesTableOrderingComposer,
          $$FavouriteQuotesTableAnnotationComposer,
          $$FavouriteQuotesTableCreateCompanionBuilder,
          $$FavouriteQuotesTableUpdateCompanionBuilder,
          (FavouriteQuote, $$FavouriteQuotesTableReferences),
          FavouriteQuote,
          PrefetchHooks Function({bool quoteId})
        > {
  $$FavouriteQuotesTableTableManager(
    _$AppDatabase db,
    $FavouriteQuotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavouriteQuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavouriteQuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavouriteQuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> quoteId = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavouriteQuotesCompanion(
                quoteId: quoteId,
                likedAt: likedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String quoteId,
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavouriteQuotesCompanion.insert(
                quoteId: quoteId,
                likedAt: likedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavouriteQuotesTable, FavouriteQuote>(table),
                  $$FavouriteQuotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quoteId = false}) {
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
                    if (quoteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.quoteId,
                                referencedTable:
                                    $$FavouriteQuotesTableReferences
                                        ._quoteIdTable(db),
                                referencedColumn:
                                    $$FavouriteQuotesTableReferences
                                        ._quoteIdTable(db)
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

typedef $$FavouriteQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavouriteQuotesTable,
      FavouriteQuote,
      $$FavouriteQuotesTableFilterComposer,
      $$FavouriteQuotesTableOrderingComposer,
      $$FavouriteQuotesTableAnnotationComposer,
      $$FavouriteQuotesTableCreateCompanionBuilder,
      $$FavouriteQuotesTableUpdateCompanionBuilder,
      (FavouriteQuote, $$FavouriteQuotesTableReferences),
      FavouriteQuote,
      PrefetchHooks Function({bool quoteId})
    >;
typedef $$LeaderboardUsersTableCreateCompanionBuilder =
    LeaderboardUsersCompanion Function({
      required String id,
      required String name,
      Value<String> avatarAsset,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> totalCompleted,
      Value<bool> isCurrentUser,
      Value<int> weeklyCompleted,
      Value<int> totalPoints,
      Value<int> rowid,
    });
typedef $$LeaderboardUsersTableUpdateCompanionBuilder =
    LeaderboardUsersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> avatarAsset,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> totalCompleted,
      Value<bool> isCurrentUser,
      Value<int> weeklyCompleted,
      Value<int> totalPoints,
      Value<int> rowid,
    });

class $$LeaderboardUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LeaderboardUsersTable> {
  $$LeaderboardUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCompleted => $composableBuilder(
    column: $table.totalCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrentUser => $composableBuilder(
    column: $table.isCurrentUser,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyCompleted => $composableBuilder(
    column: $table.weeklyCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaderboardUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaderboardUsersTable> {
  $$LeaderboardUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCompleted => $composableBuilder(
    column: $table.totalCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrentUser => $composableBuilder(
    column: $table.isCurrentUser,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyCompleted => $composableBuilder(
    column: $table.weeklyCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaderboardUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaderboardUsersTable> {
  $$LeaderboardUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCompleted => $composableBuilder(
    column: $table.totalCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCurrentUser => $composableBuilder(
    column: $table.isCurrentUser,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeklyCompleted => $composableBuilder(
    column: $table.weeklyCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );
}

class $$LeaderboardUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaderboardUsersTable,
          LeaderboardUser,
          $$LeaderboardUsersTableFilterComposer,
          $$LeaderboardUsersTableOrderingComposer,
          $$LeaderboardUsersTableAnnotationComposer,
          $$LeaderboardUsersTableCreateCompanionBuilder,
          $$LeaderboardUsersTableUpdateCompanionBuilder,
          (
            LeaderboardUser,
            BaseReferences<
              _$AppDatabase,
              $LeaderboardUsersTable,
              LeaderboardUser
            >,
          ),
          LeaderboardUser,
          PrefetchHooks Function()
        > {
  $$LeaderboardUsersTableTableManager(
    _$AppDatabase db,
    $LeaderboardUsersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaderboardUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaderboardUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaderboardUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> avatarAsset = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> totalCompleted = const Value.absent(),
                Value<bool> isCurrentUser = const Value.absent(),
                Value<int> weeklyCompleted = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardUsersCompanion(
                id: id,
                name: name,
                avatarAsset: avatarAsset,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                totalCompleted: totalCompleted,
                isCurrentUser: isCurrentUser,
                weeklyCompleted: weeklyCompleted,
                totalPoints: totalPoints,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> avatarAsset = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> totalCompleted = const Value.absent(),
                Value<bool> isCurrentUser = const Value.absent(),
                Value<int> weeklyCompleted = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaderboardUsersCompanion.insert(
                id: id,
                name: name,
                avatarAsset: avatarAsset,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                totalCompleted: totalCompleted,
                isCurrentUser: isCurrentUser,
                weeklyCompleted: weeklyCompleted,
                totalPoints: totalPoints,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LeaderboardUsersTable, LeaderboardUser>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LeaderboardUsersTable,
                    LeaderboardUser
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaderboardUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaderboardUsersTable,
      LeaderboardUser,
      $$LeaderboardUsersTableFilterComposer,
      $$LeaderboardUsersTableOrderingComposer,
      $$LeaderboardUsersTableAnnotationComposer,
      $$LeaderboardUsersTableCreateCompanionBuilder,
      $$LeaderboardUsersTableUpdateCompanionBuilder,
      (
        LeaderboardUser,
        BaseReferences<_$AppDatabase, $LeaderboardUsersTable, LeaderboardUser>,
      ),
      LeaderboardUser,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$StreaksTableTableManager get streaks =>
      $$StreaksTableTableManager(_db, _db.streaks);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$FavouriteQuotesTableTableManager get favouriteQuotes =>
      $$FavouriteQuotesTableTableManager(_db, _db.favouriteQuotes);
  $$LeaderboardUsersTableTableManager get leaderboardUsers =>
      $$LeaderboardUsersTableTableManager(_db, _db.leaderboardUsers);
}
