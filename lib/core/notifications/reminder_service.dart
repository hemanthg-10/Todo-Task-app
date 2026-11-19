import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class AlertTone {
  const AlertTone(this.id, this.label, this.assetPath);
  final String id;
  final String label;
  final String assetPath;
}

const List<AlertTone> alertTones = [
  AlertTone('classic', 'Classic pulse', 'assets/audio/classic_pulse.wav'),
  AlertTone('double', 'Double chime', 'assets/audio/double_chime.wav'),
  AlertTone('rising', 'Rising alert', 'assets/audio/rising_alert.wav'),
  AlertTone('soft', 'Soft bell', 'assets/audio/soft_bell.wav'),
  AlertTone('digital', 'Digital signal', 'assets/audio/digital_signal.wav'),
  AlertTone('bright', 'Bright reminder', 'assets/audio/bright_reminder.wav'),
  AlertTone('urgent', 'Urgent pattern', 'assets/audio/urgent_pattern.wav'),
];

/// Local task reminders. Android alarms can ring while the app is closed;
/// iOS uses scheduled notifications because iOS does not permit a third-party
/// app to run a looping alarm sound after the app is suspended or terminated.
class ReminderService {
  ReminderService({FlutterLocalNotificationsPlugin? notifications})
      : _notifications = notifications ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _notifications;

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    final TimezoneInfo zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));

    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _notifications.initialize(settings: settings);
    if (!kIsWeb) await Alarm.init();
  }

  Future<bool> requestPermissions() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? android = _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final bool? notificationsGranted = await android?.requestNotificationsPermission();
      final bool? exactAlarmsGranted = await android?.requestExactAlarmsPermission();
      return notificationsGranted == true && exactAlarmsGranted == true;
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final IOSFlutterLocalNotificationsPlugin? ios = _notifications
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      return await ios?.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    return false;
  }

  /// Schedules the default 15-minute-before reminder (or a per-task override).
  /// If the lead time has passed, schedule immediately only when the due time
  /// is still in the future. A past-due task is left unscheduled.
  Future<void> scheduleTaskReminder({
    required int taskId,
    required String title,
    required DateTime dueAt,
    int leadMinutes = 15,
    bool withAlarm = false,
    String toneAssetPath = 'assets/audio/classic_pulse.wav',
  }) async {
    await cancelTaskReminder(taskId);
    final DateTime now = DateTime.now();
    if (!dueAt.isAfter(now)) return;
    final DateTime proposed = dueAt.subtract(Duration(minutes: leadMinutes));
    final DateTime trigger = proposed.isAfter(now) ? proposed : now.add(const Duration(seconds: 5));
    final int notificationId = _notificationId(taskId);
    final String dueLabel = DateFormat('EEE, d MMM • h:mm a').format(dueAt);
    if (trigger.isBefore(dueAt)) await _notifications.zonedSchedule(
      id: notificationId,
      title: 'Task coming up',
      body: '$title • due $dueLabel',
      scheduledDate: tz.TZDateTime.from(trigger, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders_v2',
          'Reminders',
          channelDescription: 'Upcoming task alerts from TaskStreak',
          importance: Importance.max,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
          playSound: true,
          enableVibration: true,
          fullScreenIntent: true,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'task:$taskId',
    );

    if (!withAlarm || kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      await _notifications.zonedSchedule(
        id: _dueNotificationId(taskId),
        title: 'Task is due now',
        body: '$title • due $dueLabel',
        scheduledDate: tz.TZDateTime.from(dueAt, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_due_v2', 'Tasks due now',
            channelDescription: 'Alerts when a task reaches its due time',
            importance: Importance.max, priority: Priority.high,
            category: AndroidNotificationCategory.reminder,
            playSound: true, enableVibration: true, fullScreenIntent: true,
          ),
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'task:$taskId',
      );
    }

    if (withAlarm && !kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: _alarmId(taskId),
          dateTime: dueAt,
          volumeSettings: const VolumeSettings.fixed(),
          assetAudioPath: toneAssetPath,
          loopAudio: true,
          vibrate: true,
          androidFullScreenIntent: true,
          warningNotificationOnKill: true,
          notificationSettings: NotificationSettings(
            title: 'Task is due now',
            body: '$title • due $dueLabel',
            stopButton: 'Done',
            androidSnoozeButton: 'Snooze 1 hour',
          ),
          androidSnoozeDuration: const Duration(hours: 1),
        ),
      );
    } else if (withAlarm && !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS cannot keep a third-party looping alarm running in the background.
      // Use the local notification above; Phase 5 adds follow-up notifications.
    }
  }

  Future<void> cancelTaskReminder(int taskId) async {
    await _notifications.cancel(id: _notificationId(taskId));
    await _notifications.cancel(id: _dueNotificationId(taskId));
    if (!kIsWeb) await Alarm.stop(_alarmId(taskId));
  }

  Future<void> snoozeAndroidAlarm(int taskId, {Duration duration = const Duration(hours: 1)}) async {
    if (!kIsWeb) await Alarm.stop(_alarmId(taskId));
    if (kIsWeb) return;
    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: _alarmId(taskId),
        dateTime: DateTime.now().add(duration),
        volumeSettings: const VolumeSettings.fixed(),
        loopAudio: true,
        vibrate: true,
        notificationSettings: const NotificationSettings(
          title: 'TaskStreak alarm',
          body: 'Snoozed task reminder',
          stopButton: 'Done',
          androidSnoozeButton: 'Snooze 1 hour',
        ),
        androidSnoozeDuration: const Duration(hours: 1),
      ),
    );
  }

  int _notificationId(int taskId) => taskId * 10 + 1;
  int _dueNotificationId(int taskId) => taskId * 10 + 3;
  int _alarmId(int taskId) => taskId * 10 + 2;
}
