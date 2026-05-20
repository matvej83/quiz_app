import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/asset_paths.dart';
import '../../../../app/theme/app_semantic_colors.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({
    super.key,
    required this.cup,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  final String cup;
  final int correctAnswers;
  final int totalQuestions;

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  Uint8List? _gifBytes;

  @override
  void initState() {
    super.initState();
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
    return Stack(
      alignment: .center,
      children: [
        if (_gifBytes != null) Image.memory(_gifBytes!),
        Column(
          spacing: 8.0,
          mainAxisAlignment: .center,
          children: [
            Image.asset(widget.cup, height: 120.0),
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
                  'правильные ответы: ${widget.correctAnswers}',
                  style: TextStyle(
                    color: theme.extension<AppSemanticColors>()!.success,
                  ),
                ),
                Text(
                  'неправильные ответы: ${widget.totalQuestions - widget.correctAnswers}',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                Text('всего вопросов: ${widget.totalQuestions}'),
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
}
