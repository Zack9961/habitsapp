import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:habitsapp/models/habit_database.dart';
import 'package:habitsapp/models/habits_list.dart';
import 'package:habitsapp/screens/new_habit_page.dart';
import 'package:habitsapp/widgets/habits_list_widget.dart';
import 'package:uuid/uuid.dart';
/*
final httpHabitsProvider = FutureProvider((ref) async {
  final response =
      await http.get(Uri.parse("http://192.168.1.72:8000/habits.json"));
  if (response.statusCode != 200) {
    throw Exception(
        "Failed to access resource (status code: ${response.statusCode})");
  }

  List<dynamic> json = jsonDecode(response.body);

  final habits = json.map((e) => Habit.fromJson(e)).toList();

  return habits;
});*/

final databaseProvider = Provider(
  (ref) => HabitDatabase(),
);

final habitsProvider =
    StateNotifierProvider<HabitsList, List<Habit>>((ref) => HabitsList([
          // Habit(
          //     id: const Uuid().v4(),
          //     name: 'Esercizio fisico',
          //     description: 'Fai esercizio per almeno 30 minuti al giorno.',
          //     completionDates: [
          //       DateTime.now(),
          //       DateTime.now().subtract(const Duration(days: 1)),
          //       DateTime.now().subtract(const Duration(days: 4)),
          //       DateTime.now().subtract(const Duration(days: 8))
          //     ]),
          // Habit(
          //     id: const Uuid().v4(),
          //     name: 'Meditazione',
          //     description: 'Meditare per 10 minuti ogni giorno.'),
          // Habit(
          //     id: const Uuid().v4(),
          //     name: 'Lettura',
          //     description: 'Leggi almeno 20 pagine di un libro al giorno.'),
          // Habit(
          //     id: const Uuid().v4(),
          //     name: 'Scrittura',
          //     description: 'Scrivi un diario ogni sera.'),
          // Habit(
          //     id: const Uuid().v4(),
          //     name: 'Bere acqua',
          //     description: 'Bevi almeno 2 litri di acqua al giorno.'),
        ], ref.watch(databaseProvider)));

final specificHabitProvider = Provider.family<Habit, String>((ref, habitId) =>
    ref.watch(habitsProvider).where((h) => h.id == habitId).single);

// Provider ausiliario che espone l'oggetto Habit "corrente" (selezionato/aperto)
final currentHabitProvider =
    Provider<Habit>((ref) => throw UnimplementedError());

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(habitsProvider.notifier).init();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewHabitPage();
              }));
            },
          ),
          IconButton(
            icon: const Icon(Icons.cloud_download),
            tooltip: 'Download and Import',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Import habits?'),
                    content: const Text(
                        'The habits will be imported from http.\n Habits with same ID will be replaced.'),
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
                          ref.read(habitsProvider.notifier).addHabitsFromHttp();
                          debugPrint(
                              "E' stata avviata la funzione addhabitsfromhttp");
                          Navigator.of(context).pop();

                          /*
                          final pippo = ref.watch(httpHabitsProvider);

                          pippo.when(
                              data: (data) => ref
                                  .read(habitsProvider.notifier)
                                  .addHabits(data),
                              error: (error, stackTrace) =>
                                  Center(child: Text(error.toString())),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()));
                          
                          Navigator.of(context).pop();
                          */
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(right: 18),
            child: OrientationBuilder(builder: (context, orientation) {
              final currentOrientation = MediaQuery.of(context).orientation;
              //debugPrint("Mi sono refreshato: $currentOrientation");
              if (currentOrientation == Orientation.portrait) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('Today')],
                );
              } else {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Yesterday"),
                    SizedBox(width: 16),
                    Text('Today')
                  ],
                );
              }
            }),
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