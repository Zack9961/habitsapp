import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/habit.dart';

class EditHabitPage extends ConsumerStatefulWidget {
  final String habitId;

  const EditHabitPage(this.habitId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditHabitPageState();
}

class _EditHabitPageState extends ConsumerState<EditHabitPage> {
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
    final habit = ref.watch(specificHabitProvider(widget.habitId));
    _ctrlName.text = habit.name;
    _ctrlDesc.text = habit.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit habit'),
        actions: [
          TextButton(
            child: const Text('SAVE'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await ref.watch(habitsProvider.notifier).updateHabit(Habit(
                    id: habit.id,
                    name: _ctrlName.text,
                    description:
                        _ctrlDesc.text.trim().isEmpty ? '' : _ctrlDesc.text,
                    completionDates: habit.completionDates));
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
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
                  labelText: 'Habit Name',
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
                  labelText: 'Habit Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
