import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_back_button.dart';
import 'package:quiz_app/features/translation/presentation/cubit/cubit.dart';

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
      body: BlocBuilder<TranslationCubit, TranslationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(russianText, style: const TextStyle(fontSize: 22)),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'quizPage.inputTranslation'.tr(),
                  ),
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 20),

                if (state.isLoading) const CircularProgressIndicator(),

                if (state.result != null)
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          '${'translationPage.estimation'.tr()}: ${state.result!.score}/100',
                        ),

                        const SizedBox(height: 12),

                        Text('${'translationPage.correctTranslation'.tr()}:'),

                        Text(
                          state.result!.correctTranslation,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                            subtitle: Text('${e.suggestion}\n${e.reason}'),
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
