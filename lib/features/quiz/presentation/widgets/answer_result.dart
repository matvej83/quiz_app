import 'package:flutter/material.dart';
import 'package:quiz_app/app/theme/app_semantic_colors.dart';

class AnswerResult extends StatelessWidget {
  const AnswerResult({
    super.key,
    required this.isCorrect,
    this.correctText = 'Правильно',
    this.incorrectText = 'Неправильно',
  });

  final bool isCorrect;
  final String correctText;
  final String incorrectText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      isCorrect ? correctText : incorrectText,
      style: TextStyle(
        color: isCorrect
            ? theme.extension<AppSemanticColors>()!.success
            : theme.colorScheme.error,
      ),
    );
  }
}
