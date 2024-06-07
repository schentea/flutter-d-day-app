import 'package:d_day_app/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}
// st사용
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode  themeMode = ThemeMode.system;

  void changeTheme(bool isDark) {
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: Brightness.light)
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: Home(
        changeTheme: (isDark) => changeTheme(isDark),
      ));
  }
}

