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
    final semanticColors = theme.extension<AppSemanticColors>();
    return Text(
      isCorrect ? correctText : incorrectText,
      style: TextStyle(
        color: isCorrect ? semanticColors!.success : theme.colorScheme.error,
      ),
    );
  }
}
