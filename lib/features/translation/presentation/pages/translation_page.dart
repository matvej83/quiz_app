import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_back_button.dart';
import 'package:quiz_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:quiz_app/features/translation/presentation/cubit/cubit.dart';

import '../../../../core/presentation/widgets/app_message.dart';
import '../cubit/state.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final controller = TextEditingController();
  final russianText = 'Я люблю программировать на Flutter';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TranslationCubit>();
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
              onClose: cubit.disableError,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16.0,
              children: [
                Text(russianText, style: theme.textTheme.titleLarge),
                AppTextFormField(
                  controller: controller,
                  hintText: 'quizPage.inputTranslation'.tr(),
                ),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          cubit.check(
                            russianText: russianText,
                            userTranslation: controller.text,
                          );
                        },
                  child: Text('quizPage.check'.tr()),
                ),
                if (state.isLoading) const CircularProgressIndicator.adaptive(),
                if (state.result != null)
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          '${'translationPage.estimation'.tr()}: ${state.result!.score}/100',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${'translationPage.correctTranslation'.tr()}:',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          state.result!.correctTranslation,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text('${'errors.errors'.tr()}:'),
                        ...state.result!.mistakes.map(
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
                                Text(
                                  e.reason,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
