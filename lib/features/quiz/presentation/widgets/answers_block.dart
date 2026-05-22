import 'package:flutter/material.dart';

class AnswersBlock extends StatelessWidget {
  const AnswersBlock({
    super.key,
    required this.words,
    required this.onSelected,
  });

  final List<String> words;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;
    return GridView.builder(
      itemCount: words.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 5,
      ),
      itemBuilder: (ctx, index) {
        final word = words[index];
        return OutlinedButton(
          onPressed: () {
            onSelected(word);
          },
          child: Text(word, style: textStyle),
        );
      },
    );
  }
}
