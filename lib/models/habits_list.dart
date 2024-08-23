import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:http/http.dart' as http;

class HabitsList extends StateNotifier<List<Habit>> {
  HabitsList(super.state);

  void addHabit(Habit newHabit) {
    state = [...state, newHabit];
  }

  //metodo per aggiungere gli habits, quindi per sfruttare richiesta http tramite riverpod
  void addHabits(List<Habit> newHabits) {
    for (final newHabit in newHabits) {
      final index = state.indexWhere((habit) => habit.id == newHabit.id);
      if (index != -1) {
        state[index] = newHabit;
      } else {
        state.add(newHabit);
      }
    }
  }

  //metodo più sensato per richiesta http
  Future<void> addHabitsFromHttp() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.72:8000/habits.json"));
    if (response.statusCode != 200) {
      throw Exception(
          "Failed to access resource (status code: ${response.statusCode})");
    }

    List<dynamic> json = jsonDecode(response.body);
    final importedHabits = json.map((e) => Habit.fromJson(e)).toList();

    //metodo che dovrebbe funzionare ma meno efficiente
    for (final newHabit in importedHabits) {
      final index = state.indexWhere((habit) => habit.id == newHabit.id);
      if (index != -1) {
        state = [...state]..[index] = newHabit;
      } else {
        state = [...state, newHabit];
      }
    }

    /*
    //aggiungo i nuovi elementi allo state, sostituendo gli habit con lo stesso id
    final List<Habit> buffer = state;
    for (final newHabit in importedHabits) {
      final index = state.indexWhere((habit) => habit.id == newHabit.id);
      if (index != -1) {
        buffer.removeAt(index);
        buffer.insert(index, newHabit);
      } else {
        buffer.add(newHabit);
      }
    }

    //notifico una sola volta il cambio di stato
    state = buffer;
    */
  }

  void setHabitDoneToday(String id, bool? checked) {
    if (checked == true) {
      state = state.map((habit) {
        if (habit.id == id) {
          return Habit(
            id: habit.id,
            name: habit.name,
            description: habit.description,
            completionDates: [...habit.completionDates, DateTime.now()],
          );
        } else {
          return habit;
        }
      }).toList();
    } else {
      state = state.map((habit) {
        if (habit.id == id) {
          final today = DateTime.now();
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
      }).toList();
    }
  }

  void removeHabit(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}
