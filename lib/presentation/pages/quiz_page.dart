import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/repository/quiz_state.dart';
import 'package:quiz_app/presentation/bloc/quiz_cubit.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('English Quiz')),
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QuizCompleted) {
            return Center(
              child: Text(
                'Quiz completed: ${state.correctAnswers}/${state.totalQuestions}',
              ),
            );
          }
          if (state is QuizLoaded) {
            final current = state.words[state.currentIndex];
            final controller = TextEditingController(
              text: state.userAnswer ?? '',
            );
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      current.englishWord,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Введите перевод',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<QuizCubit>().checkAnswer(controller.text);
                      },
                      child: const Text('Проверить'),
                    ),
                    const SizedBox(height: 24),
                    if (state.answered) ...[
                      Text(state.correct ? 'Правильно' : 'Неправильно'),
                      const SizedBox(height: 8),
                      Text('Ответ: ${current.russianWord}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<QuizCubit>().nextQuestion(),
                        child: const Text('Далее'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
