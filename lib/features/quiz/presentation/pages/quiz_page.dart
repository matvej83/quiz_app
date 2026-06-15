import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/scrolled_wrapper.dart';
import 'package:quiz_app/core/utils/extensions.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/answer_result.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/completed_widget.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/word_with_pronounce.dart';

import '../../../../core/presentation/widgets/one_field_form.dart';
import '../../../../enums/app_enums.dart';
import '../../../history/presentation/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../widgets/page_wrapper.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

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
          incorrectAnswers: state.totalQuestions - state.correctAnswers,
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
        return ScrolledWrapper(
          children: [
            Text(
              '${state.currentIndex + 1} / ${state.words.length}',
              style: theme.textTheme.bodyLarge,
            ),
            WordWithPronounce(
              word: current.questionFor(cubit.type),
              language: cubit.type.questionFor,
            ),
            OneFieldForm(
              formKey: _formKey,
              enabled: !state.answered,
              controller: _controller,
              hint: 'quizPage.inputTranslation'.tr(),
            ),
            if (!state.answered) ...[
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    cubit.checkAnswer(_controller.text);
                  }
                },
                child: Text('quizPage.check'.tr()),
              ),
              const SizedBox(height: 56.0),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  cubit.nextQuestion();
                  _controller.text = '';
                },
                child: Text('quizPage.next'.tr()),
              ),
              AnswerResult(isCorrect: state.correct),
              Text(
                '${'quizPage.correctAnswer'.tr()}: ${current.answerFor(cubit.type)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
