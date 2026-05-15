import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'features/quiz/quiz_page.dart';

void main() {
  final database = AppDatabase();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QuizPage(database: database));
  }
}
