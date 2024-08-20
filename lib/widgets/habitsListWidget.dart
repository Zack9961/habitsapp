import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:habitsapp/screens/habitItemPage.dart';

class HabitsListWidget extends ConsumerWidget {
  const HabitsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);

    return ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              debugPrint('Hai tenuto premuto: ${habits[index].name}');
            },
            onTap: () {
              final habit = habits[index];
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ProviderScope(
                    overrides: [currentHabitProvider.overrideWithValue(habit)],
                    child: const HabitItemPage());
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    width: 1),
                borderRadius: BorderRadius.circular(0), // Angoli arrotondati
              ),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(habits[index].name),
                    Checkbox(
                        value: habits[index].completionDates.any((date) =>
                            date.year == DateTime.now().year &&
                            date.month == DateTime.now().month &&
                            date.day == DateTime.now().day),
                        onChanged: (checked) {
                          ref
                              .read(habitsProvider.notifier)
                              .setHabitDoneToday(habits[index].id, checked);
                        })
                  ]),
            ),
          );
        });
  }
}
