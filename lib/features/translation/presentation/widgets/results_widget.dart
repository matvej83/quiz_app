import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/translation_check_result_entity.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key, required this.result});

  final TranslationCheckResultEntity result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView(
        children: [
          Text(
            '${'translationPage.estimation'.tr()}: ${result.score}/100',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            '${'translationPage.correctTranslation'.tr()}:',
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            result.correctTranslation,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text('${'errors.errors'.tr()}:'),
          ...result.mistakes.map(
            (e) => ListTile(
              leading: Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
              ),
              title: Text(
                e.word,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    e.suggestion,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(e.reason, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
