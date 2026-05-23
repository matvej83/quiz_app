import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/pronounce_button.dart';

class WordWithPronounce extends StatelessWidget {
  const WordWithPronounce({
    super.key,
    required this.word,
    required this.language,
  });

  final String word;
  final String language;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final theme = Theme.of(context);
    return Row(
      spacing: 8.0,
      mainAxisAlignment: .center,
      children: [
        Text(word, style: theme.textTheme.headlineLarge),
        PronounceButton(
          onTap: () {
            cubit.pronounceWord(word, language: language);
          },
        ),
      ],
    );
  }
}
