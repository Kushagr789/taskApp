import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reminder.dart';
import '../viewModels/reminder_viewmodel.dart';
import '../services/notification_service.dart';

class AddEditReminderView extends ConsumerStatefulWidget {
  final Reminder? reminder;

  AddEditReminderView({this.reminder});

  @override
  _AddEditReminderViewState createState() => _AddEditReminderViewState();
}

class _AddEditReminderViewState extends ConsumerState<AddEditReminderView> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _time;
  Priority _priority = Priority.Medium;

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      _title = widget.reminder!.title;
      _description = widget.reminder!.description;
      _time = widget.reminder!.time;
      _priority = widget.reminder!.priority;
    } else {
      _time = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.reminder?.title ?? '',
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: widget.reminder?.description ?? '',
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              // DateTime picker for reminder time
              ListTile(
                title: Text('Reminder Time: ${_time.toString()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _time,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_time),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _time = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
              // Dropdown for priority
              DropdownButtonFormField<Priority>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: Priority.values.map((Priority priority) {
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Priority? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Reminder newReminder = Reminder(
                      id: widget.reminder?.id ?? UniqueKey().toString(),
                      title: _title,
                      description: _description,
                      time: _time,
                      priority: _priority,
                    );

                    if (widget.reminder == null) {
                      ref.read(reminderViewModelProvider.notifier).addReminder(newReminder);
                    } else {
                      ref.read(reminderViewModelProvider.notifier).editReminder(newReminder);
                    }

                    notificationService.scheduleNotification(newReminder);
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
