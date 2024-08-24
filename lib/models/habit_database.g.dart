// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_database.dart';

// ignore_for_file: type=lint
class $HabitsTableTable extends HabitsTable
    with TableInfo<$HabitsTableTable, DatabaseHabit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 32, maxTextLength: 38),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _addedOnMeta =
      const VerificationMeta('addedOn');
  @override
  late final GeneratedColumn<DateTime> addedOn = GeneratedColumn<DateTime>(
      'added_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, description, addedOn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits_table';
  @override
  VerificationContext validateIntegrity(Insertable<DatabaseHabit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('added_on')) {
      context.handle(_addedOnMeta,
          addedOn.isAcceptableOrUnknown(data['added_on']!, _addedOnMeta));
    } else if (isInserting) {
      context.missing(_addedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseHabit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseHabit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      addedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_on'])!,
    );
  }

  @override
  $HabitsTableTable createAlias(String alias) {
    return $HabitsTableTable(attachedDatabase, alias);
  }
}

class DatabaseHabit extends DataClass implements Insertable<DatabaseHabit> {
  final String id;
  final String name;
  final String description;
  final DateTime addedOn;
  const DatabaseHabit(
      {required this.id,
      required this.name,
      required this.description,
      required this.addedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['added_on'] = Variable<DateTime>(addedOn);
    return map;
  }

  HabitsTableCompanion toCompanion(bool nullToAbsent) {
    return HabitsTableCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      addedOn: Value(addedOn),
    );
  }

