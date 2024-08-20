import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitItemPage extends ConsumerWidget {
  const HabitItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habit = ref.watch(currentHabitProvider);
    //final habitslist = ref.watch(habitsProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(habit.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Modifica',
              onPressed: () {
                // Logica
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Cancella',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete habit?'),
                      content: const Text(
                          'The habit will be permanently deleted.\nThis action cannot be undone.'),
                      actions: [
                        TextButton(
                          child: const Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('YES'),
                          onPressed: () {
                            ref
                                .read(habitsProvider.notifier)
                                .removeHabit(habit.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                ),
                Expanded(
                  child: TableCalendar(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2050),
                    focusedDay: DateTime.now(),
                    calendarFormat: CalendarFormat.month,
                    // selectedDayPredicate: (day) {
                    //   return habit.completionDates.any((date) =>
                    //       date.year == day.year &&
                    //       date.month == day.month &&
                    //       date.day == day.day);
                    // },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (habit.completionDates.any((date) =>
                            date.year == day.year &&
                            date.month == day.month &&
                            date.day == day.day)) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            width: 10,
                            height: 10,
                          );
                        } else {
                          return null;
                        }
                      },
                      // todayBuilder: (context, day, focusedDay) {
                      //   return Container(
                      //     margin: const EdgeInsets.all(4),
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Theme.of(context).colorScheme.primary,
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         day.day.toString(),
                      //         style: TextStyle(
                      //           color: Theme.of(context).colorScheme.onPrimary,
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // },
                    ),
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: false,
                    ),
                  ),
                ),
              ],
            )));
  }
}