import 'package:birthday/app.dart';
import 'package:birthday/features/birthdays/notifications/birthday_notifications.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  await welcomeNotification();
  runApp(const MyApp());
}
