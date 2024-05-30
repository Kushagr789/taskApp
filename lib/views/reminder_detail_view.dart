import 'package:flutter/material.dart';
import '../models/reminder.dart';
import 'edit_reminder.dart';

class ReminderDetailView extends StatelessWidget {
  final Reminder reminder;

  ReminderDetailView({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditReminderView(reminder: reminder),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(reminder.description),
            SizedBox(height: 10),
            Text(
              'Time',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(reminder.time.toString()),
            SizedBox(height: 10),
            Text(
              'Priority',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(reminder.priority.toString().split('.').last),
          ],
        ),
      ),
    );
  }
}
