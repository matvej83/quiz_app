import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/utils/extensions.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/completed_widget.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/page_wrapper.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../app/theme/app_semantic_colors.dart';
import '../../../../enums/app_enums.dart';
import '../bloc/quiz_cubit.dart';
import '../widgets/answers_block.dart';
import '../widgets/pronounce_button.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

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
        final answer = cubit.type == TranslationType.enRu
            ? current.russianWord
            : current.englishWord;
        final tmp = [...state.additionalWords]..shuffle();
        final additionalWords = tmp.take(3).toList();
        additionalWords.add(answer);
        additionalWords.shuffle();
        return Column(
          crossAxisAlignment: .center,
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
                    cubit.pronounceWord(
                      current.questionFor(cubit.type),
                      language: cubit.type == TranslationType.enRu
                          ? AppConstants.enLocale
                          : AppConstants.ruLocale,
                    );
                  },
                ),
              ],
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
              Text('Выбранный ответ: ${state.userAnswer}'),
              Text('Правильный ответ: ${current.answerFor(cubit.type)}'),
              ElevatedButton(
                onPressed: cubit.nextQuestion,
                child: const Text('Далее'),
              ),
            ] else ...[
              Text('Выберите ответ:', style: theme.textTheme.bodyMedium),
              AnswersBlock(
                words: additionalWords,
                onSelected: (word) {
                  cubit.checkAnswer(word);
                },
              ),
            ],
            Text(
              '${state.currentIndex + 1} / ${state.words.length}',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        );
      },
    );
  }
}
