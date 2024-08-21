import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:habitsapp/models/habits_list.dart';
import 'package:habitsapp/screens/new_habit_page.dart';
import 'package:habitsapp/widgets/habits_list_widget.dart';
import 'package:uuid/uuid.dart';

final habitsProvider =
    StateNotifierProvider<HabitsList, List<Habit>>((ref) => HabitsList([
          Habit(
              id: const Uuid().v4(),
              name: 'Esercizio fisico',
              description: 'Fai esercizio per almeno 30 minuti al giorno.',
              completionDates: [
                DateTime.now(),
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().subtract(const Duration(days: 8))
              ]),
          Habit(
              id: const Uuid().v4(),
              name: 'Meditazione',
              description: 'Meditare per 10 minuti ogni giorno.'),
          Habit(
              id: const Uuid().v4(),
              name: 'Lettura',
              description: 'Leggi almeno 20 pagine di un libro al giorno.'),
          Habit(
              id: const Uuid().v4(),
              name: 'Scrittura',
              description: 'Scrivi un diario ogni sera.'),
          Habit(
              id: const Uuid().v4(),
              name: 'Bere acqua',
              description: 'Bevi almeno 2 litri di acqua al giorno.'),
        ]));

final specificHabitProvider = Provider.family<Habit, String>((ref, habitId) =>
    ref.watch(habitsProvider).where((h) => h.id == habitId).single);

// Provider ausiliario che espone l'oggetto Habit "corrente" (selezionato/aperto)
final currentHabitProvider =
    Provider<Habit>((ref) => throw UnimplementedError());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(primary: Colors.blueAccent),
          useMaterial3: true,
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Habits App'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create habit',
            onPressed: () {
              //ref.watch(habitsProvider.notifier).addHabit(Habit(
              //    id: const Uuid().v4(), name: "Prova", description: "Prova"));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewHabitPage();
              }));
            },
          ),
          IconButton(
            icon: const Icon(Icons.cloud_download),
            tooltip: 'Download and Import',
            onPressed: () {
              // Logica
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(right: 18),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Today'),
              ],
            ),
          ),
        ),
      ),
      body: const HabitsListWidget(),
    );
  }
}


/* Da canc
floatingActionButton: FloatingActionButton(
        tooltip: 'Aggiungi Abitudine',
        onPressed: () {
          // Logica per aggiungere una nuova abitudine

          ref.watch(habitsProvider.notifier).addHabit(Habit(
              id: Random().nextInt(1000), name: "Prova", description: "Prova"));
        },
        child: const Icon(Icons.add),
      ),
*/