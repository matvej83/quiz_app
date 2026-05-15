import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/quiz_repository_impl.dart';
import 'database/app_database.dart';
import 'presentation/bloc/quiz_cubit.dart';
import 'presentation/pages/quiz_page.dart';

void main() {
  final database = AppDatabase();
  final repository = QuizRepositoryImpl(database);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final QuizRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => QuizCubit(repository)..loadWords(),
        child: const QuizPage(),
      ),
    );
  }
}
