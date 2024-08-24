import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' as m;
import 'package:habitsapp/models/habit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'habit_database.g.dart';

@DataClassName('DatabaseHabit')
class HabitsTable extends Table {
  TextColumn get id => text().named('id').withLength(min: 32, max: 38)();
  TextColumn get name => text()();
  TextColumn get description => text().withLength(max: 255)();
  DateTimeColumn get addedOn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CompletionDates')
class CompletionDatesTable extends Table {
  TextColumn get habitId =>
      text().named('habit_id').withLength(min: 32, max: 38)();
  DateTimeColumn get completionDate => dateTime()();

  @override
  Set<Column> get primaryKey => {habitId, completionDate};
}

@DriftDatabase(tables: [HabitsTable, CompletionDatesTable])
class HabitDatabase extends _$HabitDatabase {
  HabitDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // if(from < 2) {
        // ... applica la migrazione da versione 1 a 2 ...
        // }

        // if(from < 3) {
        // ... applica la migrazione da versione 2 a 3 ...
        // }

        // ... fino alla versione corrente, vedi schemaVersion sopra
      },
    );
  }

  // Future<Habit> _fromDbToInternal(DatabaseHabit r) async {
  //   final completionDates = await (select(completionDatesTable)
  //         ..where((e) => e.habitId.equals(r.id)))
  //       .map((e) => e.completionDate)
  //       .get();

  //   return Habit(
  //     id: r.id,
  //     name: r.name,
  //     description: r.description,
  //     completionDates: completionDates,
  //   );
  // }

  Future<List<Habit>> get allHabits async {
    m.debugPrint("Retrieving all habits from DB");

    final query = select(habitsTable)
      ..orderBy([(e) => OrderingTerm.asc(e.addedOn)]);

    final habits = await query.get();
    return await Future.wait(habits.map((r) async {
      final completionDates = await (select(completionDatesTable)
            ..where((e) => e.habitId.equals(r.id)))
          .map((e) => e.completionDate)
          .get();

      return Habit(
        id: r.id,
        name: r.name,
        description: r.description,
        completionDates: completionDates,
      );
    }));
  }

  Future addHabit(String id, String name, String? description,
      List<DateTime> completionDates) {
    m.debugPrint("Adding new habit $id = $name");

    return transaction(() async {
      await into(habitsTable).insert(HabitsTableCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description ?? ''),
        addedOn: Value(DateTime.now().toUtc()),
      ));

      for (var completionDate in completionDates) {
        await into(completionDatesTable).insert(CompletionDatesTableCompanion(
          habitId: Value(id),
          completionDate: Value(completionDate.toUtc()),
        ));
      }
    });
  }

  Future updateHabit(String id, String name, String? description,
      List<DateTime> completionDates) {
    m.debugPrint("Updating habit $id = $name");

    return transaction(() async {
      await (update(habitsTable)..where((tbl) => tbl.id.equals(id))).write(
        HabitsTableCompanion(
          name: Value(name),
          description: Value(description ?? ''),
        ),
      );

      await (delete(completionDatesTable)
            ..where((tbl) => tbl.habitId.equals(id)))
          .go();

      for (var completionDate in completionDates) {
        await into(completionDatesTable).insert(CompletionDatesTableCompanion(
          habitId: Value(id),
          completionDate: Value(completionDate.toUtc()),
        ));
      }
    });
  }

  Future removeHabit(String id) {
    m.debugPrint("Removing habit $id");

    return transaction(() async {
      await (delete(habitsTable)..where((tbl) => tbl.id.equals(id))).go();
      await (delete(completionDatesTable)
            ..where((tbl) => tbl.habitId.equals(id)))
          .go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    m.debugPrint("Opening SQlite connection");

    final docRoot = await getApplicationDocumentsDirectory();
    final filepath = File(path.join(docRoot.absolute.path, 'database.sqlite'));
    m.debugPrint("SQLite file at $filepath");

    return NativeDatabase.createInBackground(filepath);
  });
}
