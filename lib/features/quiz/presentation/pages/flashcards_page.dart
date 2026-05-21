import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/page_wrapper.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../app/theme/app_semantic_colors.dart';
import '../../../../core/presentation/widgets/smooth_flip_card.dart';
import '../../../../enums/app_enums.dart';
import '../bloc/quiz_cubit.dart';
import '../widgets/pronounce_button.dart';

class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final theme = Theme.of(context);
    return PageWrapper(
      backgroundColor: theme.scaffoldBackgroundColor,
      onCompleted: (state) {
        return Center(
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: .center,
            children: [
              Icon(
                Icons.check_circle_outline_outlined,
                size: 80.0,
                color: theme.extension<AppSemanticColors>()!.success,
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
        );
      },
      onLoaded: (state) {
        final current = state.words[state.currentIndex];
        return Padding(
          padding: const .all(16.0),
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              SmoothFlipCard(
                front: (flip) {
                  return GestureDetector(
                    onTap: flip,
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Card(
                        elevation: 4,
                        color: theme
                            .inputDecorationTheme
                            .disabledBorder
                            ?.borderSide
                            .color,
                        child: Row(
                          spacing: 8.0,
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              cubit.type == TranslationType.enRu
                                  ? current.englishWord
                                  : current.russianWord,
                              style: theme.textTheme.headlineLarge,
                            ),
                            PronounceButton(
                              onTap: () {
                                context.read<QuizCubit>().pronounceWord(
                                  cubit.type == TranslationType.enRu
                                      ? current.englishWord
                                      : current.russianWord,
                                  language: cubit.type == TranslationType.enRu
                                      ? AppConstants.enLocale
                                      : AppConstants.ruLocale,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                back: (flip) {
                  return GestureDetector(
                    onTap: flip,
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Card(
                        elevation: 4,
                        color: theme
                            .inputDecorationTheme
                            .disabledBorder
                            ?.borderSide
                            .color,
                        child: Row(
                          spacing: 8.0,
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              cubit.type == TranslationType.enRu
                                  ? current.russianWord
                                  : current.englishWord,
                              style: theme.textTheme.headlineLarge,
                            ),
                            PronounceButton(
                              onTap: () {
                                context.read<QuizCubit>().pronounceWord(
                                  cubit.type == TranslationType.enRu
                                      ? current.russianWord
                                      : current.englishWord,
                                  language: cubit.type == TranslationType.enRu
                                      ? AppConstants.ruLocale
                                      : AppConstants.enLocale,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                spacing: 16.0,
                mainAxisAlignment: .spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: state.currentIndex != 0
                        ? () => context.read<QuizCubit>().previousQuestion()
                        : null,
                    child: const Icon(Icons.arrow_back_outlined),
                  ),
                  Text(
                    '${state.currentIndex + 1} / ${state.words.length}',
                    style: theme.textTheme.bodyLarge,
                  ),
                  ElevatedButton(
                    onPressed: state.currentIndex != state.words.length - 1
                        ? () => context.read<QuizCubit>().nextQuestion()
                        : null,
                    child: const Icon(Icons.arrow_forward_outlined),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
