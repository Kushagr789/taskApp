class Reminder {
  String id;
  String title;
  String description;
  DateTime time;
  Priority priority;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.priority,
  });
}

enum Priority { High, Medium, Low }
