import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_back_button.dart';
import 'package:quiz_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:quiz_app/enums/app_enums.dart';
import 'package:quiz_app/features/history/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/translation/presentation/widgets/results_widget.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../translation_cubit/cubit.dart';
import '../translation_cubit/state.dart';
import '../widgets/completed_widget.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late TranslationCubit translationCubit;
  late HistoryCubit historyCubit;
  final controller = TextEditingController();

  @override
  void initState() {
    translationCubit = context.read<TranslationCubit>();
    historyCubit = context.read<HistoryCubit>();
    super.initState();
  }

  @override
  void deactivate() {
    translationCubit.resetData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('translationPage.screenName'.tr()),
        leading: const AppBackButton(),
      ),
      body: BlocConsumer<TranslationCubit, TranslationState>(
        listener: (context, state) {
          if (state.error?.isNotEmpty == true) {
            AppMessage.error(
              context,
              message: state.error!,
              onClose: translationCubit.disableError,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == TranslationStatus.loading;
          final isAnswered = state.status == TranslationStatus.answered;
          final isCompleted = state.status == TranslationStatus.completed;
          final currentText = state.russianText[state.currentIndex];
          return isCompleted
              ? CompletedWidget(
                  resultsWidget: Text(
                    '${'historyPage.score'.tr()}: ${state.totalScore / state.russianText.length}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  onTap: () {
                    historyCubit.addHistoryItem(
                      testType: TestType.translation,
                      correctAnswers:
                          (state.totalScore / state.russianText.length).round(),
                      totalAnswers: state.russianText.length,
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 16.0,
                    children: [
                      Text(currentText, style: theme.textTheme.titleLarge),
                      AppTextFormField(
                        controller: controller,
                        hintText: 'quizPage.inputTranslation'.tr(),
                      ),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (isAnswered) {
                                  controller.text = '';
                                  translationCubit.nextQuestion();
                                } else {
                                  translationCubit.check(
                                    userTranslation: controller.text,
                                  );
                                }
                              },
                        child: Text(
                          isAnswered
                              ? 'quizPage.next'.tr()
                              : 'quizPage.check'.tr(),
                        ),
                      ),
                      if (isLoading) const CircularProgressIndicator.adaptive(),
                      if (isAnswered && state.result != null)
                        ResultsWidget(result: state.result!),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
