import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('Box');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          primary: Colors.yellow,
          secondary: Colors.yellow[300],
        ),
      ),
      home: const HomePage(),
    );
  }
}
