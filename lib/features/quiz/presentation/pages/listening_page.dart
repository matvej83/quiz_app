import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/constants/app_constants.dart';

import '../../../../core/presentation/widgets/app_text_form_field.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../enums/app_enums.dart';
import '../../../history/presentation/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../widgets/answer_result.dart';
import '../widgets/completed_widget.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/pronounce_button.dart';

class ListeningPage extends StatelessWidget {
  const ListeningPage({super.key});

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
          completedText: 'listeningPage.listeningCompleted'.tr(),
          correctAnswers: state.correctAnswers,
          incorrectAnswers: state.totalQuestions - state.correctAnswers,
          totalQuestions: state.totalQuestions,
          onTap: () {
            context.read<HistoryCubit>().addHistoryItem(
              testType: TestType.listening,
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
              Text(
                'listeningPage.listenAndWrite'.tr(),
                style: theme.textTheme.bodyMedium,
              ),
              PronounceButton(
                onTap: () {
                  cubit.pronounceWord(
                    current.englishWord,
                    language: AppConstants.enLocale,
                  );
                },
              ),
              AppTextFormField(
                enabled: !state.answered,
                controller: controller,
                keyboardType: .text,
                decoration: InputDecoration(
                  hintText: 'listeningPage.inputWord'.tr(),
                ),
              ),
              if (!state.answered) ...[
                const SizedBox(height: 56.0),
                ElevatedButton(
                  onPressed: () {
                    cubit.checkAnswer(controller.text);
                  },
                  child: Text('quizPage.check'.tr()),
                ),
              ] else ...[
                AnswerResult(isCorrect: state.correct),
                Text(
                  '${'quizPage.correctAnswer'.tr()}: ${current.answerFor(cubit.type)}',
                ),
                ElevatedButton(
                  onPressed: cubit.nextQuestion,
                  child: Text('quizPage.next'.tr()),
                ),
              ],
              Text(
                '${state.currentIndex + 1} / ${state.words.length}',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
