import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';

class HabitsList extends StateNotifier<List<Habit>>{
  HabitsList(super.state);

  void addHabit(Habit newHabit){
    final List<Habit> newHabits = [];
    newHabits.addAll(state);
    newHabits.add(newHabit);

    state = newHabits;

  }
}