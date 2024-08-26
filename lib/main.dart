import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:habitsapp/models/habit_database.dart';
import 'package:habitsapp/models/habits_list.dart';
import 'package:habitsapp/screens/new_habit_page.dart';
import 'package:habitsapp/widgets/habits_list_widget.dart';

final addressStringProvider =
    Provider((ref) => "http://192.168.1.72:8000/habits.json");

final databaseProvider = Provider(
  (ref) => HabitDatabase(),
);

final habitsProvider = StateNotifierProvider<HabitsList, List<Habit>>(
    (ref) => HabitsList([], ref.watch(databaseProvider)));

final specificHabitProvider = Provider.family<Habit, String>((ref, habitId) =>
    ref.watch(habitsProvider).where((h) => h.id == habitId).single);

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
    final addressString = ref.read(addressStringProvider);
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
                    content: Text(
                        'The habits will be imported from this http address: $addressString.\nHabits with same ID will be replaced.'),
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
                              .addHabitsFromHttp(addressString);
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(right: 18),
            //Per interfaccia responsive, in orizzontale mostra la scritta yesterday
            child: OrientationBuilder(builder: (context, orientation) {
              final currentOrientation = MediaQuery.of(context).orientation;
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
