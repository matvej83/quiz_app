import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_constants.dart';
import '../../../../app/theme/app_semantic_colors.dart';
import '../../../../core/presentation/widgets/smooth_flip_card.dart';
import '../../../../enums/app_enums.dart';
import '../bloc/quiz_cubit.dart';
import '../bloc/quiz_state.dart';
import '../widgets/pronounce_button.dart';

class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          log(state.toString());
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is QuizCompleted) {
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
          }
          if (state is QuizLoaded) {
            final current = state.words[state.currentIndex];
            return Padding(
              padding: const .all(16.0),
              child: Column(
                crossAxisAlignment: .center,
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
                                      language:
                                          cubit.type == TranslationType.enRu
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
                                      language:
                                          cubit.type == TranslationType.enRu
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
                        onPressed: () =>
                            context.read<QuizCubit>().previousQuestion(),
                        child: const Icon(Icons.arrow_back_outlined),
                      ),
                      Text(
                        '${state.currentIndex + 1} / ${state.words.length}',
                        style: theme.textTheme.bodyLarge,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<QuizCubit>().nextQuestion(),
                        child: const Icon(Icons.arrow_forward_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
