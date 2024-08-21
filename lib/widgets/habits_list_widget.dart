import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/screens/habit_item_page.dart';

class HabitsListWidget extends ConsumerWidget {
  const HabitsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);

    return ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return ProviderScope(overrides: [
            currentHabitProvider.overrideWithValue(habits[index])
          ], child: _HabitListViewItem());
        });
  }
}

class _HabitListViewItem extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habit = ref.watch(currentHabitProvider);

    return GestureDetector(
      onLongPress: () {
        debugPrint('Hai tenuto premuto: $habit.name}');
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HabitItemPage(habit.id);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        padding: const EdgeInsets.all(8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Text(
              habit.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Checkbox(
              value: habit.completionDates.any((date) =>
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day),
              onChanged: (checked) {
                ref
                    .read(habitsProvider.notifier)
                    .setHabitDoneToday(habit.id, checked);
              })
        ]),
      ),
    );
  }
}
