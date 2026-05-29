import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:quiz_app/core/utils/extensions.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/answer_result.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/completed_widget.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/word_with_pronounce.dart';

import '../../../../enums/app_enums.dart';
import '../../../history/presentation/cubit/cubit.dart';
import '../bloc/quiz_cubit.dart';
import '../widgets/page_wrapper.dart';

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
          onTap: () {
            context.read<HistoryCubit>().addHistoryItem(
              testType: TestType.translate,
              correctAnswers: state.correctAnswers,
              totalAnswers: state.totalQuestions,
            );
          },
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
              WordWithPronounce(
                word: current.questionFor(cubit.type),
                language: cubit.type.questionFor,
              ),
              AppTextFormField(
                enabled: !state.answered,
                controller: controller,
                keyboardType: .text,
                decoration: InputDecoration(
                  hintText: 'quizPage.inputTranslation'.tr(),
                ),
              ),
              if (!state.answered)
                ElevatedButton(
                  onPressed: () {
                    cubit.checkAnswer(controller.text);
                  },
                  child: Text('quizPage.check'.tr()),
                ),
              if (state.answered) ...[
                AnswerResult(isCorrect: state.correct),
                Text(
                  '${'quizPage.correctAnswer'.tr()}: ${current.answerFor(cubit.type)}',
                ),
                ElevatedButton(
                  onPressed: cubit.nextQuestion,
                  child: Text('quizPage.next'.tr()),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
