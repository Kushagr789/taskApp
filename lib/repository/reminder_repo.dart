import 'package:riverpod/riverpod.dart';
import '../models/reminder.dart';

class ReminderRepository {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
  }

  void editReminder(Reminder updatedReminder) {
    _reminders = _reminders.map((r) => r.id == updatedReminder.id ? updatedReminder : r).toList();
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
  }
}

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository();
});
