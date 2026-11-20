import 'package:birthday/features/birthdays/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les anniversaires',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color.fromARGB(255, 132, 255, 0)),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(112, 12, 0, 121),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}
