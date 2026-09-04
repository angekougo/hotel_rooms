import 'package:flutter/material.dart';

import 'routes/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HotelRoomApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.light),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orange, foregroundColor: Colors.white),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark),
      ),
      themeMode: _themeMode,
      routerConfig: appRouter,
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.small(
            onPressed: _toggleTheme,
            child: Icon(_themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
          ),
          body: child,
        );
      },
    );
  }
}
