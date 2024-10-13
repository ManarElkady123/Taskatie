// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskatie/core/model/task_model.dart';
import 'package:taskatie/core/services/local_storage.dart';
import 'package:taskatie/core/utils/theme.dart';
import 'package:taskatie/feature/upload/splash.dart';

void main() async {

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all bindings are initialized before running the app.

  await Hive.initFlutter();

  Hive.registerAdapter(
      TaskModelAdapter()); // Register the adapter before opening the box

  await Hive.openBox('userBox');
  await Hive.openBox<TaskModel>(
      'tasksBox'); // Now open the box after the adapter registration

  await AppLocalStorage.init(); // Initialize local storage

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppLocalStorage.userBox.listenable(),
      builder: (context, box, Widget) {
        var isDark = AppLocalStorage.getCacheData('isDark') ?? false ;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDark
              ? ThemeMode.dark
              : ThemeMode.light,

          // theme: ThemeData.light(useMaterial3: true),
          theme: AppThemes.LightTheme,
          ////////////
           darkTheme: AppThemes.DarkTheme, 

          home: Splash(),
        );
      },
    );
  }
}
