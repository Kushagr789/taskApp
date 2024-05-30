import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../models/reminder.dart';

class NotificationService {
  NotificationService() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon', // app icon resource path
      [
        NotificationChannel(
          channelKey: 'reminder_channel',
          channelName: 'Reminder notifications',
          channelDescription: 'Notification channel for reminders',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
        )
      ],
      debug: true,
    );
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'reminder_channel',
        title: reminder.title,
        body: reminder.description,
        notificationLayout: NotificationLayout.Default,
        icon: 'resource://drawable/task',
      ),
      schedule: NotificationCalendar.fromDate(date: reminder.time),
    );
  }
}

final notificationService = NotificationService();
