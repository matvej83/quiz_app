import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/utils/extensions.dart';
// Removed unused HistoryCubit import
import 'package:quiz_app/features/quiz/presentation/widgets/page_wrapper.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quiz_completed_widget.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/word_with_pronounce.dart';

import '../../../../enums/app_enums.dart';
import '../cubit/cubit.dart';
import '../widgets/answer_result.dart';
import '../widgets/answers_block.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<QuizCubit>();
    return PageWrapper(
      backgroundColor: theme.scaffoldBackgroundColor,
      onCompleted: (state) {
        return QuizCompletedWidget(
          state: state,
          testType: TestType.test,
          completedTextKey: 'testPage.testCompleted',
        );
      },
      onLoaded: (state) {
        final current = state.words[state.currentIndex];
        final answered = state.answered;
        return Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          spacing: 16.0,
          children: [
            WordWithPronounce(
              word: current.questionFor(cubit.type),
              language: cubit.type.questionFor,
            ),
            if (answered) ...[
              AnswerResult(isCorrect: state.correct),
            ] else ...[
              Text(
                '${'testPage.selectAnswer'.tr()}:',
                style: theme.textTheme.bodyMedium,
              ),
            ],
            AnswersBlock(
              selectedAnswer: state.userAnswer ?? '',
              correctAnswer: answered ? current.answerFor(cubit.type) : '',
              words: state.answers,
              answered: answered,
              onSelected: (word) {
                cubit.checkAnswer(word, goToNext: true);
              },
            ),
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
