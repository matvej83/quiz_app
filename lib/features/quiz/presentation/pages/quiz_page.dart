import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:quiz_app/core/utils/extensions.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/completed_widget.dart';

import '../../../../app/theme/app_semantic_colors.dart';
import '../bloc/quiz_cubit.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/pronounce_button.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<QuizCubit>();
    return PageWrapper(
      backgroundColor: theme.scaffoldBackgroundColor,
      onCompleted: (state) {
        final cup = cubit.getCup(
          total: state.totalQuestions,
          correct: state.correctAnswers,
        );
        return CompletedWidget(
          cup: cup,
          correctAnswers: state.correctAnswers,
          totalQuestions: state.totalQuestions,
        );
      },
      onLoaded: (state) {
        final current = state.words[state.currentIndex];
        final controller = TextEditingController(text: state.userAnswer ?? '');
        return Padding(
          padding: const .all(16),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 16.0,
            children: [
              Row(
                spacing: 8.0,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    current.questionFor(cubit.type),
                    style: theme.textTheme.headlineLarge,
                  ),
                  PronounceButton(
                    onTap: () {
                      cubit.pronounceWord(current.questionFor(cubit.type));
                    },
                  ),
                ],
              ),
              AppTextFormField(
                enabled: !state.answered,
                controller: controller,
                keyboardType: .text,
                decoration: const InputDecoration(hintText: 'Введите перевод'),
              ),
              if (!state.answered)
                ElevatedButton(
                  onPressed: () {
                    cubit.checkAnswer(controller.text);
                  },
                  child: const Text('Проверить'),
                ),
              if (state.answered) ...[
                Text(
                  state.correct ? 'Правильно' : 'Неправильно',
                  style: TextStyle(
                    color: state.correct
                        ? theme.extension<AppSemanticColors>()!.success
                        : theme.colorScheme.error,
                  ),
                ),
                Text('Правильный ответ: ${current.answerFor(cubit.type)}'),
                ElevatedButton(
                  onPressed: cubit.nextQuestion,
                  child: const Text('Далее'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
