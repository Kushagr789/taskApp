// lib/screens/reminder_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/views/edit_reminder.dart';
import '../models/reminder.dart';
import '../viewmodels/reminder_viewmodel.dart';

class ReminderListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(reminderViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddEditReminderView()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (ctx, index) {
          final reminder = reminders[index];
          return ListTile(
            title: Text(reminder.title),
            subtitle: Text(reminder.description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => ref.read(reminderViewModelProvider.notifier).deleteReminder(reminder.id),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddEditReminderView(reminder: reminder,)));
            },
          );
        },
      ),
    );
  }
}
