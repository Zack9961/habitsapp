import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';

class HabitItemPage extends ConsumerWidget {
  const HabitItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habit = ref.watch(currentHabitProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Habit")),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(habit.name,
                    style: Theme.of(context).textTheme.displaySmall),
                if (habit.description != null)
                  Text(habit.description!,
                      style: Theme.of(context).textTheme.bodyLarge),
                Row(
                  children: [
                    const Text("Today: "),
                    Checkbox(
                        value: habit.completionDates.any((date) =>
                            date.year == DateTime.now().year &&
                            date.month == DateTime.now().month &&
                            date.day == DateTime.now().day),
                        onChanged: (checked) {
                          if (checked != null) {
                            // Questo non funziona come vorremmo (!)
                            ref.read(habitsProvider.notifier);
                            //.setTodoDone(habit.id, checked);
                          }
                        }),
                  ],
                )
              ],
            )));
  }
}
