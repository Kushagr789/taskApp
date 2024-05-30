import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reminder.dart';
import '../repository/reminder_repo.dart';

class ReminderViewModel extends StateNotifier<List<Reminder>> {
  ReminderViewModel(this.ref) : super(ref.read(reminderRepositoryProvider).reminders);

  final Ref ref;

  void addReminder(Reminder reminder) {
    ref.read(reminderRepositoryProvider).addReminder(reminder);
    state = ref.read(reminderRepositoryProvider).reminders;
  }

  void editReminder(Reminder reminder) {
    ref.read(reminderRepositoryProvider).editReminder(reminder);
    state = ref.read(reminderRepositoryProvider).reminders;
  }

  void deleteReminder(String id) {
    ref.read(reminderRepositoryProvider).deleteReminder(id);
    state = ref.read(reminderRepositoryProvider).reminders;
  }
}

final reminderViewModelProvider = StateNotifierProvider<ReminderViewModel, List<Reminder>>((ref) {
  return ReminderViewModel(ref);
});
