import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

final _plugin = FlutterLocalNotificationsPlugin();

// Initialise les notifications
Future<void> initNotifications() async {
  tz.initializeTimeZones();

  final timezoneInfo = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

  const settings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  await _plugin.initialize(settings: settings);
  // Android 13+ : la permission doit être demandée à l'utilisateur
  await Permission.notification.request();
}

// Test des notifications
Future<void> welcomeNotification() async {
  await _plugin.cancelAll();

  final date = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

  const details = NotificationDetails(
    android: AndroidNotificationDetails(
      'test',
      'Test',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  await _plugin.zonedSchedule(
    id: 1,
    title: 'Bienvenu sur Birthday !',
    body: 'Un anniversaire à fêter ? ',
    scheduledDate: date,
    notificationDetails: details,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  );
}

// Notification Anniversaire

// Future<void> programmerAnniversaires(List<Birthday> birthdays) async {
//   await _plugin.cancelAll();
// }
