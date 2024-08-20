import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';

class HabitsList extends StateNotifier<List<Habit>> {
  HabitsList(super.state);

  void addHabit(Habit newHabit) {
    state = [...state, newHabit];
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
