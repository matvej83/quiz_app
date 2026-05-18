import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:quiz_app/enums/app_enums.dart';

import '../../../../app/theme/app_semantic_colors.dart';
import '../bloc/quiz_cubit.dart';
import '../bloc/quiz_state.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizCubit cubit;
  Uint8List? _gifBytes;

  @override
  void initState() {
    super.initState();
    cubit = context.read<QuizCubit>();
    rootBundle.load(AssetPaths.congratsAnimation).then((data) {
      if (mounted) {
        setState(() {
          _gifBytes = data.buffer.asUint8List();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QuizCompleted) {
            final cup = cubit.getCup(
              total: state.totalQuestions,
              correct: state.correctAnswers,
            );
            return Stack(
              alignment: .center,
              children: [
                if (_gifBytes != null) Image.memory(_gifBytes!),
                Column(
                  spacing: 8.0,
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(cup, height: 120.0),
                    Text(
                      'Поздравляем!\nQuiz завершен!',
                      style: theme.textTheme.headlineSmall,
                      textAlign: .center,
                    ),
                    Column(
                      crossAxisAlignment: .end,
                      spacing: 8.0,
                      children: [
                        Text(
                          'правильные ответы: ${state.correctAnswers}',
                          style: TextStyle(
                            color: theme
                                .extension<AppSemanticColors>()!
                                .success,
                          ),
                        ),
                        Text(
                          'неправильные ответы: ${state.totalQuestions - state.correctAnswers}',
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                        Text('всего вопросов: ${state.totalQuestions}'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      child: const Text('Готово'),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is QuizLoaded) {
            final current = state.words[state.currentIndex];
            final controller = TextEditingController(
              text: state.userAnswer ?? '',
            );
            return Padding(
              padding: const .all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      spacing: 8.0,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          cubit.type == TranslationType.enRu
                              ? current.englishWord
                              : current.russianWord,
                          style: theme.textTheme.headlineLarge,
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<QuizCubit>().pronounceWord(
                              cubit.type == TranslationType.enRu
                                  ? current.englishWord
                                  : current.russianWord,
                            );
                          },
                          icon: const Icon(Icons.mic),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppTextFormField(
                      controller: controller,
                      keyboardType: .text,
                      decoration: const InputDecoration(
                        hintText: 'Введите перевод',
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
                      Text(
                        state.correct ? 'Правильно' : 'Неправильно',
                        style: TextStyle(
                          color: state.correct
                              ? theme.extension<AppSemanticColors>()!.success
                              : theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ответ: ${cubit.type == TranslationType.enRu ? current.russianWord : current.englishWord}',
                      ),
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
