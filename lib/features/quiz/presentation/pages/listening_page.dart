import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/constants/app_constants.dart';
import 'package:quiz_app/core/presentation/widgets/scrolled_wrapper.dart';

import '../../../../core/presentation/widgets/one_field_form.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../enums/app_enums.dart';
import '../../../history/presentation/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../widgets/answer_result.dart';
import '../widgets/completed_widget.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/pronounce_button.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
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
        return ScrolledWrapper(
          children: [
            Text(
              'listeningPage.listenAndWrite'.tr(),
              style: theme.textTheme.bodyMedium,
            ),
            Row(
              spacing: 8.0,
              mainAxisAlignment: .center,
              children: [
                Text(
                  '${state.currentIndex + 1} / ${state.words.length}',
                  style: theme.textTheme.bodyLarge,
                ),
                PronounceButton(
                  onTap: () {
                    cubit.pronounceWord(
                      current.englishWord,
                      language: AppConstants.enLocale,
                    );
                  },
                ),
              ],
            ),
            OneFieldForm(
              formKey: _formKey,
              enabled: !state.answered,
              controller: _controller,
              hint: 'listeningPage.inputWord'.tr(),
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
              ),
            ],
          ],
        );
      },
    );
  }
}