  factory DatabaseHabit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseHabit(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      addedOn: serializer.fromJson<DateTime>(json['addedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'addedOn': serializer.toJson<DateTime>(addedOn),
    };
  }

  DatabaseHabit copyWith(
          {String? id, String? name, String? description, DateTime? addedOn}) =>
      DatabaseHabit(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        addedOn: addedOn ?? this.addedOn,
      );
  DatabaseHabit copyWithCompanion(HabitsTableCompanion data) {
    return DatabaseHabit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      addedOn: data.addedOn.present ? data.addedOn.value : this.addedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseHabit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('addedOn: $addedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, addedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseHabit &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.addedOn == this.addedOn);
}

class HabitsTableCompanion extends UpdateCompanion<DatabaseHabit> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> addedOn;
  final Value<int> rowid;
  const HabitsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.addedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsTableCompanion.insert({
    required String id,
    required String name,
    required String description,
    required DateTime addedOn,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        addedOn = Value(addedOn);
  static Insertable<DatabaseHabit> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? addedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (addedOn != null) 'added_on': addedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<DateTime>? addedOn,
      Value<int>? rowid}) {
    return HabitsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      addedOn: addedOn ?? this.addedOn,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (addedOn.present) {
      map['added_on'] = Variable<DateTime>(addedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('addedOn: $addedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompletionDatesTableTable extends CompletionDatesTable
    with TableInfo<$CompletionDatesTableTable, CompletionDates> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletionDatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 32, maxTextLength: 38),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  @override
  late final GeneratedColumn<DateTime> completionDate =
      GeneratedColumn<DateTime>('completion_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [habitId, completionDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completion_dates_table';
  @override
  VerificationContext validateIntegrity(Insertable<CompletionDates> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date']!, _completionDateMeta));
    } else if (isInserting) {
      context.missing(_completionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, completionDate};
  @override
  CompletionDates map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletionDates(
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      completionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completion_date'])!,
    );
  }

  @override
  $CompletionDatesTableTable createAlias(String alias) {
    return $CompletionDatesTableTable(attachedDatabase, alias);
  }
}

class CompletionDates extends DataClass implements Insertable<CompletionDates> {
  final String habitId;
  final DateTime completionDate;
  const CompletionDates({required this.habitId, required this.completionDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['completion_date'] = Variable<DateTime>(completionDate);
    return map;
  }

  CompletionDatesTableCompanion toCompanion(bool nullToAbsent) {
    return CompletionDatesTableCompanion(
      habitId: Value(habitId),
      completionDate: Value(completionDate),
    );
  }

  factory CompletionDates.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletionDates(
      habitId: serializer.fromJson<String>(json['habitId']),
      completionDate: serializer.fromJson<DateTime>(json['completionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'completionDate': serializer.toJson<DateTime>(completionDate),
    };
  }

  CompletionDates copyWith({String? habitId, DateTime? completionDate}) =>
      CompletionDates(
        habitId: habitId ?? this.habitId,
        completionDate: completionDate ?? this.completionDate,
      );
  CompletionDates copyWithCompanion(CompletionDatesTableCompanion data) {
    return CompletionDates(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      completionDate: data.completionDate.present
          ? data.completionDate.value
          : this.completionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletionDates(')
          ..write('habitId: $habitId, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, completionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletionDates &&
          other.habitId == this.habitId &&
          other.completionDate == this.completionDate);
}

class CompletionDatesTableCompanion extends UpdateCompanion<CompletionDates> {
  final Value<String> habitId;
  final Value<DateTime> completionDate;
  final Value<int> rowid;
  const CompletionDatesTableCompanion({
    this.habitId = const Value.absent(),
    this.completionDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletionDatesTableCompanion.insert({
    required String habitId,
    required DateTime completionDate,
    this.rowid = const Value.absent(),
  })  : habitId = Value(habitId),
        completionDate = Value(completionDate);
  static Insertable<CompletionDates> custom({
    Expression<String>? habitId,
    Expression<DateTime>? completionDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (completionDate != null) 'completion_date': completionDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletionDatesTableCompanion copyWith(
      {Value<String>? habitId,
      Value<DateTime>? completionDate,
      Value<int>? rowid}) {
    return CompletionDatesTableCompanion(
      habitId: habitId ?? this.habitId,
      completionDate: completionDate ?? this.completionDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletionDatesTableCompanion(')
          ..write('habitId: $habitId, ')
          ..write('completionDate: $completionDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$HabitDatabase extends GeneratedDatabase {
  _$HabitDatabase(QueryExecutor e) : super(e);
  $HabitDatabaseManager get managers => $HabitDatabaseManager(this);
  late final $HabitsTableTable habitsTable = $HabitsTableTable(this);
  late final $CompletionDatesTableTable completionDatesTable =
      $CompletionDatesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [habitsTable, completionDatesTable];
}

typedef $$HabitsTableTableCreateCompanionBuilder = HabitsTableCompanion
    Function({
  required String id,
  required String name,
  required String description,
  required DateTime addedOn,
  Value<int> rowid,
});
typedef $$HabitsTableTableUpdateCompanionBuilder = HabitsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<DateTime> addedOn,
  Value<int> rowid,
});

class $$HabitsTableTableFilterComposer
    extends FilterComposer<_$HabitDatabase, $HabitsTableTable> {
  $$HabitsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get addedOn => $state.composableBuilder(
      column: $state.table.addedOn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HabitsTableTableOrderingComposer
    extends OrderingComposer<_$HabitDatabase, $HabitsTableTable> {
  $$HabitsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get addedOn => $state.composableBuilder(
      column: $state.table.addedOn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$HabitsTableTableTableManager extends RootTableManager<
    _$HabitDatabase,
    $HabitsTableTable,
    DatabaseHabit,
    $$HabitsTableTableFilterComposer,
    $$HabitsTableTableOrderingComposer,
    $$HabitsTableTableCreateCompanionBuilder,
    $$HabitsTableTableUpdateCompanionBuilder,
    (
      DatabaseHabit,
      BaseReferences<_$HabitDatabase, $HabitsTableTable, DatabaseHabit>
    ),
    DatabaseHabit,
    PrefetchHooks Function()> {
  $$HabitsTableTableTableManager(_$HabitDatabase db, $HabitsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HabitsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HabitsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> addedOn = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsTableCompanion(
            id: id,
            name: name,
            description: description,
            addedOn: addedOn,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required DateTime addedOn,
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsTableCompanion.insert(
            id: id,
            name: name,
            description: description,
            addedOn: addedOn,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitsTableTableProcessedTableManager = ProcessedTableManager<
    _$HabitDatabase,
    $HabitsTableTable,
    DatabaseHabit,
    $$HabitsTableTableFilterComposer,
    $$HabitsTableTableOrderingComposer,
    $$HabitsTableTableCreateCompanionBuilder,
    $$HabitsTableTableUpdateCompanionBuilder,
    (
      DatabaseHabit,
      BaseReferences<_$HabitDatabase, $HabitsTableTable, DatabaseHabit>
    ),
    DatabaseHabit,
    PrefetchHooks Function()>;
typedef $$CompletionDatesTableTableCreateCompanionBuilder
    = CompletionDatesTableCompanion Function({
  required String habitId,
  required DateTime completionDate,
  Value<int> rowid,
});
typedef $$CompletionDatesTableTableUpdateCompanionBuilder
    = CompletionDatesTableCompanion Function({
  Value<String> habitId,
  Value<DateTime> completionDate,
  Value<int> rowid,
});

class $$CompletionDatesTableTableFilterComposer
    extends FilterComposer<_$HabitDatabase, $CompletionDatesTableTable> {
  $$CompletionDatesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get habitId => $state.composableBuilder(
      column: $state.table.habitId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completionDate => $state.composableBuilder(
      column: $state.table.completionDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CompletionDatesTableTableOrderingComposer
    extends OrderingComposer<_$HabitDatabase, $CompletionDatesTableTable> {
  $$CompletionDatesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get habitId => $state.composableBuilder(
      column: $state.table.habitId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completionDate => $state.composableBuilder(
      column: $state.table.completionDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$CompletionDatesTableTableTableManager extends RootTableManager<
    _$HabitDatabase,
    $CompletionDatesTableTable,
    CompletionDates,
    $$CompletionDatesTableTableFilterComposer,
    $$CompletionDatesTableTableOrderingComposer,
    $$CompletionDatesTableTableCreateCompanionBuilder,
    $$CompletionDatesTableTableUpdateCompanionBuilder,
    (
      CompletionDates,
      BaseReferences<_$HabitDatabase, $CompletionDatesTableTable,
          CompletionDates>
    ),
    CompletionDates,
    PrefetchHooks Function()> {
  $$CompletionDatesTableTableTableManager(
      _$HabitDatabase db, $CompletionDatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$CompletionDatesTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$CompletionDatesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> habitId = const Value.absent(),
            Value<DateTime> completionDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompletionDatesTableCompanion(
            habitId: habitId,
            completionDate: completionDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String habitId,
            required DateTime completionDate,
            Value<int> rowid = const Value.absent(),
          }) =>
              CompletionDatesTableCompanion.insert(
            habitId: habitId,
            completionDate: completionDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CompletionDatesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$HabitDatabase,
        $CompletionDatesTableTable,
        CompletionDates,
        $$CompletionDatesTableTableFilterComposer,
        $$CompletionDatesTableTableOrderingComposer,
        $$CompletionDatesTableTableCreateCompanionBuilder,
        $$CompletionDatesTableTableUpdateCompanionBuilder,
        (
          CompletionDates,
          BaseReferences<_$HabitDatabase, $CompletionDatesTableTable,
              CompletionDates>
        ),
        CompletionDates,
        PrefetchHooks Function()>;

class $HabitDatabaseManager {
  final _$HabitDatabase _db;
  $HabitDatabaseManager(this._db);
  $$HabitsTableTableTableManager get habitsTable =>
      $$HabitsTableTableTableManager(_db, _db.habitsTable);
  $$CompletionDatesTableTableTableManager get completionDatesTable =>
      $$CompletionDatesTableTableTableManager(_db, _db.completionDatesTable);
}
