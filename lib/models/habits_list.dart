import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:habitsapp/models/habit_database.dart';
import 'package:http/http.dart' as http;

class HabitsList extends StateNotifier<List<Habit>> {
  HabitDatabase database;

  HabitsList(super.state, this.database);

  Future init() async {
    state = await database.allHabits;
  }

  Future addHabit(Habit newHabit) async {
    state = [...state, newHabit];

    await database.addHabit(newHabit.id, newHabit.name, newHabit.description,
        newHabit.completionDates);
  }

  Future updateHabit(Habit newUpdatedHabit) async {
    final index = state.indexWhere((habit) => habit.id == newUpdatedHabit.id);

    state = [...state]..[index] = newUpdatedHabit;
    await database.updateHabit(newUpdatedHabit.id, newUpdatedHabit.name,
        newUpdatedHabit.description, newUpdatedHabit.completionDates);
  }

  Future<void> addHabitsFromHttp(String addressString) async {
    try {
      final response = await http.get(Uri.parse(addressString));
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to access resource (status code: ${response.statusCode})");
      }

      List<dynamic> json = jsonDecode(response.body);
      final importedHabits = json.map((e) => Habit.fromJson(e)).toList();

      for (final newHabit in importedHabits) {
        final index = state.indexWhere((habit) => habit.id == newHabit.id);
        if (index != -1) {
          state = [...state]..[index] = newHabit;
          await database.updateHabit(newHabit.id, newHabit.name,
              newHabit.description, newHabit.completionDates);
        } else {
          state = [...state, newHabit];
          await database.addHabit(newHabit.id, newHabit.name,
              newHabit.description, newHabit.completionDates);
        }
      }
    } on SocketException {
      throw Exception("No response");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<void> setHabitDoneToday(String id, bool? checked) async {
    if (checked == true) {
      state = await Future.wait(state.map((habit) async {
        if (habit.id == id) {
          await database.updateHabit(
            habit.id,
            habit.name,
            habit.description,
            [...habit.completionDates, DateTime.now()],
          );
          return Habit(
            id: habit.id,
            name: habit.name,
            description: habit.description,
            completionDates: [...habit.completionDates, DateTime.now()],
          );
        } else {
          return habit;
        }
      }));
    } else {
      state = await Future.wait(state.map((habit) async {
        if (habit.id == id) {
          final today = DateTime.now();
          await database.updateHabit(
            habit.id,
            habit.name,
            habit.description,
            habit.completionDates
                .where((date) =>
                    date.year != today.year ||
                    date.month != today.month ||
                    date.day != today.day)
                .toList(),
          );
          return Habit(
            id: habit.id,
            name: habit.name,
            description: habit.description,
            completionDates: habit.completionDates
                .where((date) =>
                    date.year != today.year ||
                    date.month != today.month ||
                    date.day != today.day)
                .toList(),
          );
        } else {
          return habit;
        }
      }));
    }
  }

  Future<void> removeHabit(String id) async {
    state = state.where((element) => element.id != id).toList();
    await database.removeHabit(id);
  }
}
