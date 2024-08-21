import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/habit.dart';
import 'package:uuid/uuid.dart';

class NewHabitPage extends ConsumerStatefulWidget {
  const NewHabitPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewHabitPageState();
}

class _NewHabitPageState extends ConsumerState<NewHabitPage> {
  late final _formKey = GlobalKey<FormState>();
  late TextEditingController _ctrlName;
  late TextEditingController _ctrlDesc;

  @override
  void initState() {
    _ctrlName = TextEditingController();
    _ctrlDesc = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _ctrlName.dispose();
    _ctrlDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create habit'),
        actions: [
          TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref.watch(habitsProvider.notifier).addHabit(Habit(
                      id: const Uuid().v4(),
                      name: _ctrlName.text,
                      description:
                          _ctrlDesc.text.trim().isEmpty ? null : _ctrlDesc.text,
                    ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ctrlName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Cannot be blank';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ctrlDesc,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                // validator: (value) {
                //   if (value == null || value.isEmpty || value.trim().isEmpty) {
                //     return 'Cannot be blank';
                //   }
                //   return null;
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
