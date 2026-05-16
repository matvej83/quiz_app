import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/presentation/pages/quiz_page.dart';

import '../features/quiz/presentation/bloc/quiz_cubit.dart';
import 'di/injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => getIt<QuizCubit>()..loadWords(),
        child: const QuizPage(),
      ),
    );
  }
}
